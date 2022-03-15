package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.service.IUserService;
import com.user.service.impl.UserServiceImpl;

/**
 * Servlet implementation class CheckUserNameServlet
 */
@WebServlet("/CheckUserNameServlet")
public class CheckUserNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckUserNameServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String r_name=request.getParameter("name");
		System.out.println(r_name);
		IUserService userService = new UserServiceImpl();
		 try {
		 //检验是否存在该用户名
		boolean isExist=userService.checkUserName(r_name);
		 System.out.println("isExist"+isExist);
		 //通知页面，到底有没有
		if(isExist){
		 response.getWriter().println(1);//存在用户名
		}else{
		 response.getWriter().println(2);//不存在该用户
		}
		 } catch (Exception e) {
		 e.printStackTrace();
		 }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
