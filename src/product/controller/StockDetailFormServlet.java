package product.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import order.model.vo.Transfer;
import product.model.service.StockService;
import product.model.vo.Product;
import product.model.vo.StockToTransfer;
import sales.model.vo.Shop;

/**
 * Servlet implementation class StockDetailForm
 */
@WebServlet("/stock/stockDetailForm")
public class StockDetailFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StockDetailFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tCode = request.getParameter("tCode");
		
//		System.out.println("ocode@servlet = " + oCode);
		
		Transfer t = new StockService().selectOneStockToTransfer(tCode);
		
//		System.out.println("order@servlet = " + order);
		
//		Product product = new OrderService().selectOneProduct(order.getpCode());
//		Shop shop = new OrderService().selectOneShop(order.getsCode());
		
		request.setAttribute("t", t);
//		request.setAttribute("product", product);
//		request.setAttribute("shop", shop);
		request.getRequestDispatcher("/WEB-INF/views/product/stockToTransferForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
