package com.lanou.role.domain;

import java.util.List;

/**
 * Created by dllo on 17/11/17.
 */
public class Role {

    private Integer role_id;
    private String name;

    private Module module = new Module();
    private List<Module> modules;

    public Role() {
    }

    public Role(Integer role_id, String name) {
        this.role_id = role_id;
        this.name = name;
    }

    @Override
    public String toString() {
        return "Role{" +
                "role_id=" + role_id +
                ", name='" + name + '\'' +
                ", modules=" + modules +
                '}';
    }


    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public List<Module> getModules() {
        return modules;
    }

    public void setModules(List<Module> modules) {
        this.modules = modules;
    }

    public Integer getRole_id() {
        return role_id;
    }

    public void setRole_id(Integer role_id) {
        this.role_id = role_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
