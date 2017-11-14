package com.lanou.mapper;


import com.lanou.domain.Cost;

import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/11.
 */
public interface CostMapper {

    Cost findByName(String name);

    int findCount();
    List<Cost> findAll(Map<String,Object> map);

    int save(Cost cost);

    int delete(int cost_id);

    int update(Cost cost);

    Cost findById(int cost_id);

    int updateById(Map<String,Object> map);
}
