<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resource/styles/global_color.css" />
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
            //删除
            function deleteAccount() {
                var r = window.confirm("确定要删除此业务账号吗？删除后将不能恢复。");
                document.getElementById("operate_result_info").style.display = "block";
            }
            //开通或暂停
            function setState() {
                var r = window.confirm("确定要开通此业务账号吗？");
                document.getElementById("operate_result_info").style.display = "block";
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
                <li><a href="/account/account_list" class="account_off"></a></li>
                <li><a href="/service/service_list" class="service_on"></a></li>
                <li><a href="/bill/bill_list" class="bill_off"></a></li>
                <li><a href="/report/report_list" class="report_off"></a></li>
                <li><a href="/user/user_info" class="information_off"></a></li>
                <li><a href="/user/user_modi_pwd" class="password_off"></a></li>
            </ul>            
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form id="form" action="/service/service_list" method="post">
                <!--查询-->
                <div class="search_add">                        
                    <div>OS 账号：<input name="os_username" type="text" value="${sessionScope.services.os_username}" class="width100 text_search" /></div>
                    <div>服务器 IP：<input name="unix_host" type="text" value="${sessionScope.services.unix_host}" class="width100 text_search" /></div>
                    <div>身份证：<input name="idcard_no" type="text"  value="${sessionScope.services.account.idcard_no}" class="text_search" /></div>
                    <div>状态：
                        <select name="status" class="select_search">
                            <option <c:if test="${sessionScope.services.status == null}">selected="selected"</c:if> value="">全部</option>
                            <option <c:if test="${sessionScope.services.status == '0'}">selected="selected"</c:if> value="0">开通</option>
                            <option <c:if test="${sessionScope.services.status == '1'}">selected="selected"</c:if> value="1">暂停</option>
                            <option <c:if test="${sessionScope.services.status == '2'}">selected="selected"</c:if> value="2">删除</option>
                        </select>
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="search()" /></div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='service_add.jsp';" />
                </div>  
                <!--删除的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="/resource/images/close.png" onclick="this.parentNode.style.display='none';" />
                    删除成功！
                </div>   
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th class="width50">业务ID</th>
                        <th class="width70">账务账号ID</th>
                        <th class="width150">身份证</th>
                        <th class="width70">姓名</th>
                        <th>OS 账号</th>
                        <th class="width50">状态</th>
                        <th class="width100">服务器 IP</th>
                        <th class="width100">资费</th>                                                        
                        <th class="width200"></th>
                    </tr>
                        <c:forEach items="${pb.beanList}" var="service">
                            <tr>
                                <td><a href="service_detail.jsp" title="查看明细">${service.service_id}</a></td>
                                <td>${service.account_id}</td>
                                <td>${service.account.idcard_no}</td>
                                <td>${service.account.real_name}</td>
                                <td>${service.os_username}</td>
                                <td><c:if test="${service.status == '0'}">
                                    ${'开通'}
                                </c:if>
                                    <c:if test="${service.status == '1'}">
                                        ${'暂停'}
                                    </c:if>
                                    <c:if test="${service.status == '2'}">
                                        ${'删除'}
                                    </c:if></td>
                                <td>${service.unix_host}</td>
                                <td>
                                    <a class="summary"  onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">${service.cost.NAME}</a>
                                    <!--浮动的详细信息-->
                                    <div class="detail_info">
                                        ${service.cost.DESCR}
                                    </div>
                                </td>
                                <td class="td_modi">
                                    <c:if test="${service.status == '0'}">
                                        <input type="button" value="暂停" class="btn_pause" onclick="setState(${service.service_id},${service.status});"/>
                                        <input type="button" value="修改" class="btn_modify"
                                               onclick="location.href='/account/accountModi?account_id=${service.service_id}';"/>
                                        <input type="button" value="删除" class="btn_delete" onclick="deleteAccount(${service.service_id});"/>
                                    </c:if>
                                    <c:if test="${service.status == '1'}">
                                        <input type="button" value="开通" class="btn_start" onclick="setState(${service.service_id},${service.status});"/>
                                        <input type="button" value="修改" class="btn_modify" onclick="location.href='/account/accountModi?account_id=${service.service_id}';"/>
                                        <input type="button" value="删除" class="btn_delete" onclick="deleteAccount(${service.service_id});"/>
                                    </c:if>
                                    <c:if test="${service.status == '3'}">
                                        ${''}
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                </table>                
                <p>业务说明：<br />
                1、创建即开通，记载创建时间；<br />
                2、暂停后，记载暂停时间；<br />
                3、重新开通后，删除暂停时间；<br />
                4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
                5、业务账号不设计修改密码功能，由用户自服务功能实现；<br />
                6、暂停和删除状态的账务账号下属的业务账号不能被开通。</p>
                </div>                    
                <!--分页-->
                <div id="pages">
                    <a href="/service/service_list">首页</a>
                    <c:if test="${pb.pc > 1}">
                        <a href="/service/service_list?pc=${pb.pc-1}">上一页</a>
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
                                <a href="/service/service_list?pc=${i}"
                                   class="current_page">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/service/service_list?pc=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pb.pc < pb.tp}">
                        <a href="/service/service_list?pc=${pb.pc+1}">下一页</a>
                    </c:if>
                    <a href="/service/service_list?pc=${pb.tp}">尾页</a>
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
