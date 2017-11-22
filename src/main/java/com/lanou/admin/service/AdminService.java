package com.lanou.admin.service;

import com.lanou.admin.domain.Admin;
import com.lanou.role.domain.Role;
import com.lanou.util.PageBean;

import java.util.List;


/**
 * Created by dllo on 17/11/20.
 */
public interface AdminService {

    PageBean<Admin> findAll(int pc, int ps, Admin admin);

    int resetPasswd(String password,int id);

    int addAdmin(Admin admin);

    List<Role> findRole();

    int deleteARByAdminId(int admin_id);
    int deleteAdminByAdminId(int admin_id);

    Admin findRolesByAdminId(int admin_id);

    int updateAdmin(Admin admin);

    int addAdminAndRole(int admin_id,int role_id);

    Admin findAdminByCode(String admin_code);
}
