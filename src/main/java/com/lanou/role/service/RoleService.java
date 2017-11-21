package com.lanou.role.service;

import com.lanou.role.domain.Role;
import com.lanou.util.PageBean;

/**
 * Created by dllo on 17/11/17.
 */
public interface RoleService {

    PageBean<Role> findAll(int pc,int ps);

    int addRole(Role role);
    int addRoleAndModule(int role_id,int module_id);

    Role findModulesByRoleId(int role_id);

    int updateRole(Role role);

    int deleteRMByRoleId(int role_id);

    int deleteRoleByRoleId(int role_id);

}
