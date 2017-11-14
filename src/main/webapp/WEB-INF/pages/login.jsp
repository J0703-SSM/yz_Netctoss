<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                    <td colspan="2"><input name="" type="text" class="width150" /></td>
                    <td class="login_error_info"><span class="required">30长度的字母、数字和下划线</span></td>
                </tr>
                <tr>
                    <td class="login_info">密码：</td>
                    <td colspan="2"><input name="" type="password" class="width150" /></td>
                    <td><span class="required">30长度的字母、数字和下划线</span></td>
                </tr>
                <tr>
                    <td class="login_info">验证码：</td>
                    <td class="width70"><input name="" type="text" class="width70" /></td>
                    <td><img src="/getVerifyCode" alt="验证码" title="点击更换" id="verifyCodeImage" onclick="changeImage"/></td>
                    <td><span class="required">验证码错误</span></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="login_button" colspan="2">
                        <a href="/index" id="login"><img src="/resource/images/login_btn.png" /></a>
                    </td>
                    <td><span class="required">用户名或密码错误，请重试</span></td>
                </tr>
            </table>
        </div>
    </form>

    <script>

        $("#login").click(function () {
            $.ajax({
                type:"post",
                url:"/index",
                data:{
                }
            })
        })

        function changeImage() {
            $('#verifyCodeImage').attr('src', '/getVerifyCode');
        }
    </script>
    </body>
</html>
