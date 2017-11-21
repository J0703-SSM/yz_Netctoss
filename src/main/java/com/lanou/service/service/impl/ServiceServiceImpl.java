package com.lanou.service.service.impl;


import com.lanou.service.domain.Services;
import com.lanou.service.mapper.ServiceMapper;
import com.lanou.service.service.ServiceService;
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
@Service("serviceService")
public class ServiceServiceImpl implements ServiceService {

    @Qualifier("serviceMapper")
    @Autowired
    private ServiceMapper serviceMapper;

    public PageBean<Services> findAll(int pc, int ps, Services services) {
        PageBean<Services> pb = new PageBean<Services>();
        pb.setPc(pc);
        pb.setPs(ps);

        Map<String,Object> map = new HashMap<String, Object>();
        map.put("start",(pc-1)*ps);
        map.put("pagesize",ps);
        if (services.getOs_username() != null) {
            if (services.getOs_username().equals("")) {
                services.setOs_username(null);
            }
        }
        if (services.getUnix_host() != null){
            if (services.getUnix_host().equals("")){
                services.setUnix_host(null);
            }
        }
        if ( services.getAccount().getIdcard_no() != null){
            if (services.getAccount().getIdcard_no().equals("")){
                services.getAccount().setIdcard_no(null);
            }
        }
        if (services.getStatus() != null){
            if (services.getStatus().equals("")){
                services.setStatus(null);
            }
        }

        map.put("idcard_no",services.getAccount().getIdcard_no());
        map.put("os_username",services.getOs_username());
        map.put("unix_host",services.getUnix_host());
        map.put("status",services.getStatus());
        int count = serviceMapper.findCount(map);
        pb.setTr(count);
        List<Services> servicess = serviceMapper.findAll(map);
        System.out.println("services: "+servicess);
        pb.setBeanList(servicess);
        return pb;
    }
}
