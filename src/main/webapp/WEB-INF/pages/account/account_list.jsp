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

        function search() {
            document.getElementById("form").submit()
        }


        //删除
        function deleteAccount(id) {
            var r = window.confirm("确定要删除此账务账号吗？\r\n删除后将不能恢复，且会删除其下属的所有业务账号。");
            $.post("/account/account_delete", {"id": id}, function (result) {
                if (result.errorCode == 0) {
                    // 删除某一行
                    document.getElementById("operate_result_info").style.display = "block";
                    location.href="/account/account_list?pc=${pb.pc}";
                }
            })

        }
        //开通或暂停
        function setState(id,status) {

            if (status == '0'){
                var r = window.confirm("确定要暂停此账务账号吗？");
                $.post("/account/account_pause", {"id": id}, function (result) {
                    if (result.errorCode == 0) {
                        alert(result.message);
                        location.href="/account/account_list?pc=${pb.pc}";
                    }
                })
            }
            if (status == '1'){
                var r = window.confirm("确定要开通此账务账号吗？");
                $.post("/account/account_start", {"id": id}, function (result) {
                    if (result.errorCode == 0) {
                        location.href="/account/account_list?pc=${pb.pc}";
                    }
                })
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
    <form id="form" action="/account/account_list" method="post">
        <!--查询-->
        <div class="search_add">
            <div>身份证：<input name="idcard_no" type="text" placeholder="不验证" value="${sessionScope.account.idcard_no}" class="text_search"/></div>
            <div>姓名：<input name="real_name" type="text" class="width70 text_search" value="${sessionScope.account.real_name}" placeholder="不验证"/></div>
            <div>登录名：<input name="login_name" type="text" placeholder="不验证" value="${sessionScope.account.login_name}" class="text_search" /></div>
            <div>
                状态：
                <select name="status" class="select_search">
                    <option <c:if test="${sessionScope.account.status == null}">selected="selected"</c:if> value="">全部</option>
                    <option <c:if test="${sessionScope.account.status == '0'}">selected="selected"</c:if> value="0">开通</option>
                    <option <c:if test="${sessionScope.account.status == '1'}">selected="selected"</c:if>  value="1">暂停</option>
                    <option <c:if test="${sessionScope.account.status == '2'}">selected="selected"</c:if>  value="2">删除</option>
                </select>
            </div>
            <div><input type="button" value="搜索" class="btn_search" onclick="search()"/></div>
            <input type="button" value="增加" class="btn_add" onclick="location.href='/account/accountAdd';"/>
        </div>
        <!--删除等的操作提示-->
        <div id="operate_result_info" class="operate_success">
            <img src="/resource/images/close.png" onclick="this.parentNode.style.display='none';"/>
            删除成功，且已删除其下属的业务账号！
        </div>
        <!--数据区域：用表格展示数据-->
        <div id="data">
            <table id="datalist">
                <tr>
                    <th>账号ID</th>
                    <th>姓名</th>
                    <th class="width150">身份证</th>
                    <th>登录名</th>
                    <th>状态</th>
                    <th class="width100">创建日期</th>
                    <th class="width150">上次登录时间</th>
                    <th class="width200"></th>
                </tr>
                <c:forEach items="${pb.beanList}" var="account">
                    <tr>
                        <td>${account.account_id}</td>
                        <td><a href="account_detail.jsp">${account.real_name}</a></td>
                        <td>${account.idcard_no}</td>
                        <td>${account.login_name}</td>
                        <td>
                            <c:if test="${account.status == '0'}">
                                ${'开通'}
                            </c:if>
                            <c:if test="${account.status == '1'}">
                                ${'暂停'}
                            </c:if>
                            <c:if test="${account.status == '2'}">
                                ${'删除'}
                            </c:if>
                        </td>
                        <td>${account.create_date}</td>
                        <td>${account.last_login_time}</td>
                        <td class="td_modi">
                            <c:if test="${account.status == '0'}">
                                <input type="button" value="暂停" class="btn_pause" onclick="setState(${account.account_id},${account.status});"/>
                                <input type="button" value="修改" class="btn_modify"
                                       onclick="location.href='/account/accountModi?account_id=${account.account_id}';"/>
                                <input type="button" value="删除" class="btn_delete" onclick="deleteAccount(${account.account_id});"/>
                            </c:if>
                            <c:if test="${account.status == '1'}">
                                <input type="button" value="开通" class="btn_start" onclick="setState(${account.account_id},${account.status});"/>
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='/account/accountModi?account_id=${account.account_id}';"/>
                                <input type="button" value="删除" class="btn_delete" onclick="deleteAccount(${account.account_id});"/>
                            </c:if>
                            <c:if test="${account.status == '3'}">
                                ${''}
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <p>业务说明：<br/>
                1、创建则开通，记载创建时间；<br/>
                2、暂停后，记载暂停时间；<br/>
                3、重新开通后，删除暂停时间；<br/>
                4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br/>
                5、暂停账务账号，同时暂停下属的所有业务账号；<br/>
                6、暂停后重新开通账务账号，并不同时开启下属的所有业务账号，需要在业务账号管理中单独开启；<br/>
                7、删除账务账号，同时删除下属的所有业务账号。</p>
        </div>
        <!--分页-->
        <div id="pages">

            <a href="/account/account_list">首页</a>
            <c:if test="${pb.pc > 1}">
                <a href="/account/account_list?pc=${pb.pc-1}">上一页</a>
            </c:if>

            <c:choose>
                <c:when test="${pb.tp <= 10}">
                    <c:set var="begin" value="1"/>
                    <c:set var="end" value="${pb.tp}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="begin" value="${pb.pc-5}"/>
                    <c:set var="end" value="${pb.pc+4}"/>
                    <%-- 头溢出 --%>
                    <c:if test="${begin < 1}">
                        <c:set var="begin" value="1"/>
                        <c:set var="end" value="10"/>
                    </c:if>
                    <%-- 尾溢出 --%>
                    <c:if test="${end > pb.tp}">
                        <c:set var="begin" value="${pb.tp - 9}"/>
                        <c:set var="end" value="${pb.tp}"/>
                    </c:if>
                </c:otherwise>
            </c:choose>
            <c:forEach var="i" begin="${begin}" end="${end}">
                <c:choose>
                    <c:when test="${pb.pc eq i}">
                        <a href="/account/account_list?pc=${i}"
                           class="current_page">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/account/account_list?pc=${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pb.pc < pb.tp}">
                <a href="/account/account_list?pc=${pb.pc+1}">下一页</a>
            </c:if>
            <a href="/account/account_list?pc=${pb.tp}">尾页</a>

        </div>
    </form>
</div>
<!--主要区域结束-->
<div id="footer">
    <p>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</p>
    <p>版权所有(C)云科技有限公司 </p>
</div>
</body>
</html>
