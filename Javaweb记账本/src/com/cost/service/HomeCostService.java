package com.cost.service;

import java.util.List;

import com.cost.dao.HomeCostDao;
import com.cost.bean.HomeCost;

public class HomeCostService {
    
    HomeCostDao homeCostDao = new HomeCostDao();
    
    //新增消费账单
    public int add(HomeCost homecost,String username) {
        return homeCostDao.add(homecost,username);
    }
    
    //删除消费账单
    public int delete(int id,String username) {
        return homeCostDao.delete(id,username);
    }
    
    //修改消费账单
    public int update(HomeCost homecost,String username) {
        return homeCostDao.update(homecost,username);
    }
    
    //关键字查询
    public List<HomeCost> query(String keyword,String username) {
        return homeCostDao.query(keyword,username);
    }
    
    //全部消费记录
    public List<HomeCost> list(String username) {
        return homeCostDao.list(username);
    }
    
    //由id查找某条消费记录
    public HomeCost getHomeCostById(int id,String username) {
        return homeCostDao.getHomeCostById(id,username);
    }
    public HomeCost getNoteById(int id,String username) {
        return homeCostDao.getNoteById(id,username);
    }
    //查询数据总个数
    public int getTotalCount(String username) {
    	return homeCostDao.getTotalCount(username);
    }
    
    public List<HomeCost> queryCostsByPage(int currentPage,int pageSize,String username){
    	return homeCostDao.queryCostsByPage(currentPage,pageSize,username);
    } 
}
