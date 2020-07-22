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

/**
 * 		결재관리는 이송, 재고, 발주 담당자만 열람 가능
 * 
 */
@WebFilter("/approval")
public class ApprovalAuthFilter implements Filter {

    /**
     * Default constructor. 
     */
    public ApprovalAuthFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest)request; 
		HttpSession session = httpReq.getSession();
		Employee memberLoggedIn = ((Employee)session.getAttribute("empLoggedIn"));
		
		
//		System.out.println("memberId@MemberAuthFilter="+memberId);
		if((memberLoggedIn==null)
		|| !(memberLoggedIn.geteDept().equals("발주") || memberLoggedIn.geteDept().equals("이송") 
				|| memberLoggedIn.geteDept().equals("경기물류") || memberLoggedIn.geteDept().equals("대구물류") || memberLoggedIn.geteDept().equals("관리자"))
				){
			request.setAttribute("msg", "입고, 출고 담당자는 조회 불가능합니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				.forward(request, response);
			return;
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
