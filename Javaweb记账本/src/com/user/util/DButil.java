package com.user.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;




public class DButil {
private static final String URL="jdbc:mysql://localhost:3306/jz?serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
private static final  String Name="com.mysql.cj.jdbc.Driver";
private static final String username="root";
private static final String password="12297804qa";
public static PreparedStatement pstmt = null ;
public static Connection connection = null ;
public static ResultSet rs = null ; 
public static boolean executeUpdate(String sql,Object[] params) {
	try {  
		  pstmt = createPreParedStatement(sql,params);
		  int count = pstmt.executeUpdate() ;
		  if(count>0)
			  return true ;
		  else 
			  return false ;
		  
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
		  return false ;
	} catch (SQLException e) {
		e.printStackTrace();
		  return false ;
	}catch (Exception e) {
		e.printStackTrace();
		return false ;
	}
	finally {
		closeAll(null,pstmt,connection);
	}
}
public static void closeAll(ResultSet rs,Statement stmt,Connection connection)
{
	try {
		if(rs!=null)rs.close();
		if(pstmt!=null)pstmt.close();
		if(connection!=null)connection.close();
	} catch (SQLException e) {
		e.printStackTrace();
	} 
	
	
}
public static Connection getConnection() throws ClassNotFoundException, SQLException {
	 Class.forName(Name) ;
	 return  DriverManager.getConnection( URL,username,password ) ;
}

public static PreparedStatement createPreParedStatement(String sql,Object[] params) throws ClassNotFoundException, SQLException {
	  pstmt = getConnection() .prepareStatement( sql) ;
	  if(params!=null ) {
		  for(int i=0;i<params.length;i++) {
			  pstmt.setObject(i+1, params[i]);
		  }
	  }
	  return pstmt;
}
public static ResultSet executeQuery( String sql ,Object[] params) {
	try {
		pstmt = createPreParedStatement(sql,params);
		 rs =  pstmt.executeQuery() ;
		  return rs ;
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

}




}
