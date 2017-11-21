package com.lanou.admin.controller;

import com.lanou.admin.domain.Admin;
import com.lanou.admin.service.AdminService;
import com.lanou.role.domain.Role;
import com.lanou.util.AjaxLoginResult;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by dllo on 17/11/20.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Qualifier("adminService")
    @Autowired
    private AdminService adminService;


    @RequestMapping("/admin_list")
    public String adminList(Integer pc, Model model, Integer module_id, String rname, HttpSession session){
        System.out.println(rname);
        if (module_id != null || rname != null ) {
            Admin admin = new Admin();
            if (module_id != 0){
                admin.getRole().getModule().setModule_id(module_id);
            }
            if (!rname.equals("")){
                admin.getRole().setName(rname);
            }
            session.setAttribute("admin", admin);
        }
        Admin admin = new Admin();
        if (session.getAttribute("admin") != null) {
            admin = (Admin) session.getAttribute("admin");
            System.out.println("sessionAdmin:"+admin);
        }
        if (pc == null) {
            pc = 1;
        }
        int ps = 3;
        System.out.println("roleName"+admin.getRole().getName());
        PageBean<Admin> pb = adminService.findAll(pc, ps, admin);
        model.addAttribute("pb", pb);
        return "admin/admin_list";
    }

    @ResponseBody
    @RequestMapping("/admin_passwdReset")
    public AjaxLoginResult<Admin> admin_passwdReset(@RequestParam(value = "ids[]") Integer[] ids){
        AjaxLoginResult<Admin> result = new AjaxLoginResult<Admin>();

        String password = "123456";
        for (int id :
                ids) {
            System.out.println(id);
            int num = adminService.resetPasswd(password, id);
            if (num ==0){
                result.setErrorCode(404);
                return result;
            }
        }
        result.setErrorCode(0);
        result.setMessage("密码重置成功!");
        return result;
    }

    @RequestMapping("/adminAdd")
    public String adminAdd(Model model){
        List<Role> roles = adminService.findRole();
        model.addAttribute("roles",roles);
        return "admin/admin_add";
    }

    @ResponseBody
    @RequestMapping("/admin_add")
    public AjaxLoginResult<Admin> admin_add(Admin admin,String rePassword,@RequestParam(value = "ids[]") Integer[] ids){

        AjaxLoginResult<Admin> result = new AjaxLoginResult<Admin>();

        if (!rePassword.equals(admin.getPassword())){
            result.setErrorCode(10);

            return result;
        }
        for (int id :
                ids) {
            System.out.println(id);
            admin.getRoleIds().add(id);
        }
        System.out.println(admin.getRoleIds());
        int num = adminService.addAdmin(admin);
        if (num ==1){
            result.setErrorCode(0);
            return result;
        }
        return result;
    }
}
