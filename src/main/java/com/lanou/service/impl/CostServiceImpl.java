package com.lanou.service.impl;

import com.lanou.domain.Cost;
import com.lanou.mapper.CostMapper;
import com.lanou.service.CostService;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/13.
 */
@Service("costService")
public class CostServiceImpl implements CostService {

    @Qualifier("costMapper")
    @Autowired
    private CostMapper costMapper;

    public PageBean<Cost> findAll(int pc,int ps,String str) {
        System.out.println(str);
        PageBean<Cost> pb = new PageBean<Cost>();
        pb.setPc(pc);
        pb.setPs(ps);
        int count = costMapper.findCount();
        System.out.println(count);
        pb.setTr(count);


        Map<String,Object> map = new HashMap<String, Object>();
        map.put("start",(pc-1)*ps);
        map.put("pagesize",ps);
        map.put("orderByClause",str);
        List<Cost> costs = costMapper.findAll(map);
        System.out.println("costs: "+costs);
        pb.setBeanList(costs);
        return pb;
    }

    public Cost findByName(String name) {
        return costMapper.findByName(name);
    }

    public int save(Cost cost) {

        int num = costMapper.save(cost);
        return num;
    }

    public int delete(int cost_id) {
        return costMapper.delete(cost_id);
    }

    public int update(Cost cost) {
        return costMapper.update(cost);
    }

    public Cost findById(int cost_id) {
        return costMapper.findById(cost_id);
    }

    public int updateById(int id) {

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("STATUS",'1');
        map.put("COST_ID",id);
        return costMapper.updateById(map);
    }
}
