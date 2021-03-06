﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global.css"/>
    <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global_color.css"/>
    <script src="/resource/js/JQ3.2.1.js"></script>
    <script language="javascript" type="text/javascript">
        //保存成功的提示消息
        function showResult() {
            var modules = [];
            $(":input:checkbox:checked").each(function () {
                modules.push($(this).val())
            })
            $.ajax({
                type:"post",
                url:"/role/role_modi",
                data:{
                    "role_id": ${role.role_id},
                    "name": $("#rname").val(),
                    "module_id": modules
                },success:function (result) {
                    if (result.errorCode == 0){
                        showResultDiv(true);
                        window.setTimeout("showResultDiv(false);", 3000);
                        location.href="/role/role_list"
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
        <li><a href="/role/role_list" class="role_on"></a></li>
        <li><a href="/admin/admin_list" class="admin_off"></a></li>
        <li><a href="/fee/fee_list" class="fee_off"></a></li>
        <li><a href="/account/account_list" class="account_off"></a></li>
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
    <!--保存操作后的提示信息：成功或者失败-->
    <div id="save_result_info" class="save_success">保存成功！</div>
    <form action="" method="" class="main_form">
        <div class="text_info clearfix"><span>角色名称：</span></div>
        <div class="input_info">
            <input id="rname" type="text" class="width200" value="${role.name}"/>
            <span class="required">*</span>
            <div class="validate_msg_medium error_msg">不能为空，且为20长度的字母、数字和汉字的组合</div>
        </div>
        <div class="text_info clearfix"><span>设置权限：</span></div>
        <div class="input_info_high">
            <div class="input_info_scroll">
                <ul>
                    <li><input type="checkbox" value="1"
                            <c:forEach items="${role.modules}" var="module">
                                <c:if test="${module.module_id == '1'}">checked</c:if>
                            </c:forEach>
                    />角色管理
                    </li>
                    <li><input type="checkbox" value="2"
                            <c:forEach items="${role.modules}" var="module">
                                <c:if test="${module.module_id == '2'}">checked</c:if>
                            </c:forEach>
                    />管理员管理
                    </li>
                    <li><input type="checkbox" value="3"
                            <c:forEach items="${role.modules}" var="module">
                                <c:if test="${module.module_id == '3'}">checked</c:if>
                            </c:forEach>
                    />资费管理
                    </li>
                    <li><input type="checkbox" value="4"
                            <c:forEach items="${role.modules}" var="module">
                                <c:if test="${module.module_id == '4'}">checked</c:if>
                            </c:forEach>
                    />账务账号
                    </li>
                    <li><input type="checkbox" value="5"
                            <c:forEach items="${role.modules}" var="module">
                                <c:if test="${module.module_id == '5'}">checked</c:if>
                            </c:forEach>
                    />业务账号
                    </li>
                    <li><input type="checkbox" value="6"
                            <c:forEach items="${role.modules}" var="module">
                                <c:if test="${module.module_id == '6'}">checked</c:if>
                            </c:forEach>
                    />账单
                    </li>
                    <li><input type="checkbox" value="7"
                            <c:forEach items="${role.modules}" var="module">
                                <c:if test="${module.module_id == '7'}">checked</c:if>
                            </c:forEach>
                    />报表
                    </li>
                </ul>
            </div>
            <span class="required">*</span>
            <div class="validate_msg_tiny">至少选择一个权限</div>
        </div>
        <div class="button_info clearfix">
            <input type="button" value="保存" class="btn_save" onclick="showResult();"/>
            <input type="button" value="取消" class="btn_save"/>
        </div>
    </form>
</div>
<!--主要区域结束-->
<div id="footer">
    <span>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</span>
    <br/>
    <span>版权所有(C)云科技有限公司 </span>
</div>
</body>
</html>
