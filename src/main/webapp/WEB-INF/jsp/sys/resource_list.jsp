<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 资源管理</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/lib/bootstrap-table/bootstrap-table.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>
<body class="content_col">
<div class="x_panel">
    <div class="row x_title">
        <h5>${parent.name}</h5>
    </div>
    <div class="x_content">
        <div class="btn-toolbar">
            <div class="btn-group">
                <a href="${ctx}/sys/resource/add/${parent.resourceId}" class="btn btn-default btn-sm">添加菜单</a>
                <button type="button" class="btn btn-default btn-sm" id="btn-update">修改</button>
                <button type="button" class="btn btn-default btn-sm" id="btn-delete">删除</button>
            </div>
        </div>
        <div class="ln_solid_0"></div>
        <table id="data-table"></table>
    </div>
</div>
<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>
<script src="${ctx}/static/lib/bootstrap-table/bootstrap-table.js"></script>
<script src="${ctx}/static/lib/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="${ctx}/static/lib/nprogress/nprogress.js"></script>
<script src="${ctx}/static/js/custom.js"></script>
<script>
    var list_url = '${ctx}/sys/resource/data';
    // 初始化表格数据
    var dataTable = $('#data-table').bootstrapTable({
        url: list_url,   //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "resourceId",             //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 10,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                parentId: ${parent.resourceId}
            }
        },
        columns: [{
            checkbox: true
        }, {
            field: 'icon',
            title: '图标',
            align: 'center',
            width: '20',
            formatter: function (value, row, index) {
                var icon = '<i class="' + row.icon + '"></i> '
                return icon;
            }
        }, {
            field: 'orderNum',
            title: '排序'
        }, {
            field: 'name',
            title: '资源名称'
        }, {
            field: 'type',
            title: '资源类型',
            formatter: function (value, row, index) {
                if (row.type == 0) {
                    return '目录';
                }
                if (row.type == 1) {
                    return '菜单';
                }
                if (row.type == 2) {
                    return '按钮';
                }

            }
        }, {
            field: 'url',
            title: '资源路径'
        }, {
            field: 'permission',
            title: '权限'
        }]
    });

    // 修改
    $('#btn-update').click(function () {
        var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length != 1) {
            window.parent.parent.layer.msg("一次只能修改一条数据!", {icon: 2, time: 1000, offset: 't'})
        } else {
            window.location.href = '${ctx}/sys/resource/update/' + rows[0].resourceId;
        }
    });

// 删除
$('#btn-delete').click(function () {
    var rows = $('#data-table').bootstrapTable('getSelections');
    if (rows.length == 0) {
        window.parent.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
    } else if (rows.length == 1) {
        window.parent.parent.layer.confirm("确认删除?", {icon: 3, offset: 't'}, function () {
            $.ajax({
                url: '${ctx}/sys/resource/delete/' + rows[0].resourceId,
                type: 'get',
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
        })
    } else {
        window.parent.parent.layer.confirm("确认批量删除?", {icon: 3, offset: 't'}, function () {
            var ids = new Array();
            for (var i = 0; i < rows.length; i++) {
                ids.push(rows[i].resourceId);
            }
            $.ajax({
                url: '${ctx}/sys/resource/deletebatch',
                contentType: "application/json; charset=UTF-8",//发送给服务器的是json数据
                type: 'post',
                dateType: 'json',
                data: JSON.stringify(ids),
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
        })
    }
});
</script>
</body>
</html>
