package com.lanou.account.controller;

import com.lanou.account.domain.Account;
import com.lanou.account.service.AccountService;
import com.lanou.util.AjaxLoginResult;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.regex.Pattern;

/**
 * Created by dllo on 17/11/15.
 */
@Controller
@RequestMapping("/account")
public class AccountController {

    @Qualifier("accountService")
    @Autowired
    private AccountService accountService;

    @RequestMapping("/account_list")
    public String accountList(Integer pc, Model model,Account account,HttpSession session) {
        System.out.println("account1:" + account);
        if (account.getStatus() != null || account.getLogin_name() != null || account.getReal_name() != null || account.getIdcard_no() != null){
            session.setAttribute("account",account);
        }
        Account account1 = new Account();
        if (session.getAttribute("account") != null) {
            account1 = (Account) session.getAttribute("account");
        }
        if (pc == null) {
            pc = 1;
        }
        int ps = 3;
        System.out.println("pc:" + pc);
        System.out.println("account2:" + account);
        PageBean<Account> pb = accountService.findAll(pc, ps ,account1);
        model.addAttribute("pb", pb);
        return "account/account_list";
    }

    @RequestMapping("/accountAdd")
    public String accountAdd(HttpSession session,Model model){

        if (session.getAttribute("passError") != null){
            model.addAttribute("passError",session.getAttribute("passError"));
            session.invalidate();
        }else if (session.getAttribute("telephError") != null){
            model.addAttribute("telephError",session.getAttribute("telephError"));
            session.invalidate();
        }
        return "account/account_add";
    }

    @ResponseBody
    @RequestMapping("/account_add")
    public AjaxLoginResult<Account> account_add(Account account,String relogin_passwd,
                                                String reIdcard_no,
                                                HttpSession session){
        if (!reIdcard_no.equals("")){
            Account reAccount = accountService.findByIdCard(reIdcard_no);
            account.setRecommender_id(reAccount.getAccount_id());
        }

        AjaxLoginResult<Account> result = new AjaxLoginResult<Account>();
        if (!relogin_passwd.equals(account.getLogin_passwd())){
            result.setErrorCode(202);
            session.setAttribute("passError","重复密码与原密码不一致!请重新输入");
            return result;
        }
        String cellphone = "^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$";
        String telephone = "^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$";
        if (isMatch(cellphone,account.getTelephone()) || isMatch(telephone,account.getTelephone())){
            Account account1 = accountService.findByIdCard(account.getIdcard_no());
            if (account1 == null) {
                int num = accountService.save(account);
                if (num==1){
                    result.setErrorCode(0);
                    result.setMessage("添加成功!");
                    return result;
                }else {
                    result.setErrorCode(404);
                }
            }else{
                result.setErrorCode(404);
            }
        }else {
            result.setErrorCode(202);
            session.setAttribute("telephError","手机号码或固话号码格式不正确!");
        }

        return result;
    }

    @ResponseBody
    @RequestMapping("/account_pause")
    public AjaxLoginResult<Account> accountPause(Integer id){
        AjaxLoginResult<Account> result = new AjaxLoginResult<Account>();

        String status = "1";
        int num = accountService.updateById(status, id);
        if (num == 1){
            result.setErrorCode(0);
            result.setMessage("操作成功!");
            return result;
        }else {
            result.setErrorCode(404);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/account_start")
    public AjaxLoginResult<Account> accountStart(Integer id){
        AjaxLoginResult<Account> result = new AjaxLoginResult<Account>();

        String status = "0";
        int num = accountService.updateById(status, id);
        if (num == 1){
            result.setErrorCode(0);
            result.setMessage("操作成功!");
            return result;
        }else {
            result.setErrorCode(404);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/account_delete")
    public AjaxLoginResult<Account> accountDelete(Integer id){
        AjaxLoginResult<Account> result = new AjaxLoginResult<Account>();

        String status = "2";
        int num = accountService.updateById(status, id);
        if (num == 1){
            result.setErrorCode(0);
            return result;
        }else {
            result.setErrorCode(404);
        }
        return result;
    }

    @RequestMapping("/accountModi")
    public String accountModi(Integer account_id,Model model,HttpServletRequest request){
        System.out.println("account_id:" + account_id);

        Account account = accountService.findById(account_id);

        if (account.getRecommender_id() != null){
            Account reAccount = accountService.findById(account.getRecommender_id());
            request.setAttribute("recommender_id",reAccount.getIdcard_no());
        }

        model.addAttribute("account",account);

        return "account/account_modi";
    }

    @ResponseBody
    @RequestMapping("/account_modi")
    public AjaxLoginResult<Account> account_modi(Account account,String reIdcard_no){
        System.out.println("reIdcard_no:"+reIdcard_no);

        if (!reIdcard_no.equals("")){
            Account reAccount = accountService.findByIdCard(reIdcard_no);
            account.setRecommender_id(reAccount.getAccount_id());
        }

        AjaxLoginResult<Account> result = new AjaxLoginResult<Account>();
        int num = accountService.update(account);
        if (num == 1){
            result.setErrorCode(0);
            result.setMessage("操作成功!");
            return result;
        }else {
            result.setErrorCode(203);
        }
        return result;
    }



    public static boolean isMatch(String reg, String str){
        return Pattern.matches(reg,str);
    }

}
