<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//检查是否是正确的验证码
	String k = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
	System.out.print(k);
	String str = request.getParameter("r");
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	if(username.length()==0){
		response.getWriter().write("<script language=javascript>alert('用户名不能为空');window.location='login.jsp'</script>");
	}
	else{
		if(password.length()==0){
			response.getWriter().write("<script language=javascript>alert('密码不能为空');window.location='login.jsp'</script>");
		}
		else{
			if(!k.equals(str)){
				response.getWriter().write("<script language=javascript>alert('验证码错误');window.location='login.jsp'</script>");
			}
			else{
				session.setAttribute("username",username);
				session.setAttribute("password", password);
				response.sendRedirect("ValidateUserServlet");
			}
		}
	}
	%>
</body>
</html>