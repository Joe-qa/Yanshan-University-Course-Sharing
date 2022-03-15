package com.cost.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cost.bean.HomeCost;
import com.cost.service.HomeCostService;
import com.cost.util.WebUtils;

/**
 * 访问地址url:localhost:8080/homeCost/manager/homeCostServlet
 * Servlet implementation class HomeCostServlet
 */
@WebServlet("/manager/homeCostServlet")
public class HomeCostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HomeCostService homeCostService = new HomeCostService();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if("add".equals(action)) {
            add(request, response);
        }else if("delete".equals(action)) {
            delete(request, response);
        }else if("update".equals(action)) {
            update(request, response);
        }else if("list".equals(action)) {
            list(request, response);
        }
        else if("getNoteById".equals(action)) {
			getNoteById(request, response);
		}
        else if("getHomeCostById".equals(action)) {
            getHomeCostById(request, response);
        }
       
        else if("query".equals(action)) {
            query(request, response);
        }
    }
    
    //添加消费记录
    protected void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取网页提交的参数
        String name = request.getParameter("name");
        BigDecimal money = WebUtils.bigdecimal(request.getParameter("money"), new BigDecimal(0.00));
       String note=request.getParameter("note");
        //封装成类对象
        HomeCost homeCost = new HomeCost(name,money,note);
        String username=(String)request.getSession().getAttribute("username");
        //执行添加操作，返回1,添加成功，反之失败
        if(homeCostService.add(homeCost,username) == 1) {
            //页面重定向
            response.sendRedirect(request.getContextPath()+"/QueryCostsByPageServlet");
        }else {
            //请求转发
            request.setAttribute("msg", "添加失败，联系管理员");
            request.setAttribute("homeCost", homeCost);
            request.getRequestDispatcher("/cost_edit.jsp").forward(request, response);
        }
    }
    //删除消费记录
    protected void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取id
        int id  = WebUtils.parseInt(request.getParameter("id"), 0);
        String username=(String)request.getSession().getAttribute("username");
        //执行删除操作，返回1,删除成功，反之失败
        if (homeCostService.delete(id,username) == 1) {
            //页面重定向
            response.sendRedirect(request.getContextPath()+"/QueryCostsByPageServlet");
        }else {
            //请求转发
            request.setAttribute("msg", "删除失败，联系管理员");
            request.getRequestDispatcher(request.getContextPath()+"/QueryCostsByPageServlet").forward(request, response);
        }
        
    }
    //修改消费记录
    protected void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取参数
        int id  = WebUtils.parseInt(request.getParameter("id"), 0);
        String name = request.getParameter("name");
        BigDecimal money = WebUtils.bigdecimal(request.getParameter("money"), new BigDecimal(0.00));
        String date = request.getParameter("date");
        String note=request.getParameter("note");
        String username=(String)request.getSession().getAttribute("username");
        //封装
        HomeCost homeCost = new HomeCost(id,name,money,date,note);
        //执行删除操作，返回1,修改成功，反之失败
        if(homeCostService.update(homeCost,username) == 1) {
            response.sendRedirect(request.getContextPath()+"/QueryCostsByPageServlet");
        }else {
            request.setAttribute("msg", "修改失败，联系管理员");
            request.setAttribute("homeCost", homeCost);
            request.getRequestDispatcher("/cost_edit.jsp").forward(request, response);
        }
    }
    //查询全部消费记录
    protected void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=(String)request.getSession().getAttribute("username");
    	List<HomeCost> homeCost = homeCostService.list(username);
        request.setAttribute("homeCost", homeCost);
        request.getRequestDispatcher("/manager.jsp").forward(request, response);
        
    }
    //通过id查询该条消费记录
    private void getHomeCostById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id  = WebUtils.parseInt(request.getParameter("id"), 0);
        String username=(String)request.getSession().getAttribute("username");
        HomeCost homeCost = homeCostService.getHomeCostById(id,username);
        request.setAttribute("homeCost", homeCost);
        request.getRequestDispatcher("/cost_edit.jsp").forward(request, response);
    }
    
    private void getNoteById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id  = WebUtils.parseInt(request.getParameter("id"), 0);
        String username=(String)request.getSession().getAttribute("username");
        HomeCost homeCost = homeCostService.getNoteById(id,username);
        request.setAttribute("homeCost", homeCost);
        request.getRequestDispatcher("/note.jsp").forward(request, response);
    }
    //通过关键词查询
    protected void query(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword=request.getParameter("keyword");
        String username=(String)request.getSession().getAttribute("username");
        List<HomeCost> homeCost = homeCostService.query(keyword,username);
        request.setAttribute("homeCost", homeCost);
        request.getRequestDispatcher("/query.jsp").forward(request, response);
    }
    

}

