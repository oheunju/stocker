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
 * Servlet implementation class CompleteApprovalServlet
 */
@WebServlet("/approval/complete")
public class CompleteApprovalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompleteApprovalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String flag = request.getParameter("flag");
		
		/* 로그인 정보 받아와서 부서마다 원하는 정보 조회해서 넘기기 */
		
		List<Order> list = null;
		List<Transfer> tList = null;
		
		int totalList = new ApprovalService().getCompleteistCount();
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
		
		
		// 발주 부서일 경우
		list = new ApprovalService().selectCompleteOrder(pi);
//		System.out.println("list@servlet = " + list);
		
		//재고 부서일 경우
		
		
		
		//이송 부서일 경우
		tList = new ApprovalService().selectCompleteTransfer(pi);
//		System.out.println("tList@servlet=" + tList);
		
		
		
		request.setAttribute("flag", flag);
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
