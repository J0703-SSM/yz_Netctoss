package com.lanou.service.service;

import com.lanou.service.domain.Services;
import com.lanou.util.PageBean;


/**
 * Created by dllo on 17/11/17.
 */
public interface ServiceService {

    PageBean<Services> findAll(int pc, int ps , Services service);
}
