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
 * Servlet implementation class QueryUserByUsername
 */
@WebServlet("/QueryUserByUsernameServlet")
public class QueryUserByUsernameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryUserByUsernameServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String username = (String)request.getParameter("username")  ;
		System.out.println(username);
		IUserService service  = new UserServiceImpl();
		User user = service.queryUserByusername(username) ;
		System.out.println(user);
		//将此人的数据 通过前台jsp显示:studentInfo.jsp
	
		request.setAttribute("user", user);//请查询到的学生 放入request域中
		
		//如果request域没有数据,使用重定向跳转response.sendRedirect();
		//如果request域有数据 (request.setAttribute()  ),使用请求转发跳转
		request.getRequestDispatcher("userinfo.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
