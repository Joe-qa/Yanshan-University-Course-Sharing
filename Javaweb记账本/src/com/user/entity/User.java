package com.user.entity;

import java.util.Date;

public class User {
private String username;
private String password;
private String email;
private String name;
private String tel;
private String sex;
private Date  birthday;
public User (String username, String password) {
	super();
	this.username = username;
	this.password = password;
}
public User(String username, String password, String email, String name, String tel, String sex, Date birthday) {
	super();
	this.username = username;
	this.password = password;
	this.email = email;
	this.name = name;
	this.tel = tel;
	this.sex = sex;
	this.birthday = birthday;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getTel() {
	return tel;
}
public void setTel(String tel) {
	this.tel = tel;
}
public String getSex() {
	return sex;
}
public void setSex(String sex) {
	this.sex = sex;
}
public Date getBirthday() {
	return birthday;
}
public void setBirthday(Date birthday) {
	this.birthday = birthday;
}


@Override
public String toString() {
	return this.getUsername()+"-"+this.getName()+"-"+this.getSex()+"-"+this.getEmail()+"-"+this.getTel()+"-"+this.getBirthday();
}
}
