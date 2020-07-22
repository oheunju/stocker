package product.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import order.model.service.OrderService;
import order.model.vo.Order;
import product.model.service.StockService;
import product.model.vo.BeReleased;
import product.model.vo.Product;
import sales.model.vo.Shop;

/**
 * Servlet implementation class StockOrderToBR
 */
@WebServlet("/product/stockOrderToBR")
public class StockOrderToBRServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StockOrderToBRServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String oCode = request.getParameter("oCode");
		
//		System.out.println("ocode@servlet = " + oCode);
		
		Order order = new OrderService().selectOneOrder(oCode);
		
//		System.out.println("order@servlet = " + order);
		
		Product product = new OrderService().selectOneProduct(order.getpCode());
		Shop shop = new OrderService().selectOneShop(order.getsCode());
		
		request.setAttribute("order", order);
		request.setAttribute("product", product);
		request.setAttribute("shop", shop);
		
		request.getRequestDispatcher("/WEB-INF/views/product/stockOrderForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
