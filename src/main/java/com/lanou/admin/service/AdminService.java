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
}
