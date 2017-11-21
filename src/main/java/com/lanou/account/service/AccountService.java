package com.lanou.account.service;

import com.lanou.account.domain.Account;
import com.lanou.util.PageBean;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/15.
 */
@Service("accountService")
public interface AccountService {

    Account findByIdCard(String idcard_no);

    PageBean<Account> findAll(int pc,int ps ,Account account);

    int save(Account account);

    int updateById(String status, int id);

    int delete(int account_id);

    Account findById(int account_id);

    int update(Account account);
}
