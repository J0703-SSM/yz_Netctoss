package com.lanou.service;

import com.lanou.domain.Cost;
import com.lanou.util.PageBean;

import java.util.List;

/**
 * Created by dllo on 17/11/13.
 */
public interface CostService {

    PageBean<Cost> findAll(int pc, int ps,String str);

    Cost findByName(String name);

    int save(Cost cost);

    int delete(int cost_id);

    int update(Cost cost);

    Cost findById(int cost_id);

    int updateById(int id);
}
