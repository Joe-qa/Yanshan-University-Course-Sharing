package com.user.service.impl;


import java.util.List;

import com.user.dao.IUserDao;
import com.user.dao.impl.UserDaoImpl;
import com.user.entity.User;
import com.user.service.IUserService;

public class UserServiceImpl implements IUserService {
	IUserDao userdao=new UserDaoImpl();
	public boolean addUser(User user) {
if(!userdao.isExist(user.getUsername())) {//不存在
			
			return userdao.addUser(user) ; 
		}else {
			System.out.println("此人已存在！");
			return false ;
		}
			
	}
	public boolean validateUser(User user) {
		 User user1=userdao.queryUserByusername(user.getUsername());
		 if(user1==null)
			 return false;
		 else {
			if(user1.getPassword().equals(user.getPassword()))
				return true;
			else {
				System.out.println(user1.getPassword());
				System.out.println(user.getPassword());
				return false;
			}
		}
	}
	@Override
	public boolean checkUserName(String username) {
		// TODO 自动生成的方法存根
		return userdao.isExist(username);
	}
	@Override
	public boolean updateUserByUsername(String username, User user) {
		if(userdao.isExist(username)) {
			return userdao.updateUserByUsername(username,user) ;
		}
		return false ;
	}
	@Override
	public boolean deleteUserByUsername(String username) {
		if(userdao.isExist(username)) {
			return userdao.deleteUserByUsername(username) ;
		}
		return false ;
	}
	public int getTotalCount() {
		return userdao.getTotalCount();
	}
	@Override
	public List<User> queryAllUsers() {
	return userdao.queryAllUsers();
	}
	@Override
	public List<User> queryUsersByPage(int currentPage, int pageSize) {
		return userdao.queryUsersByPage(currentPage, pageSize);
	}
	@Override
	public User queryUserByusername(String username) {
		return userdao.queryUserByusername(username);
	}

}
