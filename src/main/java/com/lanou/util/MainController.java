package com.lanou.util;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by dllo on 17/11/10.
 */
@Controller
public class MainController {

    @RequestMapping("/")
    public String login(){
        return "login";
    }
//
    @RequestMapping("index")
    public String index(){
        return "index";
    }

//   @RequestMapping("role/role_list")
//   public String roleList(){
//       return "role_list";
//   }
//   @RequestMapping("admin/admin_list")
//    public String adminList(){
//       return "admin_list";
//   }
//   @RequestMapping("/account/account_list")
//    public String accountList(){
//       return "account_list";
//   }
//   @RequestMapping("service/service_list")
//    public String serviceList(){
//       return "service_list";
//   }
//
//   @RequestMapping("bill/bill_list")
//    public String billList(){
//       return "bill_list";
//   }
//    @RequestMapping("report/report_list")
//    public String reportList(){
//        return "report_list";
//    }

}
