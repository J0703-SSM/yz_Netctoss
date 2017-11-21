package com.lanou.role.mapper;

import com.lanou.role.domain.Module;
import com.lanou.role.domain.Role;

import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/17.
 */
public interface RoleMapper {

    int findCount();

    List<Role> findModulesByRole(Map<String, Object> map);

    int addRole(Role role);

    int addRoleAndModule(Map<String, Integer> map);

    Role findModulesByRoleId(int role_id);

    int updateRole(Role role);

    int deleteRMByRoleId(int role_id);

    int deleteRoleByRoleId(int role_id);
}
