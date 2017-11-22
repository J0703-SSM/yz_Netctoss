<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css" />
        <script src="/resource/js/JQ3.2.1.js"></script>
        <script language="javascript" type="text/javascript">
            function deleteRole(id) {
                var r = window.confirm("确定要删除此角色吗？");
                $.post("/role/role_delete", {"id": id}, function (result) {
                    if (result.errorCode == 0) {
                        // 删除某一行
                        document.getElementById("operate_result_info").style.display = "block";
                        var rowid = "#" + id;
                        $(rowid).remove();
                    }
                })

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
            <form action="" method="">
                <!--查询-->
                <div class="search_add">
                    <input type="button" value="增加" class="btn_add" onclick="location.href='/role/roleAdd';" />
                </div>  
                <!--删除的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="/resource/images/close.png" onclick="this.parentNode.style.display='none';" />
                    删除成功！
                </div> <!--删除错误！该角色被使用，不能删除。-->
                <!--数据区域：用表格展示数据-->     
                <div id="data">                      
                    <table id="datalist">
                        <tr>                            
                            <th>角色 ID</th>
                            <th>角色名称</th>
                            <th class="width600">拥有的权限</th>
                            <th class="td_modi"></th>
                        </tr>
                        <c:forEach items="${pb.beanList}" var="role">
                            <tr id="${role.role_id}">
                                <td>${role.role_id}</td>
                                <td>${role.name}</td>
                                <td><c:forEach items="${role.modules}" var="module" varStatus="status">
                                    ${module.name}
                                    <c:if test="${!status.last}">
                                        、
                                    </c:if>
                                </c:forEach> </td>
                                <td>
                                    <input type="button" value="修改" class="btn_modify" onclick="location.href='/role/roleModi?role_id=${role.role_id}';"/>
                                    <input type="button" value="删除" class="btn_delete" onclick="deleteRole(${role.role_id});" />
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div> 
                <!--分页-->
                <div id="pages">
                    <a href="/role/role_list">首页</a>
                    <c:if test="${pb.pc > 1}">
                        <a href="/role/role_list?pc=${pb.pc-1}">上一页</a>
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
                                <a href="/role/role_list?pc=${i}"
                                   class="current_page">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/role/role_list?pc=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pb.pc < pb.tp}">
                        <a href="/role/role_list?pc=${pb.pc+1}">下一页</a>
                    </c:if>
                    <a href="/role/role_list?pc=${pb.tp}">尾页</a>
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
