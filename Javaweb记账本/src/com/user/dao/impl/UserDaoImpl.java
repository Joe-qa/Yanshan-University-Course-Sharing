package com.user.dao.impl;



import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import com.cost.bean.HomeCost;
import com.cost.util.DBUtils;
import com.user.dao.IUserDao;
import com.user.entity.User;
import com.user.util.DButil;

public class UserDaoImpl implements IUserDao {
	public User queryUserByusername(String username) {//3
		User user = null;
		Connection connection = null ;
		 PreparedStatement pstmt = null ;
		  ResultSet rs = null ; 
		try {
			 connection = DButil.getConnection() ;
			 String sql = "select * from users where username =? " ;
			  pstmt = connection.prepareStatement(sql) ;
			  pstmt.setString(1, username);
			   rs = pstmt.executeQuery() ;
			  if(rs.next()) { 
				  String password =   rs.getString("password") ;
				  String email =   rs.getString("email") ;
				  String name =   rs.getString("name") ;
				  String tel =   rs.getString("tel") ;
				  String sex=rs.getString("sex");
				  Date birthday=rs.getDate("birthday");
				  user = new User(username, password, email, name, tel, sex, birthday);
			  }
			  return user ;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null ; 
		} catch (SQLException e) {
			e.printStackTrace();
			return null ; 
		}catch (Exception e) {
			e.printStackTrace();
			return null ; 
		}
		finally {
				try {
					if(rs!=null)rs.close();
					if(pstmt!=null)pstmt.close();
					if(connection!=null)connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				} 
		}
	}

	public boolean addUser(User user) {
		String sql ="insert into users(username,name,password,tel,sex,birthday,email) values(?,?,?,?,?,?,?) " ;
		Object[] params = {user.getUsername(),user.getName(),user.getPassword(),user.getTel(),user.getSex(),user.getBirthday(),user.getEmail()};
		return DButil.executeUpdate(sql, params) ;
	}

	@Override
	public boolean isExist(String username) {
		boolean flag=false;
		String sql="select * from users where username = '"+username+"'";
		Object[] params =null;
		ResultSet rs=DButil.executeQuery(sql,params);
		try {
			if(rs.next())
			flag=true;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return flag;
	}

	
	@Override
	public List<User> queryAllUsers() {
		List<User> users = new ArrayList<>();
		
		Connection connection = null ;
		 PreparedStatement pstmt = null ;
		  ResultSet rs = null ; 
		try {
			 connection = DButil.getConnection() ;
			 String sql = "select * from users" ;
			  pstmt = connection.prepareStatement(sql) ;
			
			   rs = pstmt.executeQuery() ;
			  while(rs.next()) {
				 String username=rs.getString("username");
				  String password = rs.getString("password") ;
				  String email = rs.getString("email") ;
				  String name = rs.getString("name") ;
				  String tel = rs.getString("tel") ;
				  String sex=rs.getString("sex");
				  Date birthday=rs.getDate("birthday");
				 User user = new User(username, password, email, name, tel, sex, birthday);
			    
				 users.add(user);
			  }
			 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null ; 
		} catch (SQLException e) {
			e.printStackTrace();
			return null ; 
		}catch (Exception e) {
			e.printStackTrace();
			return null ; 
		}
		finally {
				try {
					if(rs!=null)rs.close();
					if(pstmt!=null)pstmt.close();
					if(connection!=null)connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				} 
		}
		 return users ;
	}

	@Override
	public int getTotalCount() {
		String sql = "select count(*) from users" ;
		return DBUtils.getTotalCount(sql);
	}

	@Override
	public List<User> queryUsersByPage(int currentPage, int pageSize) {
		int start=pageSize*(currentPage-1);
    	String sql = "select * from users limit "+start+","+pageSize;
        List<User> users = new ArrayList<>();
        Connection conn = DBUtils.getConn();
        Statement state = null;
        ResultSet rs = null;
        User user=null;
        try {
            state = conn.createStatement();
            rs = state.executeQuery(sql);
            while (rs.next()) {
            	 String username=rs.getString("username");
				  String password = rs.getString("password") ;
				  String email = rs.getString("email") ;
				  String name = rs.getString("name") ;
				  String tel = rs.getString("tel") ;
				  String sex=rs.getString("sex");
				  Date birthday=rs.getDate("birthday");
				  user = new User(username, password, email, name, tel, sex, birthday);
			    users.add(user);
             
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.close(rs, state, conn);
        }
        return users;
	}

	@Override
	public boolean updateUserByUsername(String username, User user) {
		String sql = "update users set name=?,password=?,tel=?,sex=?,birthday=?,email=? where username=?" ;
		Object[] params = {user.getName(),user.getPassword(),user.getTel(),user.getSex(),user.getBirthday(),user.getEmail(),username};
		return DButil.executeUpdate(sql, params) ;
	}

	public boolean deleteUserByUsername(String username) {
		String sql = "delete from users where username = ?" ;
		Object[] params = {username} ;
		return DButil.executeUpdate(sql, params) ;
	}
}
