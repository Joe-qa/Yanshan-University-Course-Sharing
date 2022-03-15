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
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//删除
				request.setCharacterEncoding("utf-8");
				//接收前端传来的 学号
				String username =request.getParameter("username");
				
				IUserService service = new UserServiceImpl();
				boolean result = service.deleteUserByUsername(username);
				response.setContentType("text/html; charset=UTF-8");
				response.setCharacterEncoding("utf-8");
				if(result) {
					response.sendRedirect("QueryUserByPageServlet");//重新查询 所有学生
				}else {
					response.getWriter().println("删除失败！");
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
