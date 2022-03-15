<%@page import="com.user.entity.User"%>
<%@page import="com.user.entity.userpage" %>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>用户信息后台管理</title>
<!-- Bootstrap 样式 -->
<link href="bootstrap/css/bootstrap.css" rel="stylesheet">
</head>
<body>
<div class="container">
<h2>用户信息后台管理</h2>
<div class="container">
	<table class="table table-striped">

	<tr><th>用户名</th><th>姓名</th><th>密码</th><th>电话</th><th>性别</th><th>生日</th><th>邮箱</th><th colspan="2">操作</th></tr>
	     <c:forEach items="${requestScope.userpage.getUsers()}" var="item">
				<tr>
				    <td>${item.username}</td>
					<td>${item.name}</td>
					<td>${item.password}</td>
					<td>${item.tel}</td>
					<td>${item.sex}</td>
					<td>${item.birthday}</td>
					<td>${item.email}</td>
					<td><a href="QueryUserByUsernameServlet?username=${item.username}">修改</a></td>
					<td><a  href="DeleteUserServlet?username=${item.username}">删除</a></td>
				</tr>
			</c:forEach>
	<%
			userpage userpage=(userpage)request.getAttribute("userpage");
			%>
			<tr>
			<%
			if(userpage.getTotalPage()==1){
				%>
				<td><a href="#">首页</a></td>
				<td><a href="#">上一页</a></td>
				<td><a href="#">下一页</a></td>
				<td><a href="#">尾页</a></td>
				<%
			}
			else if(userpage.getCurrentPage()==userpage.getTotalPage()){
		     %>		
		
				<td><a href="QueryUserByPageServlet?currentPage=1&pagesize=${pageSize}">首页</a></td>
				<td><a href="QueryUserByPageServlet?currentPage=<%=userpage.getCurrentPage()-1%>&pagesize=${pageSize}">上一页</a></td>
				<td><a href="#">下一页</a></td>
				<td><a href="#">尾页</a></td>
				<% 
			}
			else if(userpage.getCurrentPage()==1)
			   {
				
				%>
					<td><a href="#">首页</a></td>
				<td><a href="#">上一页</a></td>
			   			<td><a href="QueryUserByPageServlet?currentPage=<%=userpage.getCurrentPage()+1%>&pagesize=${pageSize}">下一页</a></td>
				<td><a href="QueryUserByPageServlet?currentPage=<%=userpage.getTotalPage()%>&pagesize=${pageSize}">尾页</a></td>
			   <% 
			   }
			else{
				
			%>
				<td><a href="QueryUserByPageServlet?currentPage=1&pagesize=${pageSize}">首页</a></td>
				<td><a href="QueryUserByPageServlet?currentPage=<%=userpage.getCurrentPage()-1%>&pagesize=${pageSize}">上一页</a></td>
				<td><a href="QueryUserByPageServlet?currentPage=<%=userpage.getCurrentPage()+1%>&pagesize=${pageSize}">下一页</a></td>
				<td><a href="QueryUserByPageServlet?currentPage=<%=userpage.getTotalPage()%>&pagesize=${pageSize}">尾页</a></td>
				<% 
				}
			%>
				<td colspan="3">
				
				<select name="pageSize" id="pageSizeSelect">
                        <option value="2">2条/页</option>
                        <option value="4">4 条/页</option>
                        <option value="5">5 条/页</option>
                </select>
				</td>
			</tr>
			
			<tr>
				<td colspan="4" >共有${requestScope.userpage.getTotalCount()}笔消费记录</td>
				<td>当前页数：<%=userpage.getCurrentPage() %> </td>
				<td>总共有<%=userpage.getTotalPage() %> 页</td>
			</tr>
		</table>
		<input type="hidden" value="${requestScope.userpage.getPageSize()}" id="size">
		<a href="register.jsp">新增</a>
	
	</table>
</div>
</div>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="js/jquery-1.7.2.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="bootstrap/js/bootstrap.js"></script>
</body>
<script>
$("#pageSizeSelect").change(function () {
    var pageSize = this.value;
    location.href = "QueryUserByPageServlet?currentPage=1&pagesize="+pageSize;
});

$(function () {
    $("#pageSizeSelect").val(${requestScope.userpage.getPageSize()});
});
</script>
</html>