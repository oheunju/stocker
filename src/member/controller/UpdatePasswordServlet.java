package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.utill.Utils;
import member.model.service.EmpService;
import member.model.vo.Employee;

/**
 * Servlet implementation class UpdatePassword
 */
@WebServlet("/member/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private EmpService empService = new EmpService();
       
    public UpdatePasswordServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/updatePassword.jsp")
		.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		//2. 사용자 입력값 처리
		int eCode = Integer.parseInt(request.getParameter("eCode"));
		String password = Utils.getEncryptedPassword(request.getParameter("password")); //옛날비밀번호
		String encryptedNewPassword = Utils.getEncryptedPassword(request.getParameter("newPassword")); //새비밀번호 
		
//		System.out.println("eCode=" + eCode);
//		System.out.println("password=" + password);
//		System.out.println("newpassword=" + encryptedNewPassword);
		
		//3. 업무로직
		//기존 비밀번호 검사
		Employee emp = empService.selectOne(eCode);
		String msg = "";
		String loc = "/";
		
		if(emp != null && password.equals(emp.getePassword())) {
			//새비밀번호로 변경
			int result = empService.updatePassword(eCode, encryptedNewPassword);
			
			//비밀번호 변경 성공하면 로그아웃처리함
			if(result > 0) {
				msg = "비밀번호 변경 성공!";
				loc = "/member/logout";
			} else {
				msg = "비밀번호 변경 실패!";
			}
			
		}
		else {
			//비밀번호 재입력 
			msg = "비밀번호를 잘못 입력하셨습니다.";
			loc = "/member/updatePassword?eCode="+eCode;
		}
		
		//4. 응답처리 
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				.forward(request, response);
	}

}
