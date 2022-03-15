package com.user.entity;

import java.util.List;

public class userpage {
    private int currentPage;
    private int pageSize;
    private int totalCount;
    @Override
	public String toString() {
		return "pagebean [currentPage=" + currentPage + ", pageSize=" + pageSize + ", totalCount=" + totalCount
				+ ", totalPage=" + totalPage + ",users=" + users + "]";
	}
	public userpage(int currentPage, int pageSize, int totalCount, int totalPage, List<User> users) {
		super();
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.totalPage = totalPage;
		this.users=users;
	}
	public userpage() {
		super();
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
		this.totalPage=this.totalCount%this.pageSize==0?this.totalCount/this.pageSize:this.totalCount/this.pageSize+1;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public List<User> getUsers() {
		return users;
	}
	public void setUsers(List<User> users) {
		this.users =users;
	}
	private int totalPage;
    private List<User> users;
    
}
