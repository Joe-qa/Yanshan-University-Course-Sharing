package com.user.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.entity.User;
import com.user.service.IUserService;
import com.user.service.impl.UserServiceImpl;

/**
 * Servlet implementation class ValidateUserServlet
 */
@WebServlet("/ValidateUserServlet")
public class ValidateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		String username=(String)request.getSession().getAttribute("username");
		String password=(String)request.getSession().getAttribute("password");
	    try {
		
		User user = new User(username, password);
		IUserService userService = new UserServiceImpl();
		boolean result = userService.validateUser(user) ;
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
	//System.out.println(user);
		if(!result) {
			response.getWriter().write("alert('登录失败')");
			request.getRequestDispatcher("login.jsp").forward(request, response);  
		}else {
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
		}
	    catch(Exception e) {
	    	e.printStackTrace();
	    }	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
