package com.user.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.user.entity.User;
import com.user.entity.userpage;
import com.user.service.IUserService;
import com.user.service.impl.UserServiceImpl;

/**
 * Servlet implementation class QueryUserByPageServlet
 */
@WebServlet("/QueryUserByPageServlet")
public class QueryUserByPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryUserByPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		  IUserService service = new UserServiceImpl();
		int count=service.getTotalCount();
		userpage userpage=new userpage();
		
		String cpage=request.getParameter("currentPage");
		if(cpage==null)
			cpage="1";
		int currentPage=Integer.parseInt(cpage);
		userpage.setCurrentPage(currentPage);
		userpage.setTotalCount(count);
		String size=(String)request.getParameter("pagesize");
		if(size==null||size.equals(""))
			size="2";
		int pageSize=Integer.parseInt(size);
		//System.out.println(pageSize);
		userpage.setPageSize(pageSize);
		
		List<User> users=service.queryUsersByPage(currentPage, pageSize);
	    //System.out.println(costs);
       // System.out.println(count);
        
		userpage.setUsers(users);
        request.setAttribute("userpage",userpage);
        request.getRequestDispatcher("users.jsp").forward(request, response);

		System.out.println(users);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
