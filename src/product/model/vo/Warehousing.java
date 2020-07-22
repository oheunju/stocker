package product.model.vo;

import java.sql.Date;

public class Warehousing {
	private String wCode; // 입고코드
	private String pCode; // 상품코드
	private int wAmount; // 입고량
	private String wReason; // 입고사유
	private Date wDate; // 입고일
	private String cCode; // 센터코드
	public Warehousing() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Warehousing(String wCode, String pCode, int wAmount, String wReason, Date wDate, String cCode) {
		super();
		this.wCode = wCode;
		this.pCode = pCode;
		this.wAmount = wAmount;
		this.wReason = wReason;
		this.wDate = wDate;
		this.cCode = cCode;
	}
	public final String getwCode() {
		return wCode;
	}
	public final void setwCode(String wCode) {
		this.wCode = wCode;
	}
	public final String getpCode() {
		return pCode;
	}
	public final void setpCode(String pCode) {
		this.pCode = pCode;
	}
	public final int getwAmount() {
		return wAmount;
	}
	public final void setwAmount(int wAmount) {
		this.wAmount = wAmount;
	}
	public final String getwReason() {
		return wReason;
	}
	public final void setwReason(String wReason) {
		this.wReason = wReason;
	}
	public final Date getwDate() {
		return wDate;
	}
	public final void setwDate(Date wDate) {
		this.wDate = wDate;
	}
	public final String getcCode() {
		return cCode;
	}
	public final void setcCode(String cCode) {
		this.cCode = cCode;
	}
	@Override
	public String toString() {
		return "Warehousing [wCode=" + wCode + ", pCode=" + pCode + ", wAmount=" + wAmount + ", wReason=" + wReason
				+ ", wDate=" + wDate + ", cCode=" + cCode + "]";
	}
	
	
	
}
