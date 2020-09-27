<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>i-admin 后台管理系统 - 首页</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${ctx}/static/lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/static/lib/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/static/lib/nprogress/nprogress.css" rel="stylesheet">
    <link href="${ctx}/static/css/custom.min.css" rel="stylesheet">
</head>
<body class="nav-md">
<div class="container body">
    <div class="main_container">
        <!-- header content -->
        <div class="top_nav">
            <div class="nav_menu">
                <nav>
                    <div class="nav toggle">
                        <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                    </div>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="">
                            <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown"
                               aria-expanded="false">
                                <img src="static/img/img.jpg" alt=""> <shiro:principal property="username"/>
                                <span class=" fa fa-angle-down"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-usermenu pull-right">
                                <li><a href="javascript:;">个人信息</a></li>
                                <li><a href="javascript:;">修改密码</a></li>
                                <li><a href="${ctx}/logout"><i class="fa fa-sign-out pull-right"></i>退出</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <!-- /header content -->

        <!--left menu -->
        <div class="col-md-3 left_col">
            <div class="left_col scroll-view">
                <div class="navbar nav_title" style="border: 0;">
                    <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span>i-admin</span></a>
                </div>

                <div class="clearfix"></div>

                <!-- 个人信息 -->
                <div class="profile clearfix">
                    <div class="profile_pic">
                        <img src="static/img/img.jpg" class="img-circle profile_img">
                    </div>
                    <div class="profile_info">
                        <span>欢迎使用</span>
                        <h2>风轻云淡</h2>
                    </div>
                </div>
                <!-- / 个人信息 -->

                <!-- 导航菜单 -->
                <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                    <div class="menu_section">
                        <ul class="nav side-menu"></ul>
                    </div>
                </div>
                <!-- /导航菜单 -->
            </div>
        </div>
        <!--/left menu -->

        <!-- page content -->
        <div class="right_col">
            <iframe
                    src="${ctx}/main"
                    frameborder="0"
                    scrolling="no"
                    id="main-body"
                    name="main-body"
                    width="100%"
                    height="1200px">
            </iframe>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
            <div class="pull-right">
                I-Admin - Bootstrap Admin Template by <a href="https://colorlib.com">风轻云淡</a>
            </div>
            <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
    </div>
</div>
<script src="${ctx}/static/lib/jquery/jquery.js"></script>
<script src="${ctx}/static/lib/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/static/lib/layer/layer.js"></script>
<script src="${ctx}/static/lib/art-template/template-web.js"></script>
<script src="${ctx}/static/lib/nprogress/nprogress.js"></script>
<script src="${ctx}/static/js/custom.js"></script>


<script id="tpl-menu" type="text/html">
    {{each menuList menu}}
    <li>
        <a><i class="{{menu.icon}}"></i>{{menu.text}}<span class="fa fa-chevron-down"></span></a>
        <ul class="nav child_menu">
            {{each menu.nodes sub_menu}}
            <li>
                {{if sub_menu.nodes}}
                <a href="javascript:;" url="${ctx}/{{sub_menu.url}}">{{sub_menu.text}}</a>
                {{else}}
                <a href="javascript:;">{{sub_menu.text}}<span class="fa fa-chevron-down"></span></a>
                <ul class="nav child_menu">
                    {{each sub_menu.nodes sub_sub_menu}}
                    <li>
                        <a href="javascript:;"
                           url="${ctx}/{{sub_sub_menu.url}}">{{sub_sub_menu.text}}</a>
                    </li>
                    {{/each}}
                </ul>
                {{/if}}
            </li>
            {{/each}}
        </ul>
    </li>
    {{/each}}
</script>

<script>
    $.ajax({
        url: '${ctx}/menu',
        type: 'get',
        dataType: 'json',
        success: function (response) {
            if (response.code == 0) {
                var html = template('tpl-menu', {
                    menuList: response.data
                });
                $('#sidebar-menu .side-menu').html(html);
                init_sidebar();
                // 点击左侧菜单
                $('.child_menu a').click(function () {
                    $('.child_menu li').removeClass('active');
                    var url = $(this).attr('url');
                    if (url) {
                        $('#main-body').attr('src', url);
                    }
                });
            } else {
                window.parent.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
            }
        }
    });
</script>
</body>
</html>