package com.user.service;

import java.util.List;

import com.user.entity.User;

public interface IUserService {
	public boolean addUser(User user);
	public boolean validateUser(User user);
	public boolean checkUserName(String username);
	public boolean updateUserByUsername(String usernam,User user)  ;
	public boolean deleteUserByUsername(String username);
	public int getTotalCount();
	public List<User> queryAllUsers() ;
	public List<User> queryUsersByPage(int currentPage,int pageSize) ;
	public User queryUserByusername(String username);
}
