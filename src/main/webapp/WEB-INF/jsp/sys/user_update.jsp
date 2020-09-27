<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>i-admin 后台管理系统 - 更新用户</title>
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>
<body class="content_col">
<div>
    <div class="x_panel">
        <div class="x_title">
            <h2>修改用户</h2>
            <div class="clear"></div>
        </div>
        <div class="x_content">
            <form class="form-horizontal" id="data-form" onsubmit="return false" data-parsley-validate>
                <input type="hidden" value="${user.userId}" name="userId">
                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12">
                        用户名 <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="username" class="form-control col-md-7 col-xs-12"
                               readonly
                               required minlength="4"
                               value="${user.username}"
                        >
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12">
                        手机号
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" name="mobile" class="form-control col-md-7 col-xs-12"
                               data-parsley-pattern="/^1[34578]\d{9}$/"
                               data-parsley-pattern-message="手机号码格式不正确"
                               value="${user.mobile}"
                        >
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-3 col-sm-3 col-xs-12">
                        邮箱
                    </label>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="email" name="email" value="${user.email}" class="form-control col-md-7 col-xs-12">
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
</div>
<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>

<!--表单校验-->
<script src="${ctx}/static/lib/parsleyjs/parsley.js"></script>
<script src="${ctx}/static/lib/parsleyjs/zh_cn.js"></script>

<script src="${ctx}/static/lib/nprogress/nprogress.js"></script>
<script src="${ctx}/static/js/custom.js"></script>

<script>
    $('#data-form').parsley().on('form:submit', function () {
        $.ajax({
            url: '${ctx}/sys/user/update',
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
