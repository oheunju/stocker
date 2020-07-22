package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;

import common.mail.EmailDto;
import common.mail.Emailer;
import common.utill.Utils;
import member.model.service.EmpService;
import member.model.vo.Employee;

@WebServlet("/member/resetPassword")
public class ResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private EmpService empService = new EmpService();
	
    public ResetPasswordServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//사용자 입력값
		int eCode = Integer.parseInt(request.getParameter("eCode"));	
        String eEmail = request.getParameter("eEmail");
        
        //메일 제목
        String subject = "STOCKer :: 새 비밀번호";
        
        //새로운 비밀번호
        String newPassword = RandomStringUtils.randomAlphabetic(5); //랜덤 5자리문자
        
        //생성된 newPassword를 암호화처리함.
        String encryptedNewPassword = Utils.getEncryptedPassword(newPassword);
        
        //메일내용
        String content = "새로운 비밀번호입니다: "+ newPassword  +"\n";
     	content += "로그인 후 비밀번호를 변경해주세요";
        
        String msg = "";
        String loc = "/";
        
        //해당 사원의 이메일이 맞는지 검사
        Employee emp = empService.selectOne(eCode);
        
		
		//emp객체가 null이 아니고 해당 사원의 email과 일치할 경우
        if(emp != null && eEmail.equals(emp.geteEmail())) {
        	
        	//비밀번호 업데이트
        	int result = empService.updatePassword(eCode, encryptedNewPassword);
        	
        	//바뀐 비밀번호를 해당 메일로 보내기 
        	//이메일객체
        	EmailDto dto = new EmailDto();
        	dto.setMailTo(eEmail);
        	dto.setPassword(newPassword);
        	dto.setTitle(subject);
        	dto.setContent(content);
        	
        	Emailer emailer = new Emailer(eEmail);
        	
        	try {	
        		emailer.sendMail(dto);
        	}catch(Exception e) {
        		System.out.println(e.getMessage());
        		msg = "메일 발송 오류:" + e.getMessage();
        	}finally {
        		msg = "새 비밀번호를 해당 메일로 전송했습니다.";
        		request.setAttribute("script", "self.close();"); //팝업창 닫기 처리 
        	}
        }
        //해당사원의 이메일과 맞지 않을때
        else {
        	msg = "이메일을 잘못 입력하셨습니다.";
        	loc = "/member/passwordFinder";
        }
        
        //응답처리
        request.setAttribute("msg", msg);
        request.setAttribute("loc", loc);
        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
        .forward(request, response);

	}

}
