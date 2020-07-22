package product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import order.model.vo.PageInfo;
import product.model.service.WService;
import product.model.vo.Warehousing;

/**
 * Servlet implementation class SearchWarehousingServlet
 */
@WebServlet("/product/searchWarehousing")
public class SearchWarehousingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchWarehousingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] search = request.getParameterValues("search");
		
		int totalList = new WService().getSearchListCount(search);
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int pageLimit = 5;
		int listLimit = 5;
		int maxPage = (int) Math.ceil((double) totalList / listLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage)
			endPage = maxPage;

		PageInfo pi = new PageInfo(totalList, currentPage, startPage, endPage, maxPage, pageLimit, listLimit);
		
		List<Warehousing> wList = new WService().searchWarehousing(pi, search);
		
		
		request.setAttribute("pi", pi);
		request.setAttribute("wList", wList);
		request.setAttribute("search", search);
		request.getRequestDispatcher("/WEB-INF/views/product/warehousing.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
