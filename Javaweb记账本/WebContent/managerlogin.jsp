<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>简易管理员登录界面（bootstrap）</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
</head>
<body>
　　<form id="form0" action="ManagerServlet" class="form-horizontal" method="post">
    　　<div class="container">
    　　　　<div class="row">
    　　　　　　<h3 class="col-lg-3">管理员登录页面</h3>
    　　　　</div>

    　　　　<div class="form-group">
    　　　　　　<label class="control-label col-lg-1">用户名：</label>
    　　　　　　<div class="row col-lg-3">
    　　　　　　　　<input type="text" name="username" id="username" class="form-control">
    　　　　　　</div>
    　　　　</div>

    　　　　<div class="form-group">
    　　　　　　<label class="control-label col-lg-1">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
    　　　　　　<div class="row col-lg-3">
    　　　　　　　　<input type="password" name="password" id="password" class="form-control">
    　　　　　　</div>
    　　　　</div>
    　　　　<input type="submit" value="登录" class="btn btn-primary">
    　　</div>
    　　</form>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery-1.7.2.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="bootstrap/js/bootstrap.js"></script>
</body>
</html>