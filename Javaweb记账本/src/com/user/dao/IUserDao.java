package com.user.dao;

import java.util.List;


import com.user.entity.User;

public interface IUserDao {
	public User queryUserByusername(String username);
	public boolean addUser(User user);
	public List<User> queryAllUsers() ;
	public boolean isExist(String username);
	public int getTotalCount();
	public List<User> queryUsersByPage(int currentPage,int pageSize) ;
	public boolean updateUserByUsername(String username,User user)  ;
	public boolean deleteUserByUsername(String username);
}
