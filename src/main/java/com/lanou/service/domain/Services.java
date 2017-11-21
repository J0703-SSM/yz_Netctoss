package com.lanou.service.domain;

import com.lanou.account.domain.Account;
import com.lanou.fee.domain.Cost;

import java.sql.Timestamp;

/**
 * Created by dllo on 17/11/17.
 */
public class Services {

    private Integer service_id;
    private Integer account_id;
    private String unix_host;
    private String os_username;
    private String login_passwd;
    private String status;
    private Timestamp create_date;
    private Timestamp pause_date;
    private Timestamp close_date;
    private Integer cost_id;

    private Account account = new Account();
    private Cost cost = new Cost();


    public Services() {
    }

    public Services(Integer service_id, Integer account_id, String unix_host, String os_username,
                    String login_passwd, String status, Timestamp create_date,
                    Timestamp pause_date, Timestamp close_date, Integer cost_id) {
        this.service_id = service_id;
        this.account_id = account_id;
        this.unix_host = unix_host;
        this.os_username = os_username;
        this.login_passwd = login_passwd;
        this.status = status;
        this.create_date = create_date;
        this.pause_date = pause_date;
        this.close_date = close_date;
        this.cost_id = cost_id;
    }

    @Override
    public String toString() {
        return "Services{" +
                "service_id=" + service_id +
                ", account_id=" + account_id +
                ", unix_host='" + unix_host + '\'' +
                ", os_username='" + os_username + '\'' +
                ", login_passwd='" + login_passwd + '\'' +
                ", status='" + status + '\'' +
                ", create_date=" + create_date +
                ", pause_date=" + pause_date +
                ", close_date=" + close_date +
                ", cost_id=" + cost_id +
                '}';
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Cost getCost() {
        return cost;
    }

    public void setCost(Cost cost) {
        this.cost = cost;
    }

    public Integer getService_id() {
        return service_id;
    }

    public void setService_id(Integer service_id) {
        this.service_id = service_id;
    }

    public Integer getAccount_id() {
        return account_id;
    }

    public void setAccount_id(Integer account_id) {
        this.account_id = account_id;
    }

    public String getUnix_host() {
        return unix_host;
    }

    public void setUnix_host(String unix_host) {
        this.unix_host = unix_host;
    }

    public String getOs_username() {
        return os_username;
    }

    public void setOs_username(String os_username) {
        this.os_username = os_username;
    }

    public String getLogin_passwd() {
        return login_passwd;
    }

    public void setLogin_passwd(String login_passwd) {
        this.login_passwd = login_passwd;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Timestamp create_date) {
        this.create_date = create_date;
    }

    public Timestamp getPause_date() {
        return pause_date;
    }

    public void setPause_date(Timestamp pause_date) {
        this.pause_date = pause_date;
    }

    public Timestamp getClose_date() {
        return close_date;
    }

    public void setClose_date(Timestamp close_date) {
        this.close_date = close_date;
    }

    public Integer getCost_id() {
        return cost_id;
    }

    public void setCost_id(Integer cost_id) {
        this.cost_id = cost_id;
    }
}
