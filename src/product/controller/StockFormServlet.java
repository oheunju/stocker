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

import member.model.vo.Employee;
import product.model.service.StockService;
import product.model.vo.StockToTransfer;


/**
 * Servlet implementation class StockFormServlet
 */
@WebServlet("/product/stockForm")
public class StockFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public StockFormServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(); 
		Employee memberLoggedIn  = ((Employee)session.getAttribute("empLoggedIn"));
		String eCode = request.getParameter("eCode");
		
		if((memberLoggedIn==null || eCode==null )
		||!(
				"관리자".equals(memberLoggedIn.geteDept()) || "물류".equals(memberLoggedIn.geteDept().substring(2))
				)){
			session.setAttribute("msg", "재고 담당자만 작성 가능합니다.");
			}
		request.getRequestDispatcher("/WEB-INF/views/product/stockForm.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//		private String pCode; //상품코드 d
//		private int tAmount; //이송량 d
//		private Date tDate; //이송일
//		private String departureCode; //출발지코드 d
//		private String destinationCode; //도착지코드 d
//		private String tStatus; // 이송여부
//		private String tTitle; //이송요청품의서 제목 d
//		private String tWriter; //이송요청서 작성자(재고담당)
		String tTitle = request.getParameter("tTitle");
		String pCode = request.getParameter("pCode");
		int tAmount = Integer.parseInt(request.getParameter("tAmount"));
		String departureCode = request.getParameter("departureCode");
		String destinationCode = request.getParameter("destinationCode");
		String tStatus = null;
		Date tDate = null;
		String tWriter = request.getParameter("tWriter");
		
		StockToTransfer reqTransfer = new StockToTransfer(pCode, tAmount, tDate, departureCode, destinationCode, tStatus, tTitle, tWriter);
		
		
//		System.out.println("reqTransfer@servlet="+reqTransfer);
		
		int result = new StockService().insertStockToTransfer(reqTransfer);
		


		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		out.print("<script>");
		
		String loc = request.getContextPath() + "/product/stk";
		out.print("window.opener.location.replace('" + loc + "');");
		if(result > 0)
		{
			session.setAttribute("msg", "이송요청 완료");
		}
		else
		{
			session.setAttribute("msg", "이송요청 실패");
		}
		out.print("window.close();");
		out.print("</script>");
		
		
	}

}
