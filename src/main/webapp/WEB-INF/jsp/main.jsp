<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 系统主页</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/lib/bootstrap-table/bootstrap-table.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>
<body class="content_col">

<div class="page-title">
    <div class="title_left">
        <h3>欢迎使用</h3>
    </div>
</div>
<div class="x_panel">
    <div class="row x_title">
        <div class="col-md-6">
            <h2>系统主页</h2>
        </div>
    </div>
    <div class="x_content">

    </div>
</div>

<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>

<script src="${ctx}/static/lib/bootstrap-table/bootstrap-table.js"></script>
<script src="${ctx}/static/lib/bootstrap-table/bootstrap-table-zh-CN.js"></script>

<script src="${ctx}/static/lib/nprogress/nprogress.js"></script>
<script src="${ctx}/static/js/custom.js"></script>
</body>
</html>
