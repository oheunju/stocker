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

import order.model.vo.Transfer;
import product.model.service.StockService;

/**
 * Servlet implementation class StockToTransferSubmitServlet
 */
@WebServlet("/product/stockToTransferForm")
public class StockToTransferSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StockToTransferSubmitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/product/stockToTransferForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tCode = request.getParameter("tCode");
		String tTitle = request.getParameter("tTitle");
		String pCode = request.getParameter("pCode");
		int tAmount = Integer.parseInt(request.getParameter("tAmount"));
		String departureCode = request.getParameter("departureCode");
		String destinationCode = request.getParameter("destinationCode");
		String tStatus = request.getParameter("tStatus");
		String tWriter = request.getParameter("tWriter");
		Date tDate = null;
		
		Transfer sttT = new Transfer(tCode, tDate, tAmount, tStatus, departureCode, destinationCode, pCode, tTitle, tWriter);
		
		int result = new StockService().updateTransfer(sttT);
		
//		System.out.println("tCode@servlet=" + tCode);
//		System.out.println("sttT@servlet=" + sttT);
//		System.out.println("result@servlet=" + result);
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		out.print("<script>");
		
		if(result > 0) {
			session.setAttribute("msg", "이송 결재완료");
		} else {
			session.setAttribute("msg", "이송 결재실패");
		}
		
		String loc = request.getContextPath() + "/approval";
		out.print("window.opener.location.replace('" + loc + "?currentPage=1');");
		
		out.print("window.close();");
		out.print("</script>");
	}

}
