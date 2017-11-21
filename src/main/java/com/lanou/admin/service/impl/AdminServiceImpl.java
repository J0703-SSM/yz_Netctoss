package com.lanou.admin.service.impl;

import com.lanou.admin.domain.Admin;
import com.lanou.admin.mapper.AdminMapper;
import com.lanou.admin.service.AdminService;
import com.lanou.role.domain.Role;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by dllo on 17/11/20.
 */
@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Qualifier("adminMapper")
    @Autowired
    private AdminMapper adminMapper;


    public PageBean<Admin> findAll(int pc, int ps, Admin admin) {
        PageBean<Admin> pb = new PageBean<Admin>();
        pb.setPc(pc);
        pb.setPs(ps);

        Map<String,Object> map = new HashMap<String, Object>();
        map.put("start",(pc-1)*ps);
        map.put("pagesize",ps);
        if (admin.getRole().getName() != null) {
            if (admin.getRole().getName().equals("")) {
                admin.getRole().setName(null);
            }
        }
        if (admin.getRole().getModule().getModule_id() != null){
            if (admin.getRole().getModule().getModule_id() == 0){
                admin.getRole().getModule().setModule_id(null);
            }
        }

        map.put("rname",admin.getRole().getName());
        map.put("module_id",admin.getRole().getModule().getModule_id());
        int count = adminMapper.findCount(map);
        System.out.println("count:"+count);
        pb.setTr(count);
        List<Admin> admins = adminMapper.findAll(map);
        System.out.println("admins: "+admins);
        pb.setBeanList(admins);
        return pb;
    }

    public int resetPasswd(String password, int id) {
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("password",password);
        map.put("admin_id",id);
        return adminMapper.resetPasswd(map);
    }

    public int addAdmin(Admin admin) {

        int num = adminMapper.addAdmin(admin);
        if (num == 0){
            return 0;
        }
        Integer admin_id = admin.getAdmin_id();
        List<Integer> roleIds = admin.getRoleIds();
        for (int role_id:roleIds){
            System.out.println("role_id"+role_id);
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("admin_id",admin_id);
            map.put("role_id",role_id);
            int i = adminMapper.addAdminAndRole(map);
            if (i == 0){
                return 0;
            }
        }


        return 1;
    }

    public List<Role> findRole() {
        return adminMapper.findRole();
    }
}
