package product.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import product.model.service.StockService;
import product.model.vo.BeReleased;

/**
 * Servlet implementation class StockOrderToBRSubmitServlet
 */
@WebServlet("/product/stockOrderToBRSubmit")
public class StockOrderToBRSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StockOrderToBRSubmitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/views/product/stockOrderForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		private String rCode; // 출고코드
//		private String oCode; // 발주코드
//		private String tCode; // 이송코드
//		private String pCode; // 상품코드
//		private int rAmount; // 출고수량
//		private String rReason; // 출고사유
//		private Date rDate; // 출고일
		
		String rCode = null;
		String oCode = request.getParameter("oCode");
		String tCode = null;
		String pCode = request.getParameter("pCode");
		int rAmount = Integer.parseInt(request.getParameter("oAmount"));
		String rReason = null;
		Date rDate = null;
		
		BeReleased BR = new BeReleased(rCode, oCode, tCode, pCode, rAmount, rReason, rDate);
		
		int result = new StockService().insertStockToBR(BR);
		
//		System.out.println("servlet@insertSTBR="+result);
		
//		System.out.println(BR);
//		System.out.println(result);
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		out.print("<script>");
		
		String loc = request.getContextPath() + "/approval";
		out.print("window.opener.location.replace('" + loc + "?currentPage=1');");
		if(result > 0)
		{
			session.setAttribute("msg", "결재 완료");
		}
		else
		{
			session.setAttribute("msg", "결재 실패");
		}
		out.print("window.close();");
		out.print("</script>");
		
	}

}
