package order.controller;


import java.io.File;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import order.model.service.OrderService;
import order.model.vo.Order;


/**
 * Servlet implementation class OrderUploadServlet
 */
@WebServlet("/order/upload")
public class OrderUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Order> list = new ArrayList<>();
		int ecode = Integer.parseInt(request.getParameter("ecode"));
		
		String saveDirectory = getServletContext().getRealPath("/upload/order/");
		int maxPostSize = 1024 *  1024 * 10;
		String encoding = "utf-8";
		MultipartRequest multipartRequest
			= new MultipartRequest(request, saveDirectory, maxPostSize, encoding, new DefaultFileRenamePolicy());
		
		File file = new File(saveDirectory + multipartRequest.getFilesystemName("filename"));
		
		FileInputStream fis = new FileInputStream(file);
		XSSFWorkbook workbook = new XSSFWorkbook(fis);
		
		int rowIndex = 0;
		int colIndex = 0;
		
		XSSFSheet sheet = workbook.getSheetAt(0);
		
		/* int rows = sheet.getPhysicalNumberOfRows(); */
		int rows = 21;
	
		for(rowIndex = 17; rowIndex < rows; rowIndex++) 
		{
			Order o = new Order();
			
			XSSFRow row = sheet.getRow(rowIndex);
			
			String scode = String.valueOf(row.getCell(1));
//			System.out.println("scode = " + scode);
			String ccode = "";
			if(Integer.parseInt(scode.substring(2, 4)) < 11)
				ccode = "GG";
			else
				ccode = "TK";
				
			o.setsCode(scode);
			o.setcCode(ccode);
			o.setpCode(String.valueOf(row.getCell(3)));
			int dotIndex = String.valueOf(row.getCell(5)).lastIndexOf(".");
			o.setoAmount(Integer.parseInt(String.valueOf(row.getCell(5)).substring(0, dotIndex)));
			o.setoTitle("발주요청");
			o.setWriter(ecode);
			
			list.add(o);
		}
		
		workbook.close();
		
		int result = new OrderService().insertOrder(list);

		file.delete();
		
		String msg = result > 0 ? "주문 완료" : "주문 실패! 다시 시도해주세요.";
		String loc = "/order/ordr?currentPage=1";
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
