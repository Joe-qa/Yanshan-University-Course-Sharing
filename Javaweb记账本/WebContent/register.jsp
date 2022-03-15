<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>用户注册</title>
<link rel="stylesheet" type="text/css" href="css/style1.css">
<script type="text/javascript" src="js/registervalidate.js"></script>
<script type="text/javascript">
	// 定义一个全局的XMLHttpRequest对象
	var xhr = false;
	// 创建XMLHttpRequest对象
	function createXHR() {
		try {
			// 适用于IE7+, Firefox, Chrome, Opera, Safari
			xhr = new XMLHttpRequest();
		} catch (e) {
			try {
				// 适用于IE6, IE5
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e1) {
				xhr = false;
			}
		}
		if (!xhr)
			alert("初始化XMLHttpRequest对象失败！");
	}
	// 进行Ajax请求和响应结果处理
	function CheckUserName(obj) {
		// 创建XMLHttpRequest对象
		createXHR();
		// 获取请求数据
		var username = obj.value;
		if(username==""||username==null)
			 document.getElementById("span01").innerHTML="<font color='red'>用户名不能为空！</font>";
			 else{
		// 设定请求地址
		var url = "CheckUserNameServlet?name=" +username;
		// 建立对服务器的调用
		xhr.open("GET", url, true);
		// 指定响应事件处理函数
		xhr.onreadystatechange = function() {
			// 当 readyState 等于 4 且状态为 200 时，表示响应已就绪
			if (xhr.readyState == 4 && xhr.status == 200) {
				// 对响应结果进行处理
				var responseData = xhr.responseText;
				// 将响应数据更新到页面控件中显示
				if(responseData==1){
					 document.getElementById("span01").innerHTML="<font color='red'>用户名已存在！</font>";
					 }else{
					 document.getElementById("span01").innerHTML="<font color='green'>√</font>";
					 }
			}
		};
		// 向服务器发出请求
		xhr.send(null);
	}
	}
</script>
</head>
<body class= "bg" >
<div class="container">
        <div style="float: left;margin: 15px;" >
            <p style="color: #20B2AA;font-size: 20px;">记账本小程序新用户注册</p>
            <p style=" color: #808080; font-size: 20px;">USER REGISTER</p>
        </div>

        <div style=" float:left;width: 450px;">
            <div>
               <form id="form1" action="AddUserServlet" method="post" onsubmit="return check()">
                    <table>
                        <tr>
                            <td class="td_1"><label for="username">用户名</label></td>
                            <td class="td_2"><input type="text" name="username" id="username" placeholder="UserName" onblur="CheckUserName(this)"><span id="span01">(用户名长度必须为4到16位（字母，数字，下划线，减号）)</span></td>
                              
                        </tr>

                        <tr>
                            <td class="td_1"><label for="password">密码</label></td>
                            <td class="td_2"><input type="password" name="password" id="password" placeholder="Password">(最少6位，包括至少1个大写字母，1个小写字母，1个数字，1个特殊字符)</td>
                        </tr>

                        <tr>
                            <td class="td_1"><label for="email">Email</label></td>
                            <td class="td_2"><input type="email" name="email" id="email" placeholder="E-mail"></td>
                        </tr>

                        <tr>
                            <td class="td_1"><label for="name">姓名</label></td>
                            <td class="td_2"><input type="text" name="name" id="name" placeholder="name"></td>
                        </tr>

                        <tr>
                            <td class="td_1"><label for="tel">手机号</label></td>
                            <td class="td_2"><input type="text" name="tel" id="tel" placeholder="TelphoneNumber"></td>
                        </tr>

                        <tr>
                            <td class="td_1"><label>性别</label></td>
                            <td class="td_2">
                                <input type="radio" name="gender" value="male"> 男
                                <input type="radio" name="gender" value="female"> 女
                            </td>
                        </tr>

                        <tr>
                            <td class="td_1"><label for="birthday">出生日期</label></td>
                            <td class="td_2"><input type="date" name="birthday" id="birthday" placeholder="Birthday"></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><input type="submit" value="注册" id="submit"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

        <div style="  float: right; margin: 15px;">
            <p style="font-size: 20px;">已有帐号？<a href="login.jsp" style=" color: lightblue;">立即登录</a></p>
        </div>
    </div>
</body>
</html>