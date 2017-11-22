<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>云科技</title>
        <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global_color.css" />
        <script src="/resource/js/JQ3.2.1.js"></script>
        <script language="javascript" type="text/javascript">
            //保存成功的提示信息
            function showResult() {

                $.ajax({
                    type:"get",
                    url: "/account/account_modi",
                    data:{
                        "account_id": $("#account_id").val(),
                        "real_name": $("#real_name").val(),
                        "idcard_no": $("#idcard_no").val(),
                        "login_name": $("#login_name").val(),
                        "telephone": $("#telephone").val(),
                        "reIdcard_no": $("#reIdcard_no").val(),
                        "birthdate": $("#birthdate").val(),
                        "email": $("#email").val(),
                        "occupation": $("#occupation").val(),
                        "gender": $(":input:radio:checked").val(),
                        "mailaddress": $("#mailaddress").val(),
                        "zipcode": $("#zipcode").val(),
                        "qq": $("#qq").val(),
                    },
                    success:function (result) {
                        if (result.errorCode == 0 ){
                            alert(result.message);
                            window.location.href="/account/account_list";
                        }else {
                            showResultDiv(true);
                            window.setTimeout("showResultDiv(false);", 3000);
                        }
                    }

                })


            }
            function showResultDiv(flag) {
                var divResult = document.getElementById("save_result_info");
                if (flag)
                    divResult.style.display = "block";
                else
                    divResult.style.display = "none";
            }

            //显示修改密码的信息项
            function showPwd(chkObj) {
                if (chkObj.checked)
                    document.getElementById("divPwds").style.display = "block";
                else
                    document.getElementById("divPwds").style.display = "none";
            }
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <div id="header">
            <img src="/resource/images/logo.png" alt="logo" class="left"/>
            <a href="#">[退出]</a>            
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="navi">
            <ul id="menu">
                <li><a href="/index" class="index_off"></a></li>
                <li><a href="/role/role_list" class="role_off"></a></li>
                <li><a href="/admin/admin_list" class="admin_off"></a></li>
                <li><a href="/fee/fee_list" class="fee_off"></a></li>
                <li><a href="/account/account_list" class="account_on"></a></li>
                <li><a href="/service/service_list" class="service_off"></a></li>
                <li><a href="/bill/bill_list" class="bill_off"></a></li>
                <li><a href="/report/report_list" class="report_off"></a></li>
                <li><a href="/admin/user_info" class="information_off"></a></li>
                <li><a href="/admin/user_modi_pwd" class="password_off"></a></li>
            </ul>
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">  
            <!--保存成功或者失败的提示消息-->          
            <div id="save_result_info" class="save_fail">保存失败，旧密码错误！</div>
            <form action="" method="" class="main_form">
                    <!--必填项-->
                    <div class="text_info clearfix"><span>账务账号ID：</span></div>
                    <div class="input_info">
                        <input id="account_id" type="text" value="${account.account_id}" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input id="real_name" type="text" value="${account.real_name}" />
                        <span class="required">*</span>
                        <div class="validate_msg_long error_msg">20长度以内的汉字、字母和数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>身份证：</span></div>
                    <div class="input_info">
                        <input id="idcard_no" type="text" value="${account.idcard_no}" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>登录账号：</span></div>
                    <div class="input_info">
                        <input id="login_name" type="text" value="${account.login_name}" readonly class="readonly"  />
                        <!--                
                        <div class="change_pwd">
                            <input id="chkModiPwd" type="checkbox" onclick="showPwd(this);" />
                            <label for="chkModiPwd">修改密码</label>
                        </div>
                        -->
                    </div>
                    <!--修改密码部分-->
                    <!--
                    <div id="divPwds">
                        <div class="text_info clearfix"><span>旧密码：</span></div>
                        <div class="input_info">
                            <input type="password"  />
                            <span class="required">*</span>
                            <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                        </div>
                        <div class="text_info clearfix"><span>新密码：</span></div>
                        <div class="input_info">
                            <input type="password"  />
                            <span class="required">*</span>
                            <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                        </div>
                        <div class="text_info clearfix"><span>重复新密码：</span></div>
                        <div class="input_info">
                            <input type="password"  />
                            <span class="required">*</span>
                            <div class="validate_msg_long">两次密码必须相同</div>
                        </div>  
                    </div>      
                    -->             
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input id="telephone" type="text" value="${account.telephone}" class="width200"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium error_msg">正确的电话号码格式：手机或固话</div>
                    </div>
                    <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
                    <div class="input_info">
                        <input id="reIdcard_no" value="${requestScope.recommender_id}" type="text"/>
                        <div class="validate_msg_long error_msgs">正确的身份证号码格式</div>
                    </div>
                    <div class="text_info clearfix"><span>生日：</span></div>
                    <div class="input_info">
                        <input id="birthdate" type="text" value="${account.birthdate}" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input id="email" type="text" value="${account.email}" class="width200"/>
                        <div class="validate_msg_medium">50长度以内，合法的 Email 格式</div>
                    </div> 
                    <div class="text_info clearfix"><span>职业：</span></div>
                    <div class="input_info">
                        <select id="occupation">
                            <option <c:if test="${account.occupation == '干部'}">selected="selected"</c:if>>干部</option>
                            <option <c:if test="${account.occupation == '学生'}">selected="selected"</c:if>>学生</option>
                            <option <c:if test="${account.occupation == '技术人员'}">selected="selected"</c:if>>技术人员</option>
                            <option <c:if test="${account.occupation == '其他'}">selected="selected"</c:if>>其他</option>
                        </select>                        
                    </div>
                    <div class="text_info clearfix"><span>性别：</span></div>
                    <div class="input_info fee_type">
                        <input type="radio" name="gender"
                                <c:if test="${account.gender == '女'}">
                                    checked="checked"
                                </c:if>
                                id="female" value="女" />
                        <label for="female">女</label>
                        <input type="radio" name="gender"
                                <c:if test="${account.gender == '男'}">
                                    checked="checked"
                                </c:if>
                               id="male" value="男" />
                        <label for="male">男</label>
                    </div> 
                    <div class="text_info clearfix"><span>通信地址：</span></div>
                    <div class="input_info">
                        <input id="mailaddress" value="${account.mailaddress}" type="text" class="width350"/>
                        <div class="validate_msg_tiny">50长度以内</div>
                    </div> 
                    <div class="text_info clearfix"><span>邮编：</span></div>
                    <div class="input_info">
                        <input id="zipcode" value="${account.zipcode}" type="text"/>
                        <div class="validate_msg_long">6位数字</div>
                    </div> 
                    <div class="text_info clearfix"><span>QQ：</span></div>
                    <div class="input_info">
                        <input id="qq" value="${account.qq}" type="text"/>
                        <div class="validate_msg_long">5到13位数字</div>
                    </div>                
                    <!--操作按钮-->
                    <div class="button_info clearfix">
                        <input type="button" value="保存" class="btn_save" onclick="showResult();" />
                        <input type="button" value="取消" class="btn_save" />
                    </div>
                </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <span>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</span>
            <br />
            <span>版权所有(C)云科技有限公司 </span>
        </div>
    </body>
</html>
