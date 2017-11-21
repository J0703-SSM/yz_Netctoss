package com.lanou.fee.service;

import com.lanou.fee.domain.Cost;
import com.lanou.util.PageBean;

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
