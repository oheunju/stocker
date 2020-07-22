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
 * Servlet implementation class StockFinderServlet
 */
@WebServlet("/product/stockSearch")
public class StockSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StockSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String[] searchArr = request.getParameterValues("search");
		
		int numPerPage = 10;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
		}

		
		//contents
		List<Stock> list = new StockService().searchStock
									(searchArr, cPage, numPerPage);
//		System.out.println("list@servlet = " + list.toString());
		
		//pageBar
		int totalContents = new StockService().selectTotalContents(searchArr);
		String searchArrStr = "";
//		System.out.println("totalContents = " + totalContents);
		
		
		for(int i = 0; i < 4; i++)
			searchArrStr += "?search=" + searchArr[i];
		
		String url = request.getRequestURI()
					+ searchArrStr
					+ "&";
//		System.out.println("totalContents@servlet = " + totalContents);
		String pageBar = Utils.getPageBarHTML(cPage, numPerPage, totalContents, url);
		request.setAttribute("list", list);
		request.setAttribute("pageBar", pageBar);
		request.getRequestDispatcher("/WEB-INF/views/product/stock.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
