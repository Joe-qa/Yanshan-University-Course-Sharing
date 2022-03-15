<%@page import="com.user.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>修改用户信息</title>
<!-- Bootstrap 样式 -->
<link href="bootstrap/css/bootstrap.css" rel="stylesheet">
</head>
<body>
		<%
		
			User user = (User)request.getAttribute("user") ;
		%>
		<div class="container">
<h2>修改用户信息</h2>
		<div class="container">
    <form action="UpdateUserServlet" method="post" class="form-inline">
        <div class="form-group">
            用户名：
            <input class="form-control"  type="text" name="username"value="<%=user.getUsername() %>"  readonly="readonly"/>
        </div>
        <br>
        <div class="form-group">
            姓名：
            <input class="form-control" type="text" name="name" value="<%=user.getName() %>"/>
        </div>
        <br>
                  <div class="form-group">
            密码：
            <input class="form-control" type="text" name="password" value="<%=user.getPassword()%>">

        </div>
        <br>
          <div class="form-group">
            电话：
            <input class="form-control"  type="text" name="tel" value="<%=user.getTel() %>"/>
        </div>
        <br>
              <div class="form-group">
            性别：
            <input class="form-control" type="text" name="gender" value="<%=user.getSex() %>"/>
        </div>
        <br>
                 <div class="form-group">
            生日：
            <input class="form-control" type="date" name="birthday" value="<%=user.getBirthday()%>"/>
        </div>
        <br>
                <div class="form-group">
            电子邮箱：
            <input class="form-control" type="email" name="email" value="<%=user.getEmail() %>"/>
        </div>
        <br>
        <div class="form-group">
            	<input class="form-control" type="submit" value="修改"/>
				<a class="form-control" href="QueryUserByPageServlet">返回</a>
				
        </div>
    </form>
</div>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery-1.7.2.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="bootstrap/js/bootstrap.js"></script>
</body>
</html>