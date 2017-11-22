package com.lanou.fee.controller;

import com.lanou.fee.domain.Cost;
import com.lanou.util.AjaxLoginResult;
import com.lanou.fee.service.CostService;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


/**
 * Created by dllo on 17/11/13.
 */
@Controller
@RequestMapping("/fee")
public class FeeController {

    @Qualifier("costService")
    @Autowired
    private CostService costService;

    // 查询所有
    @RequestMapping(value = "/fee_list")
    public String feeList(Integer pc, Model model, String str, String sort, HttpServletRequest request, HttpSession session) {
        System.out.println("sort:"+sort);
        if (pc == null) {
            pc = 1;
        }
        int ps = 3;
        if (sort == ""){
            sort =null;
        }
        if (str == ""){
            str =null;
        }
        System.out.println("pc:" + pc);
        // str,sort:排序
        PageBean<Cost> pb = costService.findAll(pc, ps, str);
        model.addAttribute("pb", pb);
        request.setAttribute("sort",sort);
        session.setAttribute("str",str);
        System.out.println("cost:" + pb.getBeanList());
        return "fee/fee_list";
    }

    @RequestMapping("/feeAdd")
    public String feeAdd() {
        return "fee/fee_add";
    }

    // 增加
    @ResponseBody
    @RequestMapping("/fee_add")
    public AjaxLoginResult<Cost> fee_add(Cost cost) {
        System.out.println("cost::"+cost);
        AjaxLoginResult<Cost> result = new AjaxLoginResult<Cost>();
        String name = cost.getNAME();
        System.out.println("name:"+name);
        Cost cost1 = costService.findByName(name);
        if (cost1 == null){
            costService.save(cost);
            result.setErrorCode(0);
            result.setMessage("添加成功!");
            return result;
        }else {
            result.setErrorCode(404);
        }

        return result;
    }

    // 删除
    @ResponseBody
    @RequestMapping("/fee_delete")
    public AjaxLoginResult<Cost> fee_delete(Integer id){
        System.out.println("id:"+id);
        AjaxLoginResult<Cost> result = new AjaxLoginResult<Cost>();
        int num = costService.delete(id);
        System.out.println("num:"+num);
        if (num == 1){
            result.setErrorCode(0);
            return result;
        }else {
            result.setErrorCode(404);
        }
        return result;
    }

    // 修改(跳转 回显)
    @RequestMapping("/feeModi")
    public String feeModi(Integer cost_id,Model model){

        Cost cost = costService.findById(cost_id);
        model.addAttribute("cost",cost);
        return "fee/fee_modi";
    }
    // 开始
    @ResponseBody
    @RequestMapping("/fee_start")
    public AjaxLoginResult<Cost> startFee(Integer id){
        System.out.println("id:" +id);
        AjaxLoginResult<Cost> result = new AjaxLoginResult<Cost>();
        int num = costService.updateById(id);
        if (num == 1){
            result.setErrorCode(0);
            return result;
        }else {
            result.setErrorCode(404);
        }
        return result;
    }


    // 修改
    @ResponseBody
    @RequestMapping("/fee_modi")
    public AjaxLoginResult<Cost> fee_modi(Cost cost){
        AjaxLoginResult<Cost> result = new AjaxLoginResult<Cost>();
        System.out.println(cost);
        Cost cost1 = costService.findById(cost.getCOST_ID());
        cost1.setNAME(cost.getNAME());
        cost1.setBASE_COST(cost.getBASE_COST());
        cost1.setBASE_DURATION(cost.getBASE_DURATION());
        cost1.setUNIT_COST(cost.getUNIT_COST());
        cost1.setCOST_TYPE(cost.getCOST_TYPE());
        cost1.setDESCR(cost.getDESCR());

        int num = costService.update(cost1);
        if (num == 1){
            result.setErrorCode(0);
            return result;
        }else {
            result.setErrorCode(404);
        }
        return result;
    }
}
