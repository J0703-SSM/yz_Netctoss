package com.lanou.role.controller;

import com.lanou.role.domain.Role;
import com.lanou.role.service.RoleService;
import com.lanou.util.AjaxLoginResult;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by dllo on 17/11/17.
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Qualifier("roleService")
    @Autowired
    private RoleService roleService;

    @RequestMapping("/role_list")
    public String roleList(Integer pc, Model model){
        if (pc == null) {
            pc = 1;
        }
        int ps = 3;
        System.out.println("pc:" + pc);
        PageBean<Role> pb = roleService.findAll(pc, ps);
        model.addAttribute("pb", pb);

        return "role/role_list";
    }

    @RequestMapping("/roleAdd")
    public String roleAdd(){
        return "role/role_add";
    }

    @ResponseBody
    @RequestMapping("/role_add")
    public AjaxLoginResult<Role> role_add(@RequestParam(value = "module_id[]") Integer[] module_id,String name){
        AjaxLoginResult<Role> result = new AjaxLoginResult<Role>();
        Role role = new Role();
        role.setName(name);
        roleService.addRole(role);
        int role_id = role.getRole_id();
        System.out.println("role_id:"+role_id);
        for (int id :
                module_id) {
            System.out.println("id:"+id);
            roleService.addRoleAndModule(role_id,id);
        }
        result.setErrorCode(0);

        return result;
    }

    @RequestMapping("/roleModi")
    public String roleModi(Integer role_id,Model model){
        System.out.println("role_id:" + role_id);
        Role role = roleService.findModulesByRoleId(role_id);
        System.out.println(role.getModules());
        model.addAttribute("role",role);
        return "role/role_modi";
    }

    @ResponseBody
    @RequestMapping("/role_modi")
    public AjaxLoginResult<Role> role_modi(@RequestParam(value = "module_id[]") Integer[] module_id,Role role){
        AjaxLoginResult<Role> result = new AjaxLoginResult<Role>();

        System.out.println(role);
        int unum = roleService.updateRole(role);
        System.out.println(unum);
        int dnum = roleService.deleteRMByRoleId(role.getRole_id());
        System.out.println(dnum);
        for (int id :
                module_id) {
            roleService.addRoleAndModule(role.getRole_id(),id);
        }
        result.setErrorCode(0);

        return result;
    }

    @ResponseBody
    @RequestMapping("/role_delete")
    public AjaxLoginResult<Role> role_delete(Integer id){
        System.out.println("id:" + id);
        AjaxLoginResult<Role> result = new AjaxLoginResult<Role>();

        roleService.deleteRMByRoleId(id);
        roleService.deleteRoleByRoleId(id);
        result.setErrorCode(0);
        return result;
    }

}
