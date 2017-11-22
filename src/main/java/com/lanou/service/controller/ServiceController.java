package com.lanou.service.controller;

import com.lanou.service.domain.Services;
import com.lanou.service.service.ServiceService;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Created by dllo on 17/11/17.
 */
@Controller
@RequestMapping("/service")
public class ServiceController {

    @Qualifier("serviceService")
    @Autowired
    private ServiceService serviceService;

    // 查询所有
    @RequestMapping("/service_list")
    public String service_list(Integer pc, Model model, Services services,String idcard_no, HttpSession session) {

        // 高级查询条件判空
        if (services.getStatus() != null || services.getOs_username() != null || services.getUnix_host() != null || idcard_no != null) {
            if (idcard_no != ""){
                services.getAccount().setIdcard_no(idcard_no);
            }
            session.setAttribute("services", services);
        }
        Services services1 = new Services();
        if (session.getAttribute("services") != null) {
            services1 = (Services) session.getAttribute("services");
        }
        // 分页
        if (pc == null) {
            pc = 1;
        }
        int ps = 3;

        PageBean<Services> pb = serviceService.findAll(pc, ps, services1);
        model.addAttribute("pb", pb);
        return "service/service_list";
    }


}
