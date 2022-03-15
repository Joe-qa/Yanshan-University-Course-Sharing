package com.user.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.entity.User;
import com.user.service.IUserService;
import com.user.service.impl.UserServiceImpl;

/**
 * Servlet implementation class addServlet
 */
@WebServlet("/addServlet")
public class addServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	 private  static final SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String email=request.getParameter("email");
		String name=request.getParameter("name");
		String tel=request.getParameter("tel");
		String sex=request.getParameter("gender");
	    try {
		Date birthday=sdf.parse(request.getParameter("birthday"));
		User user = new User(username, password, email, name, tel,sex, birthday);
		IUserService userService = new UserServiceImpl();
		boolean result = userService.addUser(user) ;
	//System.out.println(user);
		if(!result) {//如果增加失败，给request放入一条数据error
			System.out.println("error");
			request.getRequestDispatcher("error.jsp").forward(request, response);  
		}else {//增加成功
			request.getRequestDispatcher("QueryUserByPaageServlet").forward(request, response);
		}
		}
	    catch(Exception e) {
	    	e.printStackTrace();
	    }	
	}

}
