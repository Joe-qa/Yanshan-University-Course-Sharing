function checkusername()
    {
        //用户名正则，4到16位（字母，数字，下划线，减号）
var uPattern = /^[a-zA-Z0-9_-]{4,16}$/;
        var myform = document.getElementById("form1");
        var username = myform.username.value;
        if(username.length==0){
            alert("用户名不能为空")
         return false;
        }
        else if(!uPattern.test(username))
        {
            alert("用户名不符合要求(用户名长度必须为4到16位（字母，数字，下划线，减号）)");
            return false;
        }else{
            return true;
        }
    }
    function checkpassword(){
        var pPattern = /^.*(?=.{6,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*? ]).*$/;
        var myform=document.getElementById("form1");
        var password=myform.password.value;
        if(password.length==0){
            alert("密码不能为空");
            return false;
        }
        if(!pPattern.test(password)){
            alert("密码不符合要求(最少6位，包括至少1个大写字母，1个小写字母，1个数字，1个特殊字符)");
            return false;
        }
        else
            return true;
    }
    function checkname(){
var cnPattern = /[\u4E00-\u9FA5]/;
 var myform=document.getElementById("form1");
        var name=myform.name.value;
        if(name.length==0){
            alert("姓名不能为空");
            return false;
        }
        if(!cnPattern.test(name)){
            alert("姓名不符合要求");
            return false;
        }
        else
            return true;
    }
    function checkemail(){
var ePattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
var myform=document.getElementById("form1");
        var email=myform.email.value;
        if(email.length==0){
            alert("邮箱不能为空");
            return false;
        }
        if(!ePattern.test(email)){
            alert("邮箱格式不符合要求");
            return false;
        }
        else
            return true;
    }
    function checktel(){
var mPattern = /^1[34578]\d{9}$/;
var myform=document.getElementById("form1");
        var tel=myform.tel.value;
        if(tel.length==0){
            alert("电话不能为空");
            return false;
        }
        if(!mPattern.test(tel)){
            alert("电话格式不符合要求");
            return false;
        }
        else
            return true;

    }
    function checksex(){
var myform=document.getElementById("form1");
        var sex=myform.gender.value;
        if(sex.length==0){
            alert("性别不能为空");
            return false;
        }
        else
            return true;
    }
    function checkbir(){

        var  myform=document.getElementById("form1");
        var bir=myform.birthday.value;
        if(bir.length==0)
        {
            alert("出生日期不能为空");
            return false;
        }
        else {
            return true;
        }
    }
    function check()
    {
        if(!checkusername())
            return false;
        else if(!checkpassword()) {
            return false;
        }
        else if(!checkemail()) {
            return false;
        }
        else if(!checkname()){
            return false;
        }
        else if(!checktel()) {
            return false;
        }
        else if(!checksex())
            return false;
        else if(!checkbir())
            return false;
        else
            return true;
    }