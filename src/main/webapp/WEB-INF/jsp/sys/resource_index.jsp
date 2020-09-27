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
    <link href="${ctx}/static/lib/bootstrap-treeview/bootstrap-treeview.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.css" rel="stylesheet">
</head>
<body class="content_col">
<div class="page-title">
    <div class="title_left">
        <h3>资源管理</h3>
    </div>
</div>
<div class="x_panel">
    <div class="x_content">
        <div class="col-md-3">
            <%--树形菜单--%>
            <div id="data-tree"></div>
        </div>
        <div class="col-md-9">
            <%--数据表格--%>
            <iframe
                    src="${ctx}/sys/resource/list?parentId=${parentId}"
                    frameborder="0"
                    scrolling="no"
                    id="data-resource-list"
                    width="100%"
                    height="600px">
            </iframe>
        </div>
    </div>
</div>

<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>
<script src="${ctx}/static/lib/bootstrap-treeview/bootstrap-treeview.js"></script>
<script src="${ctx}/static/lib/nprogress/nprogress.js"></script>
<script src="${ctx}/static/js/custom.js"></script>
<script>
    $.ajax({
        url: '${ctx}/sys/resource/tree',
        type: 'get',
        dataType: 'json',
        success: function (response) {
            if (response.code == 0) {
                var objTree =
                    $('#data-tree').treeview({
                        data: new Array(response.data),
                        levels: 3, // 默认打开的层级
                        // 当节点被选中的时候触发的事件
                        onNodeSelected: function (event, node) {
                            //console.log(node);
                            $('#data-resource-list').attr('src', '${ctx}/sys/resource/list?parentId=' + node.id);
                        }
                        //showCheckbox: true,//是否显示选择框
                        //hierarchicalCheck: true, //级联勾选
                        //propagateCheckEvent: true //
                    });

                // 获取所有没有被选择的节点(获取到所有节点)
                // var arr = objTree.treeview('getUnselected');
                // 获取所有节点
                var arr = objTree.treeview('getNodes');
                // 遍历每个节点
                for (var i = 0; i < arr.length; i++) {
                    var node = arr[i];
                    if (node.id == ${parentId}) {
                        // 展开该节点
                        objTree.treeview('expandNode', [node]);
                    }
                }
            } else {
                window.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
            }
        }
    });
</script>
</body>
</html>
