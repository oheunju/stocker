package approval.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import approval.model.service.ApprovalService;
import member.model.vo.Employee;
import order.model.vo.Order;
import order.model.vo.PageInfo;
import order.model.vo.Transfer;

/**
 * Servlet implementation class ApprovalServlet
 */
@WebServlet("/approval")
public class ApprovalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApprovalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* 로그인 정보 받아와서 부서마다 원하는 정보 조회해서 넘기기 */
		List<Order> list = null;
		List<Transfer> tList = null;
		
		int totalList = new ApprovalService().getListCount();
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int pageLimit = 5;
		int listLimit = 5;
		int maxPage = (int) Math.ceil((double) totalList / listLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage)
			endPage = maxPage;

		PageInfo pi = new PageInfo(totalList, currentPage, startPage, endPage, maxPage, pageLimit, listLimit);
		
//		System.out.println("pi@servlet = " + pi.toString());
		
		HttpSession session = request.getSession(); 
		Employee memberLoggedIn  = ((Employee)session.getAttribute("empLoggedIn"));
		// 발주 부서일 경우
		if(memberLoggedIn.geteDept().equals("발주")) 
		{
			list = new ApprovalService().selectWaitingOrder(pi);
		}
		
		// 재고 부서일 경우
		else if(memberLoggedIn.geteDept().equals("경기물류") || memberLoggedIn.geteDept().equals("대구물류")) 
		{
			list = new ApprovalService().selectWaitingStockOrder(pi);
			
		//이송 부서일 경우
		}else if(memberLoggedIn.geteDept().equals("이송")) {
			tList = new ApprovalService().selectWaitingStockTransfer(pi);
//			System.out.println("tList@servlet=" + tList);
		}
//		tList = new ApprovalService().selectWaitingStockTransfer(pi); 
		
//		System.out.println("list@servlet = " + list);
//		System.out.println("tList@servlet = " + tList);
		
		
		
		request.setAttribute("pi", pi);
		request.setAttribute("list", list);
		request.setAttribute("tList", tList);
		request.getRequestDispatcher("/WEB-INF/views/approval/approval.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
