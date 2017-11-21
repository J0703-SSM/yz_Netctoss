package com.lanou.account.mapper;

import com.lanou.account.domain.Account;

import java.util.List;
import java.util.Map;

/**
 * Created by dllo on 17/11/15.
 */
public interface AccountMapper {

    Account findByIdCard(String idcard_no);

    int findCount(Map<String,Object> map);
    List<Account> findAll(Map<String,Object> map);


    int save(Account account);

    int delete(int account_id);

    int update(Account account);

    Account findById(int account_id);

    int updateById(Map<String,Object> map);

}
