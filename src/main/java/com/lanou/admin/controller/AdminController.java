package com.lanou.admin.controller;

import com.lanou.admin.domain.Admin;
import com.lanou.admin.service.AdminService;
import com.lanou.role.domain.Role;
import com.lanou.util.AjaxLoginResult;
import com.lanou.util.PageBean;
import com.lanou.util.VerifyCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

/**
 * Created by dllo on 17/11/20.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Qualifier("adminService")
    @Autowired
    private AdminService adminService;


    /*查询所有*/
    @RequestMapping("/admin_list")
    public String adminList(Integer pc, Model model, Integer module_id, String rname, HttpSession session){
        // 高级查询条件判空,如果执行高级查询,就将条件存入session中
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
        //先从session中取,如果取到对象,用此对象去判断
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

    /*密码重置*/
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

    /*添加跳转*/
    @RequestMapping("/adminAdd")
    public String adminAdd(Model model){
        List<Role> roles = adminService.findRole();
        model.addAttribute("roles",roles);
        return "admin/admin_add";
    }

    /*添加*/
    @ResponseBody
    @RequestMapping("/admin_add")
    public AjaxLoginResult<Admin> admin_add(Admin admin,String rePassword,@RequestParam(value = "ids[]") Integer[] ids){

        AjaxLoginResult<Admin> result = new AjaxLoginResult<Admin>();

        // 密码正则
        String passWdRegex="[a-zA-Z0-9]{0,30}";
        if (isMatch(passWdRegex,admin.getPassword())){

        }else {
            result.setErrorCode(5);
            return result;
        }

        // 两次密码是否一致
        if (!rePassword.equals(admin.getPassword())){
            result.setErrorCode(10);
            return result;
        }
        // 手机号,电话号正则
        String cellphone = "^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$";
        String telephone = "^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$";
        if (isMatch(cellphone,admin.getTelephone()) || isMatch(telephone,admin.getTelephone())) {

        }else {
            result.setErrorCode(20);
            return result;
        }
        // 邮箱正则
        String emailRegx ="^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
        if (isMatch(emailRegx,admin.getEmail())){

        }else {
            result.setErrorCode(30);
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

    // 修改 回显 跳转
    @RequestMapping("/adminModi")
    public String roleModi(Integer admin_id, Model model, HttpServletRequest request){
        System.out.println("admin_id:" + admin_id);
        List<Role> roles = adminService.findRole();
        // 通过id查询roles
        Admin admin = adminService.findRolesByAdminId(admin_id);
        System.out.println(admin.getRoles());
        request.setAttribute("roles",roles);
        model.addAttribute("admin",admin);
        return "admin/admin_modi";
    }

    // 修改
    @ResponseBody
    @RequestMapping("/admin_modi")
    public AjaxLoginResult<Admin> role_modi(@RequestParam(value = "role_id[]") Integer[] role_id,Admin admin){
        AjaxLoginResult<Admin> result = new AjaxLoginResult<Admin>();

        System.out.println(admin);
        int anum = adminService.updateAdmin(admin);
        System.out.println(anum);
        int rnum = adminService.deleteARByAdminId(admin.getAdmin_id());
        System.out.println(rnum);
        for (int id :
                role_id) {
            adminService.addAdminAndRole(admin.getAdmin_id(),id);
        }
        result.setErrorCode(0);

        return result;
    }

    // 删除
    @ResponseBody
    @RequestMapping("/admin_delete")
    public AjaxLoginResult<Admin> admin_delete(Integer id){
        AjaxLoginResult<Admin> result = new AjaxLoginResult<Admin>();
        adminService.deleteARByAdminId(id);
        adminService.deleteAdminByAdminId(id);

        result.setErrorCode(0);
        result.setMessage("删除成功!");
        return result;
    }

    // 登录
    @ResponseBody
    @RequestMapping("/login")
    public AjaxLoginResult<Admin> login(String admin_code, String password,String verifyCode,HttpServletRequest request){
        AjaxLoginResult<Admin> result = new AjaxLoginResult<Admin>();
        System.out.println(verifyCode);
        String verifyCode1 = (String)request.getSession().getAttribute("verifyCode");
        // 验证码校验
        if (verifyCode != null){
            if (!verifyCode.equalsIgnoreCase(verifyCode1)){
                result.setErrorCode(30);
                return result;
            }
        }

        Admin admin = adminService.findAdminByCode(admin_code);
        if (admin != null){
            if (admin.getPassword().equals(password)){
                result.setErrorCode(5);//登录成功
                request.getServletContext().setAttribute("admin",admin);
                return result;
            }else {
                result.setErrorCode(20);// 密码错误
                return result;
            }
        }else {
            result.setErrorCode(10);// 用户名不存在
            return result;
        }
    }

    // 获取验证码
    @RequestMapping("/getVerifyCode")
    public void getVerifyCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        VerifyCode code = new VerifyCode();
        BufferedImage image = code.getImage();
        // 将值传到session中
        request.getSession().setAttribute("verifyCode", code.getText());
        VerifyCode.output(image, response.getOutputStream());
    }

    // 用户信息回显
    @RequestMapping("/user_info")
    public String userInfo(HttpServletRequest request,Model model){
        Admin admin = (Admin) request.getServletContext().getAttribute("admin");
        Admin admin1 = adminService.findRolesByAdminId(admin.getAdmin_id());
        model.addAttribute("admin1",admin1);
        System.out.println(admin);
        return "user/user_info";
    }


    // 正则验证方法
    public static boolean isMatch(String reg, String str){
        return Pattern.matches(reg,str);
    }
}
