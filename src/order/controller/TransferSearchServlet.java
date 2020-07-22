package order.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.tribes.util.Arrays;

import common.utill.Utils;
import order.model.service.TransferService;
import order.model.vo.Transfer;

/**
 * Servlet implementation class TransferSearchServlet
 */

@WebServlet("/order/transferSearch")
public class TransferSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TransferSearchServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String[] searchArr = request.getParameterValues("search");
	
//	System.out.println(Arrays.toString(searchArr));
	
	int numPerPage = 5;
	int cPage = 1;
	
	try {
		cPage = Integer.parseInt(request.getParameter("cPage"));
	}catch(NumberFormatException e) {
	}

	//contents
	List<Transfer> transferList = new TransferService().searchTransfer
								(searchArr, cPage, numPerPage);
//	System.out.println("transferList@servlet = " + transferList.toString());
	
	//pageBar
	int totalContents = new TransferService().selectTotalContents(searchArr);
	String searchArrStr = "?"; //URL Query string 의 시작 '?'
//	System.out.println("totalContents = " + totalContents);
	
	for(int i = 0; i < 6; i++) { //search 갯수 6개
		searchArrStr += "&search=" + searchArr[i]; //?->&
	}
		
	
	String url = request.getRequestURI()
				+ searchArrStr
				+ "&";
//	System.out.println("totalContents@servlet = " + totalContents);
//	System.out.println("url = " + url);
	String pageBar = Utils.getPageBarHTML(cPage, numPerPage, totalContents, url);
	//System.out.println("pageBar["+pageBar+"]");
	request.setAttribute("transferList", transferList);
	request.setAttribute("pageBar", pageBar);
	
	request.getRequestDispatcher("/WEB-INF/views/order/transfer.jsp")
			.forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
