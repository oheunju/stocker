package order.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import order.model.service.OrderService;
import order.model.vo.Order;

/**
 * Servlet implementation class SubmitApprovalServlet
 */
@WebServlet("/order/submitOrder")
public class SubmitOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String center = request.getParameter("center");
		int writer = Integer.parseInt(request.getParameter("oWriter"));
		String[] amountTemp = request.getParameterValues("amount");
		int[] oAmount = null;
		
		String cCode = center.equals("경기센터") ? "GG" : "TK";
		String[] pCode = request.getParameterValues("pCode");
		
		for(int i = 0; i < amountTemp.length; i++) {
			oAmount = new int[amountTemp.length];
			int a = Integer.parseInt(amountTemp[i]);
			oAmount[i] = a;			
		}
		
		String sCode = request.getParameter("shop");
		String oTitle = request.getParameter("title");
		String oComment = request.getParameter("comment");
		
		List<Order> orderList = new ArrayList<>();
		
		
		for(int i = 0; i < pCode.length; i++) {
			Order order = new Order(null, cCode, pCode[i], oAmount[i], sCode, null, null, writer, oTitle, oComment);
			orderList.add(order);
		}
		
		int result = new OrderService().insertOrder(orderList);
		
		HttpSession session = request.getSession();
		
		PrintWriter out = response.getWriter();
		out.print("<script>");
		
		String loc = request.getContextPath() + "/order/ordr";
		out.print("window.opener.location.replace('" + loc + "?currentPage=1');");
		if(result > 0)
		{
			session.setAttribute("msg", "등록 완료");
		}
		else
		{
			session.setAttribute("msg", "등록 실패");
		}
		out.print("window.close();");
		out.print("</script>");
	}

}
