<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>云科技</title>
    <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global.css"/>
    <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global_color.css"/>
    <script src="/resource/js/JQ3.2.1.js"></script>
    <script language="javascript" type="text/javascript">
        var Wi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1];    // 加权因子
        var ValideCode = [1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2];            // 身份证验证位值.10代表X

        function getBirthdate() {
            var idCard = document.getElementById("idcard_no").value;

            idCard = trim(idCard.replace(/ /g, ""));               //去掉字符串头尾空格
            if (idCard.length == 15) {
                return isValidityBrithBy15IdCard(idCard);       //进行15位身份证的验证
            } else if (idCard.length == 18) {
                var a_idCard = idCard.split("");                // 得到身份证数组
                if (isValidityBrithBy18IdCard(idCard) && isTrueValidateCodeBy18IdCard(a_idCard)) {   //进行18位身份证的基本验证和第18位的验证
                    document.getElementById("idcardError").style.display = "none";
                    document.getElementById("idcardPass").style.display = "block";
                    return true;
                } else {
                    document.getElementById("idcardPass").style.display = "none";
                    document.getElementById("idcardError").style.display = "block";
                    document.getElementById("idcard_no").value = "";
                    return false;
                }
            } else {
                document.getElementById("idcardPass").style.display = "none";
                document.getElementById("idcardError").style.display = "block";
                document.getElementById("idcard_no").value = "";
                return false;
            }
        }
        /**
         * 判断身份证号码为18位时最后的验证位是否正确
         * @param a_idCard 身份证号码数组
         * @return
         */
        function isTrueValidateCodeBy18IdCard(a_idCard) {
            var sum = 0;                             // 声明加权求和变量
            if (a_idCard[17].toLowerCase() == 'x') {
                a_idCard[17] = 10;                    // 将最后位为x的验证码替换为10方便后续操作
            }
            for (var i = 0; i < 17; i++) {
                sum += Wi[i] * a_idCard[i];            // 加权求和
            }
            valCodePosition = sum % 11;                // 得到验证码所位置
            if (a_idCard[17] == ValideCode[valCodePosition]) {
                return true;
            } else {
                return false;
            }
        }

        /**
         * 验证18位数身份证号码中的生日是否是有效生日
         * @param idCard 18位书身份证字符串
         * @return
         */
        function isValidityBrithBy18IdCard(idCard18) {
            var year = idCard18.substring(6, 10);
            var month = idCard18.substring(10, 12);
            var day = idCard18.substring(12, 14);
            var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
            // 这里用getFullYear()获取年份，避免千年虫问题
            if (temp_date.getFullYear() != parseFloat(year)
                    || temp_date.getMonth() != parseFloat(month) - 1
                    || temp_date.getDate() != parseFloat(day)) {
                return false;
            } else {
                document.getElementById("birthdate").value = "" + year + "-" + month + "-" + day + "";
                return true;
            }
        }

        /**
         * 验证15位数身份证号码中的生日是否是有效生日
         * @param idCard15 15位书身份证字符串
         * @return
         */
        function isValidityBrithBy15IdCard(idCard15) {
            var year = idCard15.substring(6, 8);
            var month = idCard15.substring(8, 10);
            var day = idCard15.substring(10, 12);
            var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
            // 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法
            if (temp_date.getYear() != parseFloat(year)
                    || temp_date.getMonth() != parseFloat(month) - 1
                    || temp_date.getDate() != parseFloat(day)) {
                document.getElementById("idcardPass").style.display = "none";
                document.getElementById("idcardError").style.display = "block";
                document.getElementById("idcard_no").value = "";
                return false;
            } else {
                document.getElementById("idcardError").style.display = "none";
                document.getElementById("idcardPass").style.display = "block";
                document.getElementById("birthdate").value = "" + year + "-" + month + "-" + day + "";
                return true;
            }
        }

        //去掉字符串头尾空格
        function trim(str) {
            return str.replace(/(^\s*)|(\s*$)/g, "");
        }

        function idCardTest() {
            var idCard = document.getElementById("reIdcard_no").value;
            if (/(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/.test(idCard) ){
                document.getElementById("IDError").style.display="none"
                document.getElementById("IDPass").style.display="block"
            }else {
                document.getElementById("IDPass").style.display="none"
                document.getElementById("IDError").style.display="block"
            }

        }


        //保存成功的提示信息
        function showResult() {

            $.ajax({
                type: "get",
                url: "/account/account_add",
                data: {
                    "real_name": $("#real_name").val(),
                    "idcard_no": $("#idcard_no").val(),
                    "login_name": $("#login_name").val(),
                    "login_passwd": $("#login_passwd").val(),
                    "relogin_passwd": $("#relogin_passwd").val(),
                    "telephone": $("#telephone").val(),
                    "reIdcard_no": $("#reIdcard_no").val(),
                    "birthdate": $("#birthdate").val(),
                    "email": $("#email").val(),
                    "occupation": $("#occupation").val(),
                    "gender": $(":input:radio:checked").val(),
                    "mailaddress": $("#mailaddress").val(),
                    "zipcode": $("#zipcode").val(),
                    "qq": $("#qq").val()
                },
                success: function (result) {
                    if (result.errorCode == 0) {
                        alert(result.message)
                        window.location.href = "/account/account_list"
                    } else if (result.errorCode == 202) {
                        window.location.href = "/account/accountAdd"
                    } else {
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
        //显示选填的信息项
        function showOptionalInfo(imgObj) {
            var div = document.getElementById("optionalInfo");
            if (div.className == "hide") {
                div.className = "show";
                imgObj.src = "/resource/images/hide.png";
            } else {
                div.className = "hide";
                imgObj.src = "/resource/images/show.png";
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
        <li><a href="/fee/fee_list" class="fee_off"></a></li>
        <li><a href="/account/account_list" class="account_on"></a></li>
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
    <!--保存成功或者失败的提示消息-->
    <div id="save_result_info" class="save_fail">保存失败，该身份证已经开通过账务账号！</div>
    <form action="" method="" class="main_form">
        <!--必填项-->
        <div class="text_info clearfix"><span>姓名：</span></div>
        <div class="input_info">
            <input id="real_name" type="text" value="" placeholder="例如:张三"/>
            <span class="required">*</span>
            <div class="validate_msg_long">20长度以内的汉字、字母和数字的组合</div>
        </div>
        <div class="text_info clearfix"><span>身份证：</span></div>
        <div class="input_info">
            <input id="idcard_no" type="text" onblur="getBirthdate();"/>
            <span class="required">*</span>
            <div id="idcardPass" style="display: none; color: limegreen" class="validate_msg_long">身份证可用!</div>
            <div id="idcardError" style="display: none;color: red" class="validate_msg_long">身份证号码不合法!请输入本人身份证号码</div>
        </div>
        <div class="text_info clearfix"><span>登录账号：</span></div>
        <div class="input_info">
            <input id="login_name" type="text" value="" placeholder="创建即启用，状态为开通"/>
            <span class="required">*</span>
            <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
        </div>
        <div class="text_info clearfix"><span>密码：</span></div>
        <div class="input_info">
            <input id="login_passwd" type="password"/>
            <span class="required">*</span>
            <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
        </div>
        <div class="text_info clearfix"><span>重复密码：</span></div>
        <div class="input_info">
            <input id="relogin_passwd" type="password"/>
            <span class="required">*</span>
            <div class="validate_msg_long">
                <c:if test="${passError == null}">两次密码必须相同</c:if>
                <c:if test="${passError != null}"><font color="red">${passError}</font></c:if>
            </div>
        </div>
        <div class="text_info clearfix"><span>电话：</span></div>
        <div class="input_info">
            <input id="telephone" type="text" class="width200"/>
            <span class="required">*</span>
            <div class="validate_msg_medium">
                <c:if test="${telephError == null}">正确的电话号码格式：手机或固话</c:if>
                <c:if test="${telephError != null}"><font color="red">${telephError}</font></c:if>
            </div>
        </div>
        <!--可选项-->
        <div class="text_info clearfix"><span>可选项：</span></div>
        <div class="input_info">
            <img src="/resource/images/show.png" alt="展开" onclick="showOptionalInfo(this);"/>
        </div>
        <div id="optionalInfo" class="hide">
            <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
            <div class="input_info">
                <input id="reIdcard_no" type="text" oninput="idCardTest();"/>
                <div id="IDPass" class="validate_msg_long" style="display: none;color: limegreen">正确的身份证号码格式</div>
                <div id="IDError" class="validate_msg_long" style="display: none;color: red">身份证号码不合法</div>
            </div>
            <div class="text_info clearfix"><span>生日：</span></div>
            <div class="input_info">
                <input id="birthdate" type="text" value="" readonly class="readonly"/>
            </div>
            <div id="" class="text_info clearfix"><span>Email：</span></div>
            <div class="input_info">
                <input id="email" type="text" class="width350"/>
                <div class="validate_msg_tiny">50长度以内，合法的 Email 格式</div>
            </div>
            <div class="text_info clearfix"><span>职业：</span></div>
            <div class="input_info">
                <select id="occupation">
                    <option>干部</option>
                    <option>学生</option>
                    <option>技术人员</option>
                    <option>其他</option>
                </select>
            </div>
            <div class="text_info clearfix"><span>性别：</span></div>
            <div class="input_info fee_type">
                <input type="radio" name="radSex" checked="checked" value="女" id="female"/>
                <label for="female">女</label>
                <input type="radio" name="radSex" value="男" id="male"/>
                <label for="male">男</label>
            </div>
            <div class="text_info clearfix"><span>通信地址：</span></div>
            <div class="input_info">
                <input id="mailaddress" type="text" class="width350"/>
                <div class="validate_msg_tiny">50长度以内</div>
            </div>
            <div class="text_info clearfix"><span>邮编：</span></div>
            <div class="input_info">
                <input id="zipcode" type="text"/>
                <div class="validate_msg_long">6位数字</div>
            </div>
            <div class="text_info clearfix"><span>QQ：</span></div>
            <div class="input_info">
                <input id="qq" type="text"/>
                <div class="validate_msg_long">5到13位数字</div>
            </div>
        </div>
        <!--操作按钮-->
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
