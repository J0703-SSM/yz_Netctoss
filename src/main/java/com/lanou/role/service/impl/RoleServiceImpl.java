package com.lanou.role.service.impl;

import com.lanou.role.domain.Module;
import com.lanou.role.domain.Role;
import com.lanou.role.mapper.RoleMapper;
import com.lanou.role.service.RoleService;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/17.
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {

    @Qualifier("roleMapper")
    @Autowired
    private RoleMapper roleMapper;


    public PageBean<Role> findAll(int pc, int ps) {

        PageBean<Role> pb = new PageBean<Role>();
        pb.setPc(pc);
        pb.setPs(ps);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("start",(pc-1)*ps);
        map.put("pagesize",ps);

        int count = roleMapper.findCount();
        pb.setTr(count);
        List<Role> roles = roleMapper.findModulesByRole(map);
        System.out.println("role:"+roles);
        pb.setBeanList(roles);
        return pb;
    }

    public int addRole(Role role) {
        return roleMapper.addRole(role);
    }


    public int addRoleAndModule(int role_id,int module_id) {
        Map<String,Integer> map = new HashMap<String, Integer>();
        map.put("role_id",role_id);
        map.put("module_id",module_id);
        return roleMapper.addRoleAndModule(map);
    }

    public Role findModulesByRoleId(int role_id) {
        return roleMapper.findModulesByRoleId(role_id);
    }

    public int updateRole(Role role) {
        return roleMapper.updateRole(role);
    }

    public int deleteRMByRoleId(int role_id) {
        return roleMapper.deleteRMByRoleId(role_id);
    }

    public int deleteRoleByRoleId(int role_id) {
        return roleMapper.deleteRoleByRoleId(role_id);
    }
}
