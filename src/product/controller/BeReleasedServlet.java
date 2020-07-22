package product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.utill.Utils;
import product.model.service.BeReleasedService;
import product.model.vo.BeReleased;

/**
 * Servlet implementation class BeReleasedServlet
 */
@WebServlet("/product/beReleased")
public class BeReleasedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private BeReleasedService bereleasedService = new BeReleasedService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BeReleasedServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int numPerPage = 5;
		int cPage = 1;
		
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
			
		}catch(NumberFormatException e) {
			
		}
		// 출고 테이블 불러오기
		List<BeReleased> list = bereleasedService.selectAll(cPage, numPerPage);
		
//		System.out.println("servlet"+list);
		
		//pagebar		
		int totalContents = bereleasedService.selectBereleasedCount();
		String url = request.getRequestURI() + "?";
		String pageBar = Utils.getPageBarHTML(cPage, numPerPage, totalContents, url);
		
		
		request.setAttribute("list", list);
		request.setAttribute("pageBar", pageBar);
		request.getRequestDispatcher("/WEB-INF/views/product/beReleased.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
