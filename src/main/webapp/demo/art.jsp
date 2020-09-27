<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - JS模板</title>
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
        <h2>JS模板</h2>
        <div class="clear"></div>
    </div>
    <div class="x_content">
        <div id="art-data"></div>
    </div>
</div>


<script id="art-tpl" type="text/html">
    <ul>
        {{each menuList menu }}
        <li>
            {{menu.text}}
            <ul>
                {{each menu.nodes sub_menu}}
                <li>{{sub_menu.text}}</li>
                {{/each}}
            </ul>
        </li>
        {{/each}}
    </ul>
</script>

<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>
<script src="${ctx}/static/lib/art-template/template-web.js"></script>
<script type="text/javascript">


    // var html = template('art-tpl', {
    //     hello: 'hello art-template'
    // });
    // console.log(html);
    // $('#art-data').html(html);
    $.ajax({
        url: '${ctx}/menu',
        type: 'get',
        dataType: 'json',
        success: function (response) {
            //console.log(response.data);
            var html = template('art-tpl', {
                menuList: response.data
            });
            $('#art-data').html(html);
        }
    });
</script>
</body>
</html>
