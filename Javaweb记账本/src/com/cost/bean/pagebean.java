package com.cost.bean;

import java.util.List;

public class pagebean {
    private int currentPage;
    private int pageSize;
    private int totalCount;
    @Override
	public String toString() {
		return "pagebean [currentPage=" + currentPage + ", pageSize=" + pageSize + ", totalCount=" + totalCount
				+ ", totalPage=" + totalPage + ", homeCosts=" + homeCosts + "]";
	}
	public pagebean(int currentPage, int pageSize, int totalCount, int totalPage, List<HomeCost> homeCosts) {
		super();
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.totalPage = totalPage;
		this.homeCosts = homeCosts;
	}
	public pagebean() {
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
	public List<HomeCost> getHomeCosts() {
		return homeCosts;
	}
	public void setHomeCosts(List<HomeCost> homeCosts) {
		this.homeCosts = homeCosts;
	}
	private int totalPage;
    private List<HomeCost> homeCosts;
    
}
