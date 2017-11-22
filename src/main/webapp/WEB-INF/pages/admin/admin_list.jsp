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

        function search() {
            document.getElementById("form").submit()
        }

        //显示角色详细信息
        function showDetail(flag, a) {
            var detailDiv = a.parentNode.getElementsByTagName("div")[0];
            if (flag) {
                detailDiv.style.display = "block";
            }
            else
                detailDiv.style.display = "none";
        }
        //重置密码
        function resetPwd() {
            var ids = [];
            $(":input:checkbox:checked").each(function () {
                ids.push($(this).val())
            })
            if (ids.length == 0){
                alert("请至少选择一条数据！");
            }
            $.ajax({
                type:"post",
                url:"/admin/admin_passwdReset",
                data:{
                    "ids": ids
                },success:function (result) {
                    if (result.errorCode == 0){
                        alert(result.message);
                    }else{
                        document.getElementById("operate_result_info").style.display = "block";
                    }
                }
            })


        }
        //删除
        function deleteAdmin(id) {
            var r = window.confirm("确定要删除此管理员吗？");
            $.post("/admin/admin_delete", {"id": id}, function (result) {
                if (result.errorCode == 0) {
                    // 删除某一行
                    alert(result.message)
                    var rowid = "#" + id;
                    $(rowid).remove();
                }else {
                    document.getElementById("operate_result_info").style.display = "block";
                }
            })
        }
        //全选
        function selectAdmins(inputObj) {
            var inputArray = document.getElementById("datalist").getElementsByTagName("input");
            for (var i = 1; i < inputArray.length; i++) {
                if (inputArray[i].type == "checkbox") {
                    inputArray[i].checked = inputObj.checked;
                }
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
        <li><a href="/admin/admin_list" class="admin_on"></a></li>
        <li><a href="/fee/fee_list" class="fee_off"></a></li>
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
    <form action="/admin/admin_list" method="post" id="form">
        <!--查询-->
        <div class="search_add">
            <div>
                模块：
                <select name="module_id" id="selModules" class="select_search">
                    <option <c:if test="${sessionScope.admin.role.module.module_id == 0 || sessionScope.admin.role.module.module_id == null}">selected="selected"</c:if> value="0">全部</option>
                    <option <c:if test="${sessionScope.admin.role.module.module_id == 1}">selected="selected"</c:if> value="1">角色管理</option>
                    <option <c:if test="${sessionScope.admin.role.module.module_id == 2}">selected="selected"</c:if> value="2">管理员管理</option>
                    <option <c:if test="${sessionScope.admin.role.module.module_id == 3}">selected="selected"</c:if> value="3">资费管理</option>
                    <option <c:if test="${sessionScope.admin.role.module.module_id == 4}">selected="selected"</c:if> value="4">账务账号</option>
                    <option <c:if test="${sessionScope.admin.role.module.module_id == 5}">selected="selected"</c:if> value="5">业务账号</option>
                    <option <c:if test="${sessionScope.admin.role.module.module_id == 6}">selected="selected"</c:if> value="6">账单管理</option>
                    <option <c:if test="${sessionScope.admin.role.module.module_id == 7}">selected="selected"</c:if> value="7">报表</option>
                </select>
            </div>
            <div>角色：<input name="rname" type="text" value="${sessionScope.admin.role.name}" class="text_search width200"/></div>
            <div><input type="button" value="搜索" class="btn_search" onclick="search();"/></div>
            <input type="button" value="密码重置" class="btn_add" onclick="resetPwd();"/>
            <input type="button" value="增加" class="btn_add" onclick="location.href='/admin/adminAdd';"/>
        </div>
        <!--删除和密码重置的操作提示-->
        <div id="operate_result_info" class="operate_fail">
            <img src="/resource/images/close.png" onclick="this.parentNode.style.display='none';"/>
            <span>删除失败！数据并发错误。</span><!--密码重置失败！数据并发错误。-->
        </div>
        <!--数据区域：用表格展示数据-->
        <div id="data">
            <table id="datalist">
                <tr>
                    <th class="th_select_all">
                        <input type="checkbox" onclick="selectAdmins(this);"/>
                        <span>全选</span>
                    </th>
                    <th>管理员ID</th>
                    <th>姓名</th>
                    <th>登录名</th>
                    <th>电话</th>
                    <th>电子邮件</th>
                    <th>授权日期</th>
                    <th class="width100">拥有角色</th>
                    <th></th>
                </tr>
                <c:forEach items="${pb.beanList}" var="admin">
                    <tr id="${admin.admin_id}">
                        <td><input type="checkbox" value="${admin.admin_id}"/></td>
                        <td>${admin.admin_id}</td>
                        <td>${admin.name}</td>
                        <td>${admin.admin_code}</td>
                        <td>${admin.telephone}</td>
                        <td>${admin.email}</td>
                        <td>${admin.enrolldate}</td>

                        <c:if test="${admin.roles.size() > 1}">
                            <td>
                                <a class="summary" onmouseover="showDetail(true,this);"
                                   onmouseout="showDetail(false,this);">${admin.roles.get(0).name}...</a>
                                <!--浮动的详细信息-->
                                <div class="detail_info">
                                    <c:forEach items="${admin.roles}" var="role" varStatus="status">
                                        ${role.name}
                                        <c:if test="${!status.last}">
                                            、
                                        </c:if>

                                    </c:forEach>
                                </div>
                            </td>
                        </c:if>
                        <c:if test="${admin.roles.size() == 1}">
                            <td>${admin.roles.get(0).name}</td>
                        </c:if>
                        <c:if test="${admin.roles.size() == 0}">
                            <td>${""}</td>
                        </c:if>


                        <td class="td_modi">
                            <input type="button" value="修改" class="btn_modify"
                                   onclick="location.href='/admin/adminModi?admin_id=${admin.admin_id}';"/>
                            <input type="button" value="删除" class="btn_delete" onclick="deleteAdmin(${admin.admin_id});"/>
                        </td>
                    </tr>
                </c:forEach>

            </table>
        </div>
        <!--分页-->
        <div id="pages">
            <a href="/admin/admin_list">首页</a>
            <c:if test="${pb.pc > 1}">
                <a href="/admin/admin_list?pc=${pb.pc-1}">上一页</a>
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
                        <a href="/admin/admin_list?pc=${i}"
                           class="current_page">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/admin/admin_list?pc=${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pb.pc < pb.tp}">
                <a href="/admin/admin_list?pc=${pb.pc+1}">下一页</a>
            </c:if>
            <a href="/admin/admin_list?pc=${pb.tp}">尾页</a>
        </div>
    </form>
</div>
<!--主要区域结束-->
<div id="footer">
    <p>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</p>
    <span>版权所有(C)云科技有限公司 </span>
</div>
</body>
</html>
