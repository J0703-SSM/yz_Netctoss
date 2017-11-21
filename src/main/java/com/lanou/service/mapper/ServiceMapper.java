package com.lanou.service.mapper;

import com.lanou.service.domain.Services;

import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/17.
 */
public interface ServiceMapper {

    Services findByIdCard(String idcard_no);

    int findCount(Map<String,Object> map);
    List<Services> findAll(Map<String,Object> map);

    int save(Services service);

    int delete(int service_id);

    int update(Services service);

    Services findById(int service_id);

    int updateById(Map<String,Object> map);

}
