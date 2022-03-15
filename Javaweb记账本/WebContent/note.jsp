<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>账单详情</title>
	<!-- 采用绝对路径导入css文件 -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css" />
	<!-- 采用绝对路径导入jquery文件 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.7.2.js"></script>
	
</head>
<body>
	<div id="header">
		<span class="wel_word">账单详情${sessionScope.username}</span>
		<div>
   			<a href="${pageContext.request.contextPath }/QueryCostsByPageServlet">返回历史记录</a>
   			<input style="margin-left:20px"id="keyword" name="keyword" type="text" placeholder="请输入关键字"value=""/>
			<input id="submit"type="submit" value="查询"/>
		</div>
	</div>
	
	<div id="main">
		<form>
			
			<table>
				<tr>
					<td colspan="2">消费名称</td>
					<td colspan="2">消费金额</td>
					<td colspan="2">登记日期</td>
				
				</tr>		
				<tr>
					
					<td colspan="2"><input id="costname" name="name" type="text" placeholder="请输入名称"value="${requestScope.homeCost.name}" disabled="disabled"/></td>
					<td colspan="2"><input id="money" name="money" type="text"placeholder="请输入金额" value="${requestScope.homeCost.money}" disabled="disabled"/></td>
					<td colspan="2"><input name="date" type="text"placeholder="日期系统自动录入"value="${requestScope.homeCost.date}"disabled="disabled" /></td>
					
				</tr>
				<tr><td>备注<td><td colspan="4"><textarea id="note" name="note" rows="5" cols="75" placeholder="账单详情描述" disabled="disabled">${requestScope.homeCost.note}</textarea> </td></tr>	
				
				
			</table>
		</form>
	</div>
</body>
</html>