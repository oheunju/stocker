package common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import member.model.vo.Employee;

@WebFilter(urlPatterns = {
		"/order/*",
		"/product/*",
		"/stocker/*",
		"/approval/*",
		"/sales/*",
		"/member/updatePassword",
		"/member/infoView"
		
})
public class LoginFilter implements Filter {

    public LoginFilter() {
    }

	public void destroy() {
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpSession session = httpReq.getSession();
		Employee empLoggedIn = (Employee) session.getAttribute("empLoggedIn");
		
		if(empLoggedIn == null) {
			request.setAttribute("msg", "로그인 후 이용하실 수 있습니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
			.forward(request, response);
			
			return; //이하 코드가 처리되지 않도록 함.
		}
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
