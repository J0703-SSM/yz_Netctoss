package com.lanou.util;

import java.util.List;

/**
 * Created by dllo on 17/10/30.
 */
public class PageBean<T> {

    private int pc;// 当前页码
    private int tr;// 总记录数
    private int ps;// 每页记录数
    private List<T> beanList;// 当前记录数
    private String url;// url 后面的条件

    public int getPc() {
        return pc;
    }

    public void setPc(int pc) {
        this.pc = pc;
    }
    // 获取总页数
    public int getTp() {

        int tp = tr/ps;

        return tr%ps == 0 ? tp : tp + 1;
    }

    public int getTr() {
        return tr;
    }

    public void setTr(int tr) {
        this.tr = tr;
    }

    public int getPs() {
        return ps;
    }

    public void setPs(int ps) {
        this.ps = ps;
    }

    public List<T> getBeanList() {
        return beanList;
    }

    public void setBeanList(List<T> beanList) {
        this.beanList = beanList;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
