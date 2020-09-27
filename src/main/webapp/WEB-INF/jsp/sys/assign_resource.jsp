<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 分配资源</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/lib/bootstrap-treeview/bootstrap-treeview.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>

<body class="content_col">

<div class="page-title">
    <div class="title_left">
        <h3>给角色分配资源</h3>
    </div>
</div>
<div class="x_panel">
    <div class="row x_title">
        <div class="col-md-6">
            <h2>选择资源</h2>
        </div>
    </div>
    <div class="x_content">
        <input type="hidden" value="${roleId}" id="roleId">
        <div class="form-group">
            <button class="btn btn-primary btn-sm" type="button" onclick="window.history.go(-1);">返回</button>
            <button type="button" class="btn btn-success btn-sm" id="btn-save">保存</button>
            <button class="btn btn-info btn-sm" type="button" id="expandAll">全部展开</button>
            <button class="btn btn-info btn-sm" type="button" id="collapseAll">全部收起</button>
        </div>
        <div class="form-group">
            <div id="data-tree"></div>
        </div>
    </div>
</div>
<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>
<script src="${ctx}/static/lib/parsleyjs/parsley.js"></script>
<script src="${ctx}/static/lib/parsleyjs/zh_cn.js"></script>
<script src="${ctx}/static/lib/bootstrap-treeview/bootstrap-treeview.js"></script>
<script src="${ctx}/static/lib/nprogress/nprogress.js"></script>
<script src="${ctx}/static/js/custom.js"></script>
<script>
    // 获取树菜单的数据
    $.ajax({
        url: '${ctx}/sys/role/assign/resourceTree/${roleId}',
        type: 'get',
        dataType: 'json',
        success: function (response) {
            $('#data-tree').treeview({
                //data: new Array(response.data),
                data: response.data.nodes,
                levels: 2,
                showCheckbox: true,       //启用复选按钮
                hierarchicalCheck: true   //级联勾选
            });
        }
    });

    $('#btn-save').bind('click', function () {
        // 角色id
        var roleId = $('#roleId').val();
        //node-checked
        //node-checked-partial
        var roleResourceList = [];
        $('.node-checked,.node-checked-partial').each(function () {
            var roleResource = {
                roleId:roleId,
                resourceId:$(this).attr('id')
            };
            //将对象放入到数组中
            roleResourceList.push(roleResource);
        });
        console.log(roleResourceList);

        $.ajax({
            url: '${ctx}/sys/role/assign/resource/' + roleId,
            contentType: "application/json; charset=UTF-8",//发送给服务器的是json数据
            type: 'post',
            data: JSON.stringify(roleResourceList),
            dataType: 'json',
            success: function (response) {
                if (response.code == 0) {
                    window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'});
                    window.location.href = '${ctx}/sys/role';
                } else {
                    window.parent.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                }
            }
        });
    });
</script>
</body>
</html>
