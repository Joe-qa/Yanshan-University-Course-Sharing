<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户登录</title>
<link rel="stylesheet" type="text/css" href="css/style1.css">
<script type="text/javascript">
function changeR(node) {
	//用于点击时长生不同的验证码
	node.src = "randomcode.jpg?time="+new Date().getTime();
}
	  function checkusername()
    {
      var myform=document.getElementById("form1");
        var username = myform.username.value;
        if(username.length==0){
            alert("用户名不能为空")
         return false;
        }
      else{
            return true;
        }
    }
    function checkpassword(){
        var myform=document.getElementById("form1");
        var password=myform.password.value;
        if(password.length==0){
            alert("密码不能为空");
            return false;
        }
        
        else
            return true;
    }
  
    function check()
    {
        if(!checkusername())
            return false;
        else if(!checkpassword()) {
            return false;
        }
        else
            return true;
    }
    
</script>
</head>
<body class= "bg" >
<div class="container_login">
        <div style="float: left;margin: 15px;" >
            <p style="color: #20B2AA;font-size: 20px;">记账本小程序用户登录</p>
            <p style=" color: #808080; font-size: 20px;">USER LOGIN</p>
        </div>
        <div style=" float:left;width: 450px;">
            <div>
                <form id="form1" action="check.jsp" method="post" >
                    <table>
                        <tr style="padding-top: 100px">
                            <td class="td_1" ><label for="username">用户名</label></td>
                            <td class="td_2"><input type="text" name="username" id="username" placeholder="UserName"></td>
                        </tr>
                        <tr>
                            <td class="td_1"><label for="password">密码</label></td>
                            <td class="td_2"><input type="password" name="password" id="password" placeholder="Password"></td>
                        </tr>
                        <tr>
                            <td class="td_1">验证码</td>
                            <td ><a class="td_2"><img  alt="random" src="randomcode.jpg" onclick="changeR(this)" style="cursor:pointer;">
                            <input style="height: 50px;width: 135px;" type="text" name="r" id="r">
                            </a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><input type="submit" value="登录" id="submit"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div style="  float: right; margin: 15px;">
            <p style="font-size: 20px;">没有账号？<a href="register.jsp" style=" color: lightblue;">注册新账号</a></p>
        </div>
    </div>
</body>
</html>