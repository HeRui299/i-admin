<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 更新资源</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>

<body class="content_col">

<div class="x_panel">
    <div class="x_title">
        <h2>更新资源</h2>
        <div class="clear"></div>
    </div>
    <div class="x_content">
        <form class="form-horizontal" id="data-form" onsubmit="return false" data-parsley-validate>
            <input type="hidden" name="parentId" value="${parent.resourceId}">
            <input type="hidden" name="resourceId" value="${resource.resourceId}">
            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2">
                    上级资源
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" value=" ${parent.name}" class="form-control" readonly>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2">
                    资源名称 <span class="required">*</span>
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" name="name" value="${resource.name}" class="form-control" required>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2">
                    资源URL
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" name="url" value="${resource.url}" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2">
                    权限名称
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" name="permission" value="${resource.permission}" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2">
                    资源类型 <span class="required">*</span>
                </label>
                <div class="col-md-3 col-sm-3 col-xs-3">

                    <select class="form-control" name="type" required>
                        <option>请选择资源类型</option>
                        <option value="0"
                                <c:if test="${resource.type==0}">selected</c:if> >目录
                        </option>
                        <option value="1"
                                <c:if test="${resource.type==1}">selected</c:if> >菜单
                        </option>
                        <option value="2"
                                <c:if test="${resource.type==2}">selected</c:if> >按钮
                        </option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2">
                    图标名称
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" name="icon" value="${resource.icon}" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2">
                    排序
                </label>
                <div class="col-md-2 col-sm-2 col-xs-2">
                    <input type="text" name="orderNum" value="${resource.orderNum}" class="form-control">
                </div>
            </div>

            <div class="ln_solid"></div>
            <div class="form-group">
                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                    <button class="btn btn-primary btn-sm" type="button" id="btn-back">返回</button>
                    <button class="btn btn-primary btn-sm" type="reset">重置</button>
                    <button type="submit" class="btn btn-success btn-sm">保存</button>
                </div>
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
        url: '${ctx}/sys/resource/update',
        type: 'post',
        data: $("#data-form").serialize(),
        dataType: 'json',
        success: function (response) {
            if (response.code == 0) {
                window.parent.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: 't'});
                //跳转到资源管理的初始化页面
                window.parent.location.href = '${ctx}/sys/resource?parentId=${parent.resourceId}';
            } else {
                window.parent.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
            }
        }
    })
});
$('#btn-back').bind('click',function () {
    window.parent.location.href = '${ctx}/sys/resource?parentId=${parent.resourceId}';
});
</script>
</body>
</html>
