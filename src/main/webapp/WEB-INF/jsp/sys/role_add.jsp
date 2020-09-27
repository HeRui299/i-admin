<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 新增角色</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>

<body class="content_col">

<div class="x_panel">
    <div class="x_title">
        <h2>新增角色</h2>
        <div class="clear"></div>
    </div>
    <div class="x_content">
        <form class="form-horizontal" id="data-form" onsubmit="return false" data-parsley-validate>
            <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12">
                    角色名称 <span class="required">*</span>
                </label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <input type="text" name="name" class="form-control" required>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12">
                    角色描述
                </label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <input type="text" name="remark" class="form-control">
                </div>
            </div>

            <div class="ln_solid"></div>
            <div class="form-group">
                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                    <button class="btn btn-primary btn-sm" type="button" onclick="window.history.go(-1);">返回</button>
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
        url: '${ctx}/sys/role/add',
        type: 'post',
        data: $("#data-form").serialize(),
        dataType: 'json',
        success: function (response) {
            if (response.code == 0) {
                window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: 't'})
                window.location.href = '${ctx}/sys/role';
            } else {
                layer.alert(response.msg, {icon: 5, offset: 't'});
            }
        }
    });
});
</script>
</body>
</html>
