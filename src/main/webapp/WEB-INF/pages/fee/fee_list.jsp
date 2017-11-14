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
        //排序按钮的点击事件
        function sort(btnObj) {
            var str = btnObj.value;

            if (btnObj.className == "sort_desc") {
                if (str == '基费') {
                    window.location.href = "/fee/fee_list/?str=base_cost asc&sort=sort_asc";
                }
                if (str == '时长') {
                    window.location.href = "/fee/fee_list/?str=base_duration asc&sort=sort_asc";
                }

                btnObj.className = "sort_asc";
            } else {
                btnObj.className = "sort_desc";
                if (str == '基费') {
                    window.location.href = "/fee/fee_list/?str=base_cost desc&sort=sort_desc";
                }
                if (str == '时长') {
                    window.location.href = "/fee/fee_list/?str=base_duration desc&sort=sort_desc";
                }
            }


        }

        //启用
        function startFee(id) {
            var r = window.confirm("确定要启用此资费吗？资费启用后将不能修改和删除。");
            $.post("/fee/fee_start", {"id": id}, function (result) {
                if (result.errorCode == 0) {
                    document.getElementById("operate_result_info").style.display = "block";
                    location.href="/fee/fee_list";
                }
            })

        }
        //删除
        function deleteFee(id) {
            var r = window.confirm("确定要删除此资费吗？");
            $.post("/fee/fee_delete", {"id": id}, function (result) {
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
    <img src="../images/logo.png" alt="logo" class="left"/>
    <a href="#">[退出]</a>
</div>
<!--Logo区域结束-->
<!--导航区域开始-->
<div id="navi">
    <ul id="menu">
        <li><a href="/index" class="index_off"></a></li>
        <li><a href="/role_list" class="role_off"></a></li>
        <li><a href="/admin_list" class="admin_off"></a></li>
        <li><a href="/fee/fee_list" class="fee_on"></a></li>
        <li><a href="/account_list" class="account_off"></a></li>
        <li><a href="/service_list" class="service_off"></a></li>
        <li><a href="/bill_list" class="bill_off"></a></li>
        <li><a href="/report_list" class="report_off"></a></li>
        <li><a href="/user_info" class="information_off"></a></li>
        <li><a href="/user_modi_pwd" class="password_oof"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<!--主要区域开始-->
<div id="main">
    <form action="" method="">
        <!--排序-->
        <div class="search_add">
            <div>
                <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />-->
                <input type="button" value="基费"
                        <c:if test="${sort == null}">
                            class="sort_asc"
                        </c:if>
                        <c:if test="${sort != null}">
                            class="${sort}"
                        </c:if>
                       onclick="sort(this);"/>
                <input type="button" value="时长"
                        <c:if test="${sort == null}">
                            class="sort_asc"
                        </c:if>
                        <c:if test="${sort != null}">
                            class="${sort}"
                        </c:if>
                       onclick="sort(this);"/>
            </div>
            <input type="button" value="增加" class="btn_add" onclick="location.href='/fee/feeAdd';"/>
        </div>
        <!--启用操作的操作提示-->
        <div id="operate_result_info" class="operate_success">
            <img src="/resource/images/close.png" onclick="this.parentNode.style.display='none';"/>
            删除成功！
        </div>
        <!--数据区域：用表格展示数据-->
        <div id="data">
            <table id="datalist">
                <tr>
                    <th>资费ID</th>
                    <th class="width100">资费名称</th>
                    <th>基本时长</th>
                    <th>基本费用</th>
                    <th>单位费用</th>
                    <th>创建时间</th>
                    <th>开通时间</th>
                    <th class="width50">状态</th>
                    <th class="width200"></th>
                </tr>
                <c:forEach items="${pb.beanList}" var="cost">
                    <tr id="${cost.COST_ID}">
                        <td>${cost.COST_ID}</td>
                        <td><a href="fee_detail.jsp">${cost.NAME}</a></td>
                        <td>${cost.BASE_DURATION}</td>
                        <td>${cost.BASE_COST} 元</td>
                        <td>${cost.UNIT_COST} 元/小时</td>
                        <td>${cost.CREATIME}</td>
                        <td>${cost.STARTIME}</td>
                        <td><c:if test="${cost.STATUS == '0'}">
                            ${'暂停'}
                        </c:if>
                            <c:if test="${cost.STATUS == '1'}">${'开通'}</c:if>
                        </td>
                        <td>
                            <c:if test="${cost.STATUS == '0'}">
                                <input type="button" value="启用" class="btn_start" onclick="startFee(${cost.COST_ID});"/>
                                <input type="button" value="修改" class="btn_modify"
                                       onclick="location.href='/fee/feeModi?cost_id=${cost.COST_ID}';"/>
                                <input type="button" value="删除" class="btn_delete"
                                       onclick="deleteFee(${cost.COST_ID});"/>
                            </c:if>
                            <c:if test="${cost.STATUS == '1'}">${''}</c:if>
                        </td>
                    </tr>
                </c:forEach>

            </table>
            <p>业务说明：<br/>
                1、创建资费时，状态为暂停，记载创建时间；<br/>
                2、暂停状态下，可修改，可删除；<br/>
                3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br/>
                4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
            </p>
        </div>
        <!--分页-->
        <div id="pages">

            <c:if test="${pb.pc > 1}">
                <a href="/fee/fee_list?pc=${pb.pc-1}&str=${sessionScope.str}&sort=${sort}">上一页</a>
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
                        <a href="/fee/fee_list?pc=${i}&str=${sessionScope.str}&sort=${sort}"
                           class="current_page">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/fee/fee_list?pc=${i}&str=${sessionScope.str}&sort=${sort}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pb.pc < pb.tp}">
                <a href="/fee/fee_list?pc=${pb.pc+1}&str=${sessionScope.str}&sort=${sort}">下一页</a>
            </c:if>


        </div>
    </form>
</div>
<!--主要区域结束-->
<div id="footer">
    <p>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</p>
    <p>版权所有(C)云科技有限公司</p>
</div>
</body>
</html>
