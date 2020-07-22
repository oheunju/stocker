package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.utill.Utils;
import member.model.service.EmpService;
import member.model.vo.Employee;

@WebServlet("/member/login")
public class EmpLoginServlet extends HttpServlet{
	@Override 
	public void doGet(HttpServletRequest request, 
						HttpServletResponse response) throws IOException, ServletException {
		//doGet 메소드를 doPost로 보내기
//		doPost(request, response);
		request.getRequestDispatcher("/WEB-INF/views/member/login.jsp").forward(request, response);		
	}
	
	@Override 
	public void doPost(HttpServletRequest request, 
						HttpServletResponse response)
					throws IOException, ServletException{
		
		//인코딩처리 
		 request.setCharacterEncoding("UTF-8");
		 response.setCharacterEncoding("UTF-8");
		 
		
		int eCode = Integer.parseInt(request.getParameter("eCode"));
		String ePassword = request.getParameter("ePassword");

//		System.out.println("eCode="+eCode);
//		System.out.println("ePassword="+ePassword);
		
		Cookie boardCookie2 = new Cookie("boardCookie", "");
	      boardCookie2.setPath(request.getContextPath());
	      boardCookie2.setMaxAge(0);
	      response.addCookie(boardCookie2);
	      
		if(Utils.isEmpty(eCode)) {
			
			request.getRequestDispatcher("/WEB-INF/views/member/login.jsp").forward(request, response);			
		}else {
		
		
			ePassword = Utils.getEncryptedPassword(ePassword); //비밀번호 암호화 처리 
			String saveId = request.getParameter("saveId");
//			System.out.println("eCode@servlet=" + eCode);
//			System.out.println("ePassword@servlet=" + ePassword);
//			System.out.println("saveId@servlet=" + saveId);
			
			
			//eCode로 회원정보 조회
			Employee emp = new EmpService().selectOne(eCode);
			
	//		System.out.println(m);
			
			 
			String view = "";
			//4. 응답처리 
			//아이디, 비번이 모두 일치하는 경우
			if(emp != null
					&& eCode == emp.geteCode()
					&& ePassword.equals(emp.getePassword())) {
				
				HttpSession session = request.getSession(true);	
				//System.out.println("sessionId="+session.getId());
				session.setMaxInactiveInterval(30*60);
				
				session.setAttribute("empLoggedIn", emp);
				
				String eCodeCookie = String.valueOf(eCode);
				Cookie c = new Cookie ("saveId", eCodeCookie);
				c.setPath(request.getContextPath()); //쿠키유효디렉토리 설정
				
				if(saveId != null) {
					c.setMaxAge(7*24*60*60); //7일 
				}
				else {
					c.setMaxAge(0); //쿠키는 따로 삭제 메소드가 없으므로 0으로 두면 브라우져에서 즉시삭제됨
					
				}
				response.addCookie(c);
				
				//String referer = request.getHeader("referer");
				//response.sendRedirect(referer);
				view = "/index.jsp";
				request.setAttribute("emp", emp);
			} else {
				view = "/WEB-INF/views/common/msg.jsp"; 
				String msg = "사번 또는 비밀번호가 일치하지 않습니다.";
				String loc = "/";
				request.setAttribute("msg", msg);
				request.setAttribute("loc", loc);
			}
			request.getRequestDispatcher(view).include(request, response);
		}
	}
}
