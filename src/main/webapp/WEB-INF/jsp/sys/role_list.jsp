<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 角色管理</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
    <link href="${ctx}/static/lib/bootstrap-table/bootstrap-table.css" rel="stylesheet">
</head>
<body class="content_col">

<div class="page-title">
    <div class="title_left">
        <h3>角色管理</h3>
    </div>
    <div class="title_right">
        <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="请输入角色名称" id="roleName">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" id="btn-search">搜索</button>
                </span>
            </div>
        </div>
    </div>
</div>
<div class="x_panel">
    <div class="row x_title">
        <h2>角色列表</h2>
    </div>
    <div class="x_content">
        <div class="btn-toolbar">
            <div class="btn-group">
                <a href="${ctx}/sys/role/add" class="btn btn-default btn-sm">新增</a>
                <button type="button" class="btn btn-default btn-sm" id="btn-update">修改</button>
                <button type="button" class="btn btn-default btn-sm" id="btn-delete">删除</button>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-default btn-sm" id="btn-assign-resource">分配资源</button>
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
    var list_url = '${ctx}/sys/role/data';
    // 初始化表格数据
    var dataTable = $('#data-table').bootstrapTable({
        url: list_url,                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "roleId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 10,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                roleName: $("#roleName").val()
            }
        },
        columns: [{
            checkbox: true
        }, {
            field: 'name',
            title: '角色名称'
        }, {
            field: 'remark',
            title: '角色描述'
        }, {
            field: 'createTime',
            title: '创建时间'
        }, {
            field: 'updateTime',
            title: '最后更新时间'
        }]
    });
    // 查询
    $('#btn-search').bind('click', function () {
        refreshTable();
    });

    // 刷新表格
    function refreshTable() {
        dataTable.bootstrapTable('refresh', {
            url: list_url,
            pageSize: 10,
            pageNumber: 1
        });
    }

    // 修改
    $('#btn-update').click(function () {
        var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length != 1) {
            window.parent.layer.msg("一次只能修改一条数据!", {icon: 2, time: 1000, offset: 't'})
        } else {
            window.location.href = '${ctx}/sys/role/update/' + rows[0].roleId;
        }
    });

    // 删除
    $('#btn-delete').click(function () {
        var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length == 1) {
            window.parent.layer.confirm("确认删除?", {icon: 3, offset: 't'}, function () {
                $.ajax({
                    url: '${ctx}/sys/role/delete/' + rows[0].roleId,
                    type: 'get',
                    success: function (response) {
                        if (response.code == 0) {
                            window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: 't'});
                            refreshTable();
                        } else {
                            window.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                        }
                    }
                })
            })
        } else {
            window.parent.layer.confirm("确认批量删除?", {icon: 3, offset: 't'}, function () {
                var ids = new Array();
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].roleId);
                }
                $.ajax({
                    url: '${ctx}/sys/role/deletebatch',
                    contentType: "application/json; charset=UTF-8",//发送给服务器的是json数据
                    type: 'post',
                    dateType: 'json',
                    data: JSON.stringify(ids),
                    success: function (response) {
                        if (response.code == 0) {
                            window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: 't'});
                            refreshTable();
                        } else {
                            window.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                        }
                    }
                })
            })
        }
    });

    // 分配资源
    $('#btn-assign-resource').click(function () {
        var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length != 1) {
            window.parent.layer.msg("一次只能修改一条数据!", {icon: 2, time: 1000, offset: 't'})
        } else {
            window.location.href = '${ctx}/sys/role/assign/resource/' + rows[0].roleId;
        }
    });
</script>
</body>
</html>
