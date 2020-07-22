package product.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class BeReleased implements Serializable{
	private String rCode; // 출고코드
	private String oCode; // 발주코드
	private String tCode; // 이송코드
	private String pCode; // 상품코드
	private int rAmount; // 출고수량
	private String rReason; // 출고사유
	private Date rDate; // 출고일
	
	public BeReleased() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BeReleased(String rCode, String oCode, String tCode, String pCode, int rAmount, String rReason, Date rDate) {
		super();
		this.rCode = rCode;
		this.oCode = oCode;
		this.tCode = tCode;
		this.pCode = pCode;
		this.rAmount = rAmount;
		this.rReason = rReason;
		this.rDate = rDate;
	}

	public final String getrCode() {
		return rCode;
	}

	public final void setrCode(String rCode) {
		this.rCode = rCode;
	}

	public final String getoCode() {
		return oCode;
	}

	public final void setoCode(String oCode) {
		this.oCode = oCode;
	}

	public final String gettCode() {
		return tCode;
	}

	public final void settCode(String tCode) {
		this.tCode = tCode;
	}

	public final String getpCode() {
		return pCode;
	}

	public final void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public final int getrAmount() {
		return rAmount;
	}

	public final void setrAmount(int rAmount) {
		this.rAmount = rAmount;
	}

	public final String getrReason() {
		return rReason;
	}

	public final void setrReason(String rReason) {
		this.rReason = rReason;
	}

	public final Date getrDate() {
		return rDate;
	}

	public final void setrDate(Date rDate) {
		this.rDate = rDate;
	}

	@Override
	public String toString() {
		return "BeReleased [rCode=" + rCode + ", oCode=" + oCode + ", tCode=" + tCode + ", pCode=" + pCode
				+ ", rAmount=" + rAmount + ", rReason=" + rReason + ", rDate=" + rDate + "]\n";
	}
	
	

}
