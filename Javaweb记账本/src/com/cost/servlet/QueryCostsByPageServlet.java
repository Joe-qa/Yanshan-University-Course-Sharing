package com.cost.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cost.bean.HomeCost;
import com.cost.bean.pagebean;
import com.cost.service.HomeCostService;

/**
 * Servlet implementation class QueryCostsByPageServlet
 */
@WebServlet("/QueryCostsByPageServlet")
public class QueryCostsByPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryCostsByPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HomeCostService homeCostService = new HomeCostService();
		//request.getSession().setAttribute("username", "qa");
		String username=(String)request.getSession().getAttribute("username");
		System.out.println(username);
		int count=homeCostService.getTotalCount(username);
		
		pagebean pagebean=new pagebean();
		String cpage=request.getParameter("currentPage");
		if(cpage==null)
			cpage="1";
		int currentPage=Integer.parseInt(cpage);
		pagebean.setCurrentPage(currentPage);
		pagebean.setTotalCount(count);
		String size=(String)request.getParameter("pagesize");
		if(size==null||size=="")
			size="5";
		int pageSize=Integer.parseInt(size);
		//System.out.println(pageSize);
		pagebean.setPageSize(pageSize);
		
		List<HomeCost> costs=homeCostService.queryCostsByPage(currentPage, pageSize,username);
	    //System.out.println(costs);
       // System.out.println(count);
        
        pagebean.setHomeCosts(costs);
        request.setAttribute("page", pagebean);
        request.getRequestDispatcher("manager.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
