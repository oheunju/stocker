package product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.utill.Utils;
import product.model.service.StockService;
import product.model.vo.Stock;

/**
 * Servlet implementation class StockServlet
 */
@WebServlet("/product/stk")
public class StockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private StockService stockService = new StockService();
	
    public StockServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 사용자 입력값
		int numPerPage = 10;
		int cPage = 1;
		
		
		try {
		cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {}
		
		
		String[] searchArr = new String[] {"","","","","",""}; 
		
		
		// 재고 조회
		List<Stock> list = stockService.selectStockList(cPage, numPerPage);
		
		
		//pagebar
		int totalContents = stockService.selectStockCount();
		String searchArrStr = "?"; //URL Query string 의 시작 '?'
		
		for(int i = 0; i < 6; i++) { //search 갯수 6개
			searchArrStr += "&search=" + searchArr[i]; //?->&
		}
		
		String url = request.getRequestURI()
				+ searchArrStr
				+ "&";
		
		String pageBar = Utils.getPageBarHTML(cPage, numPerPage, totalContents, url);
		
		
		request.setAttribute("list", list);
//		request.setAttribute("product", product);
		request.setAttribute("pageBar", pageBar);
		request.getRequestDispatcher("/WEB-INF/views/product/stock.jsp").forward(request, response);
		
//		System.out.println("stock@servlet="+list);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
