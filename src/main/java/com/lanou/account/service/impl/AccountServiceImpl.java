package com.lanou.account.service.impl;

import com.lanou.account.domain.Account;
import com.lanou.account.mapper.AccountMapper;
import com.lanou.account.service.AccountService;
import com.lanou.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/15.
 */
@Service("accountService")
public class AccountServiceImpl implements AccountService {

    @Qualifier("accountMapper")
    @Autowired
    private AccountMapper accountMapper;

    public Account findByIdCard(String idcard_no) {
        return accountMapper.findByIdCard(idcard_no);
    }

    public PageBean<Account> findAll(int pc, int ps,Account account) {
        PageBean<Account> pb = new PageBean<Account>();
        pb.setPc(pc);
        pb.setPs(ps);

        Map<String,Object> map = new HashMap<String, Object>();
        map.put("start",(pc-1)*ps);
        map.put("pagesize",ps);
        if (account.getIdcard_no() != null) {
            if (account.getIdcard_no().equals("")) {
                account.setIdcard_no(null);
            }
        }
        if (account.getReal_name() != null){
            if (account.getReal_name().equals("")){
                account.setReal_name(null);
            }
        }
        if (account.getLogin_name() != null){
            if (account.getLogin_name().equals("")){
                account.setLogin_name(null);
            }
        }
        if (account.getStatus() != null){
            if (account.getStatus().equals("")){
                account.setStatus(null);
            }
        }

        map.put("idcard_no",account.getIdcard_no());
        map.put("real_name",account.getReal_name());
        map.put("login_name",account.getLogin_name());
        map.put("status",account.getStatus());
        int count = accountMapper.findCount(map);
        pb.setTr(count);
        List<Account> accounts = accountMapper.findAll(map);
        System.out.println("account: "+accounts);
        pb.setBeanList(accounts);
        return pb;
    }

    public int save(Account account) {

        return accountMapper.save(account);
    }

    public int updateById(String status,int id) {

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("status",status);
        map.put("account_id",id);
        return accountMapper.updateById(map);
    }

    public int delete(int account_id) {
        return accountMapper.delete(account_id);
    }

    public Account findById(int account_id) {
        return accountMapper.findById(account_id);
    }

    public int update(Account account) {
        return accountMapper.update(account);
    }
}
