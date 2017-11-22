<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global_color.css" />
        <script src="/resource/js/JQ3.2.1.js"></script>
    </head>
    <body class="index">
    <form>
        <div class="login_box">
            <table>
                <tr>
                    <td class="login_info">账号：</td>
                    <td colspan="2"><input id="admin_code" placeholder="请输入用户名" type="text" class="width150" /></td>
                    <td class="login_error_info"><span id="usernameError" style="display: none" class="required">用户名不存在!</span></td>
                </tr>
                <tr>
                    <td class="login_info">密码：</td>
                    <td colspan="2"><input id="password" placeholder="请输入密码" type="password" class="width150" /></td>
                    <td><span id="passError" style="display: none" class="required">密码错误!</span></td>
                </tr>
                <tr>
                    <td class="login_info">验证码：</td>
                    <td class="width70"><input id="verifyCode" name="" type="text" class="width70" /></td>
                    <td><img src="/admin/getVerifyCode" alt="验证码" title="点击更换" id="verifyCodeImage" onclick="changeImage"/></td>
                    <td><span id="codeError" style="display:none;" class="required">验证码错误!</span></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="login_button" colspan="2">
                        <a href="#" id="login"><img src="/resource/images/login_btn.png" /></a>
                    </td>
                    <td><span  class="required"></span></td>
                </tr>
            </table>
        </div>
    </form>

    <script>

        $("#login").click(function () {
            $.ajax({
                type:"post",
                url:"/admin/login",
                data:{
                    "admin_code": $("#admin_code").val(),
                    "password": $("#password").val(),
                    "verifyCode": $("#verifyCode").val()
                },success:function (result) {
                    if (result.errorCode == 30){
                        document.getElementById("usernameError").style.display="none";
                        document.getElementById("passError").style.display="none";
                        document.getElementById("codeError").style.display="block";
                    }else if (result.errorCode == 10){
                        document.getElementById("passError").style.display="none";
                        document.getElementById("codeError").style.display="none";
                        document.getElementById("usernameError").style.display="block";
                    }else if (result.errorCode == 20){
                        document.getElementById("codeError").style.display="none";
                        document.getElementById("usernameError").style.display="none";
                        document.getElementById("passError").style.display="block";
                    }else if (result.errorCode == 5){
                        location.href="/index"
                    }
                }
            })
        })

        $("#verifyCodeImage").click(function () {
            $("#verifyCodeImage").attr('src', '/admin/getVerifyCode?timestamp=' + new Date().getTime());
        });
    </script>
    </body>
</html>
