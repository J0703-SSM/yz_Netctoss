package com.lanou.admin.mapper;

import com.lanou.admin.domain.Admin;
import com.lanou.role.domain.Role;

import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/20.
 */
public interface AdminMapper {

    int findCount(Map<String,Object> map);
    List<Admin> findAll(Map<String,Object> map);

    int resetPasswd(Map<String,Object> map);

    List<Role> findRole();

    int addAdmin(Admin admin);
    int addAdminAndRole(Map<String,Object> map);

    int deleteARByAdminId(int admin_id);
    int deleteAdminByAdminId(int admin_id);

    Admin findRolesByAdminId(int admin_id);

    int updateAdmin(Admin admin);
    
    Admin findAdminByCode(String admin_code);
}
