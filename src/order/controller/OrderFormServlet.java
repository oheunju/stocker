package order.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.vo.Employee;
import order.model.service.OrderService;
import order.model.vo.Order;
import product.model.vo.Product;
import sales.model.vo.Shop;

/**
 * Servlet implementation class OrderFormServlet
 */
@WebServlet("/order/orderForm")
public class OrderFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(); 
		Employee memberLoggedIn  = ((Employee)session.getAttribute("empLoggedIn"));
		String eCode = request.getParameter("eCode");
		
		if((memberLoggedIn==null || eCode==null )
		||!("관리자".equals(memberLoggedIn.geteDept()) || "발주".equals(memberLoggedIn.geteDept())
				)){
			
			session.setAttribute("msg", "발주 담당자만 작성 가능합니다.");
			
			}
		request.getRequestDispatcher("/WEB-INF/views/order/orderForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
