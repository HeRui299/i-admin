<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 分配角色</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>
<body class="content_col">

<div class="page-title">
    <div class="title_left">
        <h3>给用户分配角色</h3>
    </div>
</div>
<div class="x_panel">
    <div class="row x_title">
        <div class="col-md-6">
            <h2>选择角色</h2>
        </div>
    </div>
    <div class="x_content">
        <form class="form-horizontal" id="data-form" onsubmit="return false" data-parsley-validate>
            <div class="form-group">
                <button class="btn btn-primary btn-sm" type="button" onclick="window.history.go(-1);">返回</button>
                <button class="btn btn-primary btn-sm" type="reset">重置</button>
                <button type="submit" class="btn btn-success btn-sm">保存</button>
            </div>
            <div class="ln_solid"></div>
            <div class="form-group">
                <input type="hidden" name="userId" value="${userId}">
                <c:forEach items="${userRoleList}" var="userRole">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="roleId"
                                   value="${userRole.roleId}"
                                   <c:if test="${not empty userRole.userId}">checked</c:if> > ${userRole.name}
                        </label>
                    </div>
                </c:forEach>
            </div>
        </form>
    </div>
</div>
<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>
<script src="${ctx}/static/lib/parsleyjs/parsley.js"></script>
<script src="${ctx}/static/lib/parsleyjs/zh_cn.js"></script>
<script src="${ctx}/static/lib/nprogress/nprogress.js"></script>
<script src="${ctx}/static/js/custom.js"></script>

<script>
    $('#data-form').parsley().on('form:submit', function () {
        $.ajax({
            url: '${ctx}/sys/user/assign/role',
            type: 'post',
            data: $("#data-form").serialize(),
            dataType: 'json',
            success: function (response) {
                if (response.code == 0) {
                    window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'});
                    window.location.href = '${ctx}/sys/user';
                } else {
                    window.parent.layer.alert(response.msg, {icon: 5, offset: '0px'});
                }
            }
        })
    });
</script>
</body>
</html>
