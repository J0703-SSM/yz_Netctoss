<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        function returnList() {
            window.location.href = "/fee/fee_list"
        }

        //保存结果的提示
        function showResult() {
            var BASE_DURATION = 0;
            var UNIT_COST = 0;
            var BASE_COST = 0;
            if ('' != $("#BASE_DURATION").val()){
                BASE_DURATION = $("#BASE_DURATION").val();
            }
            if ('' != $("#UNIT_COST").val()){
                UNIT_COST = $("#UNIT_COST").val()
            }
            if ('' != $("#BASE_COST").val()){
                BASE_COST = $("#BASE_COST").val();
            }
            $.ajax({
                type:"get",
                url:"/fee/fee_modi",
                data:{
                    "COST_ID": $("#COST_ID").val(),
                    "NAME": $("#NAME").val(),
                    "BASE_DURATION": BASE_DURATION,
                    "BASE_COST": BASE_COST,
                    "UNIT_COST": UNIT_COST,
                    "DESCR": $("#DESCR").val(),
                    "COST_TYPE": $(":input:radio:checked").val()
                },
                success:function (result) {
                    if (result.errorCode == 0){
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

        //切换资费类型
        function feeTypeChange(type) {
            var inputArray = document.getElementById("main").getElementsByTagName("input");
            if (type == 1) {
                inputArray[5].readOnly = true;
                inputArray[5].value = "";
                inputArray[5].className += " readonly";
                inputArray[6].readOnly = false;
                inputArray[6].className = "width100";
                inputArray[7].readOnly = true;
                inputArray[7].className += " readonly";
                inputArray[7].value = "";
            }
            else if (type == 2) {
                inputArray[5].readOnly = false;
                inputArray[5].className = "width100";
                inputArray[6].readOnly = false;
                inputArray[6].className = "width100";
                inputArray[7].readOnly = false;
                inputArray[7].className = "width100";
            }
            else if (type == 3) {
                inputArray[5].readOnly = true;
                inputArray[5].value = "";
                inputArray[5].className += " readonly";
                inputArray[6].readOnly = true;
                inputArray[6].value = "";
                inputArray[6].className += " readonly";
                inputArray[7].readOnly = false;
                inputArray[7].className = "width100";
            }
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
        <li><a href="/fee/fee_list" class="fee_on"></a></li>
        <li><a href="/account/account_list" class="account_off"></a></li>
        <li><a href="/service/service_list" class="service_off"></a></li>
        <li><a href="/bill/bill_list" class="bill_off"></a></li>
        <li><a href="/report/report_list" class="report_off"></a></li>
        <li><a href="/user/user_info" class="information_off"></a></li>
        <li><a href="/user/user_modi_pwd" class="password_off"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<!--主要区域开始-->
<div id="main">
    <div id="save_result_info" class="save_success">保存成功！</div>
    <form action="" method="" class="main_form">
        <div class="text_info clearfix"><span>资费ID：</span></div>
        <div class="input_info"><input type="text" id="COST_ID" class="readonly" readonly value="${cost.COST_ID}"/></div>
        <div class="text_info clearfix"><span>资费名称：</span></div>
        <div class="input_info">
            <input type="text" id="NAME" class="width300" value="${cost.NAME}"/>
            <span class="required">*</span>
            <div class="validate_msg_short">50长度的字母、数字、汉字和下划线的组合</div>
        </div>
        <div class="text_info clearfix"><span>资费类型：</span></div>
        <div class="input_info fee_type">
            <input type="radio" name="cost_type" <c:if test="${cost.COST_TYPE == '1'}">
                checked="checked" id="monthly" onclick="feeTypeChange(1);" value="1"
            </c:if> />
            <label for="monthly">包月</label>
            <input type="radio" name="cost_type" <c:if test="${cost.COST_TYPE == '2'}">
                checked="checked" id="package" onclick="feeTypeChange(2);" value="2"
            </c:if>/>
            <label for="package">套餐</label>
            <input type="radio" name="cost_type" <c:if test="${cost.COST_TYPE == '3'}">
                checked="checked" id="timeBased" onclick="feeTypeChange(3);" value="3"
            </c:if>/>
            <label for="timeBased">计时</label>
        </div>
        <div class="text_info clearfix"><span>基本时长：</span></div>
        <div class="input_info">
            <input type="text" id="BASE_DURATION" value="${cost.BASE_DURATION}" class="width100"/>
            <span class="info">小时</span>
            <span class="required">*</span>
            <div class="validate_msg_long">1-600之间的整数</div>
        </div>
        <div class="text_info clearfix"><span>基本费用：</span></div>
        <div class="input_info">
            <input type="text" id="BASE_COST" value="${cost.BASE_COST}" class="width100"/>
            <span class="info">元</span>
            <span class="required">*</span>
            <div class="validate_msg_long">0-99999.99之间的数值</div>
        </div>
        <div class="text_info clearfix"><span>单位费用：</span></div>
        <div class="input_info">
            <input type="text" id="UNIT_COST" value="${cost.UNIT_COST}" class="width100"/>
            <span class="info">元/小时</span>
            <span class="required">*</span>
            <div class="validate_msg_long">0-99999.99之间的数值</div>
        </div>
        <div class="text_info clearfix"><span>资费说明：</span></div>
        <div class="input_info_high">
            <c:if test="${cost.DESCR != null}">
                <textarea id="DESCR" class="width300 height70">${cost.DESCR}</textarea>
            </c:if>
            <c:if test="${cost.DESCR == null}">
                <textarea class="width300 height70">没有启用的资费，可以修改除 ID 以外的所有信息</textarea>
            </c:if>
            <div class="validate_msg_short">100长度的字母、数字、汉字和下划线的组合</div>
        </div>
        <div class="button_info clearfix">
            <input type="button" value="保存" class="btn_save" onclick="showResult();"/>
            <input type="button" value="取消" class="btn_save" onclick="returnList();"/>
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
