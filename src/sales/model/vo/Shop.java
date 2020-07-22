package sales.model.vo;

import java.io.Serializable;

public class Shop implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String sCode; //매장코드
	private String sName; //매장명
	private String sLocation; //지역
	private String sTel; //전화번호
	
	public Shop() {
		super();
	}

	public Shop(String sCode, String sName, String sLocation, String sTel) {
		super();
		this.sCode = sCode;
		this.sName = sName;
		this.sLocation = sLocation;
		this.sTel = sTel;
	}

	public String getsCode() {
		return sCode;
	}

	public void setsCode(String sCode) {
		this.sCode = sCode;
	}

	public String getsName() {
		return sName;
	}

	public void setsName(String sName) {
		this.sName = sName;
	}

	public String getsLocation() {
		return sLocation;
	}

	public void setsLocation(String sLocation) {
		this.sLocation = sLocation;
	}

	public String getsTel() {
		return sTel;
	}

	public void setsTel(String sTel) {
		this.sTel = sTel;
	}

	@Override
	public String toString() {
		return "Shop [sCode=" + sCode + ", sName=" + sName + ", sLocation=" + sLocation + ", sTel=" + sTel + "]";
	}
}
