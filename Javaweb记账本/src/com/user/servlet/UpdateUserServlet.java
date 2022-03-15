package com.user.servlet;

import java.io.IOException;
import java.text.ParseException;
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
 * Servlet implementation class UpdateUserServlet
 */
@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
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
			boolean result =userService.updateUserByUsername(username, user);
			if(result) {
				response.sendRedirect("QueryUserByPageServlet");//修改完毕后 ，再次重新查询全部的学生 并显示
			}else {
				response.getWriter().println("修改失败！");
			}
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
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
