package product.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.ProjectConfig;

@WebServlet("/ProductFileServlet")
public class ProductFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductFileServlet() {
		super();
	}

	private static final int DEFAULT_BUFFER_SIZE = 1024 * 10; // 10KB.


	private String filePath;
	
	public void init() throws ServletException {
		//상품이미지경로
		this.filePath = ProjectConfig.PRODUCT_UPLOAD_LOCATION;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//요청경로 가져오기
		String requestedFile = request.getPathInfo();

		if (requestedFile == null) {
			//파일요청 경로가 유효하지 않음 404 not found
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}

		//파일명 
		File file = new File(filePath, URLDecoder.decode(requestedFile, "UTF-8"));

		//파일 존재하지 않을때
		if (!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
			return;
		}

		//파일 내용 가져오기
		String contentType = getServletContext().getMimeType(file.getName());

		//파일 타입이 이상하면 기본값으로
		//content types: http://www.w3schools.com/media/media_mimeref.asp
		//새로운 밈매핑을 등록하려면 mime-mapping 추가해야함 (web.xml)
		if (contentType == null) {
			contentType = "application/octet-stream";
		}

		//서블릿 요청 초기화
		response.reset();
		response.setBufferSize(DEFAULT_BUFFER_SIZE);
		response.setContentType(contentType);
		response.setHeader("Content-Length", String.valueOf(file.length()));
		response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

		//전송준비
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		try {
			//전송
			bis = new BufferedInputStream(new FileInputStream(file), DEFAULT_BUFFER_SIZE);
			bos = new BufferedOutputStream(response.getOutputStream(), DEFAULT_BUFFER_SIZE);

			//response 에 읽어온 파일 뿌리기
			byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
			int length;
			while ((length = bis.read(buffer)) > 0) {
				bos.write(buffer, 0, length);
			}
		} finally {
			close(bis);
			close(bos);
		}
	}

	/**
	 * 닫기
	 */
	private static void close(Closeable resource) {
		if (resource != null) {
			try {
				resource.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
