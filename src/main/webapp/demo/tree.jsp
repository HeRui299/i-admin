<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 树状菜单</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/lib/bootstrap-treeview/bootstrap-treeview.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>

<body class="content_col">
<div class="x_panel">
    <div class="x_title">
        <h2>树状菜单</h2>
        <div class="clear"></div>
    </div>
    <div class="x_content">
        <div id="data-tree"></div>
    </div>
</div>

<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>
<!-- 多级列表树插件 -->
<script src="${ctx}/static/lib/bootstrap-treeview/bootstrap-treeview.js"></script>
<script type="text/javascript">

    $.ajax({
        url: '${ctx}/sys/resource/tree',
        type: 'get',
        dataType: 'json',
        success: function (response) {
            $('#data-tree').treeview({
                data: new Array(response.data)
            });
        }
    });

    // $('#data-tree').treeview({
    //     data: [
    //         {
    //             text: "父节点-1",
    //             nodes: [
    //                 {
    //                     text: "子节点 1-1"
    //                 },
    //                 {
    //                     text: "子节点 1-2",
    //                     nodes: [
    //                         {
    //                             text: "子节点 1-2-1"
    //                         },
    //                         {
    //                             text: "子节点 1-2-2"
    //                         }
    //                     ]
    //                 }
    //             ]
    //         },
    //         {
    //             text: "父节点-2",
    //             nodes: [
    //                 {
    //                     text: "子节点 2-1"
    //                 },
    //                 {
    //                     text: "子节点 2-2"
    //                 }
    //             ]
    //         }
    //     ]
    // });
    // var data = [{
    //     text: "Parent 1",
    //     nodes: [{
    //         text: "Child 1",
    //         nodes: [{
    //             text: "Grandchild 1"
    //         }, {
    //             text: "Grandchild 2"
    //         }]
    //     },
    //         {
    //             text: "Child 2"
    //         }
    //     ]
    // },
    //     {
    //         text: "Parent 2"
    //     },
    //     {
    //         text: "Parent 3"
    //     },
    //     {
    //         text: "Parent 4"
    //     },
    //     {
    //         text: "Parent 5"
    //     }
    // ];

    // $('#tree').treeview({
    //     data: data,
    //     onNodeSelected: function (event, node) {
    //         alert(node.text)
    //     }
    // });


    <%--$.ajax({--%>
    <%--url: '${ctx}/sys/resource/tree',--%>
    <%--type: 'get',--%>
    <%--success: function (response) {--%>
    <%--if (response.code == 0) {--%>
    <%--$('#tree').treeview({--%>
    <%--data: response.data.nodes,--%>
    <%--onNodeSelected: function (event, node) {--%>
    <%--alert(node.text)--%>
    <%--}--%>
    <%--});--%>
    <%--} else {--%>
    <%--layer.alert(response.msg, {icon: 5, offset: 'opx'});--%>
    <%--}--%>
    <%--}--%>
    <%--})--%>
</script>
</body>
</html>
