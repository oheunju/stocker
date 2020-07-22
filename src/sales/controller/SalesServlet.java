package sales.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.model.service.RevenueService;
import sales.model.service.SalesService;
import sales.model.vo.MostSoldProduct;
import sales.model.vo.RankedShop;
import sales.model.vo.RankedTransfer;

/**
 * Servlet implementation class SalesServlet
 */
@WebServlet("/sales")
public class SalesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalesServlet() {
        super();
        // TODO Auto-generated constructor stub
    
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 인코딩
		request.setCharacterEncoding("utf-8");
		
		Calendar cal = Calendar.getInstance();
		int thisYear = cal.get(Calendar.YEAR);
		int thisMonth = cal.get(Calendar.MONTH)+1;
		
		
		int countInbound = new SalesService().CountInbound(thisYear, thisMonth);
		int countOutbound = new SalesService().CountOutbound(thisYear, thisMonth);
		List<RankedShop> RankedShops = new SalesService().RankingShop(thisYear);
		List<MostSoldProduct> MostSold = new SalesService().mostSoldProducts(thisYear);
		List<RankedTransfer> RankTransfer1 = new SalesService().RankTransfer1(thisYear);
		List<RankedTransfer> RankTransfer2 = new SalesService().RankTransfer2(thisYear);
		HashMap<String, Integer> Scategory = new SalesService().StockCategory();
		HashMap<String, Integer> Stheme = new SalesService().StockTheme();
		HashMap<Integer, Integer> AnnualInbound1 = new SalesService().AnnualInbound1(thisYear);
		HashMap<Integer, Integer> AnnualInbound2 = new SalesService().AnnualInbound2(thisYear);
		HashMap<Integer, Integer> AnnualOutbound1 = new SalesService().AnnualOutbound1(thisYear);
		HashMap<Integer, Integer> AnnualOutbound2 = new SalesService().AnnualOutbound1(thisYear);
		HashMap<Integer, Integer> AnnualRevenue1 = new RevenueService().AnnualRevenue1(thisYear);
		HashMap<Integer, Integer> AnnualRevenue2 = new RevenueService().AnnualRevenue2(thisYear);
		HashMap<Integer, Integer> MonthlyRevenue2 = new RevenueService().MonthlyRevenue2(thisYear);
		HashMap<Integer, Integer> MonthlyRevenue1 = new RevenueService().MonthlyRevenue1(thisYear);
		HashMap<String, Integer> DailyRevenue1 = new RevenueService().DailyRevenue1();
		HashMap<String, Integer> DailyRevenue2 = new RevenueService().DailyRevenue2();
		
		request.setAttribute("DailyRevenue2", DailyRevenue2);
		request.setAttribute("DailyRevenue1", DailyRevenue1);
		request.setAttribute("MonthlyRevenue1", MonthlyRevenue1);
		request.setAttribute("MonthlyRevenue2", MonthlyRevenue2);
		request.setAttribute("AnnualRevenue2", AnnualRevenue2);
		request.setAttribute("AnnualRevenue1", AnnualRevenue1);
		request.setAttribute("AnnualOutbound1", AnnualOutbound1);
		request.setAttribute("AnnualOutbound2", AnnualOutbound2);
		request.setAttribute("AnnualInbound2", AnnualInbound2);
		request.setAttribute("AnnualInbound1", AnnualInbound1);
		request.setAttribute("StockTheme", Stheme);
		request.setAttribute("StockCategory", Scategory);
		request.setAttribute("rankingTransfer1", RankTransfer1);
		request.setAttribute("rankingTransfer2", RankTransfer2);
		request.setAttribute("MostSold", MostSold);
		request.setAttribute("RankedShops", RankedShops);
		request.setAttribute("countOutbound", countOutbound);
		request.setAttribute("countInbound", countInbound);
		request.setAttribute("thisYear", thisYear);
		request.setAttribute("thisMonth", thisMonth);
//		System.out.println(DailyRevenue1);
		
		request.getRequestDispatcher("/WEB-INF/views/sales/sales.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
