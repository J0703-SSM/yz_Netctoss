package com.lanou.role.domain;

/**
 * Created by dllo on 17/11/17.
 */
public class Module {

    private Integer module_id;
    private String name;

    public Module() {
    }

    public Module(Integer module_id, String name) {
        this.module_id = module_id;
        this.name = name;
    }

    @Override
    public String toString() {
        return "Module{" +
                "module_id=" + module_id +
                ", name='" + name + '\'' +
                '}';
    }

    public Integer getModule_id() {
        return module_id;
    }

    public void setModule_id(Integer module_id) {
        this.module_id = module_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
