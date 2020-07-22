package order.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.Arrays;

public class Order implements Serializable{
	private String oCode;		// 발주코드
	private String cCode;		// 출고센터
	private String pCode;		// 상품코드
	private int oAmount;		// 발주량
	private String sCode;		// 주문매장
	private Date oDate;			// 주문일
	private String oStatus;		// 주문상태
	private int writer;			// 주문서 작성자
	private String oTitle;		// 발주서 제목
	private String oComment;	// 발주서 내용
	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Order(String oCode, String cCode, String pCode, int oAmount, String sCode, Date oDate, String oStatus,
			int writer, String oTitle, String oComment) {
		super();
		this.oCode = oCode;
		this.cCode = cCode;
		this.pCode = pCode;
		this.oAmount = oAmount;
		this.sCode = sCode;
		this.oDate = oDate;
		this.oStatus = oStatus;
		this.writer = writer;
		this.oTitle = oTitle;
		this.oComment = oComment;
	}
	public String getoCode() {
		return oCode;
	}
	public void setoCode(String oCode) {
		this.oCode = oCode;
	}
	public String getcCode() {
		return cCode;
	}
	public void setcCode(String cCode) {
		this.cCode = cCode;
	}
	public String getpCode() {
		return pCode;
	}
	public void setpCode(String pCode) {
		this.pCode = pCode;
	}
	public int getoAmount() {
		return oAmount;
	}
	public void setoAmount(int oAmount) {
		this.oAmount = oAmount;
	}
	public String getsCode() {
		return sCode;
	}
	public void setsCode(String sCode) {
		this.sCode = sCode;
	}
	public Date getoDate() {
		return oDate;
	}
	public void setoDate(Date oDate) {
		this.oDate = oDate;
	}
	public String getoStatus() {
		return oStatus;
	}
	public void setoStatus(String oStatus) {
		this.oStatus = oStatus;
	}
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	public String getoTitle() {
		return oTitle;
	}
	public void setoTitle(String oTitle) {
		this.oTitle = oTitle;
	}
	public String getoComment() {
		return oComment;
	}
	public void setoComment(String oComment) {
		this.oComment = oComment;
	}
	@Override
	public String toString() {
		return "Order [oCode=" + oCode + ", cCode=" + cCode + ", pCode=" + pCode + ", oAmount=" + oAmount + ", sCode="
				+ sCode + ", oDate=" + oDate + ", oStatus=" + oStatus + ", writer=" + writer + ", oTitle=" + oTitle
				+ ", oComment=" + oComment + "]";
	}
	
	
	
	

}
