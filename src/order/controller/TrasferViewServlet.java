package order.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.vo.Employee;
import order.model.service.TransferService;
import order.model.vo.Transfer;

/**
 * Servlet implementation class TrasferViewServlet
 */
@WebServlet("/order/transferView")
public class TrasferViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private TransferService transferService = new TransferService();
	
    public TrasferViewServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String tCode = request.getParameter("tCode");
	
	Transfer transfer = transferService.selectOne(tCode);
	
//	System.out.println("transfer@servlet = " + transfer);
//	System.out.println("tCode@servlet = " + tCode);
	
	HttpSession session = request.getSession(); 
	Employee empLoggedIn  = ((Employee)session.getAttribute("empLoggedIn"));
	
//	System.out.println("empLoggedIn@transferviewServlet=" + empLoggedIn);
	
	if((empLoggedIn==null)
			||!("관리자".equals(empLoggedIn.geteDept()) || "이송".equals(empLoggedIn.geteDept()))){
		
		session.setAttribute("msg", "이송 담당자만 접근 가능합니다.");
		
		}
	
	request.setAttribute("transfer", transfer);
	request.getRequestDispatcher("/WEB-INF/views/order/transferView.jsp")
			.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
