package product.model.vo;

import java.io.Serializable;

public class Stock implements Serializable {
//	selectAllStock=select C_CODE, P_THEME, P_NAME, P_CODE, S_CAPA, S_AMOUNT from stock left join product using(P_CODE) order by P_THEME
	private String cCode;  //센터코드 
	private String pTheme;  //테마 
	private String pCategory;  //테마 
	private String pName;  //상품명 
	private String pCode;  //상품코드
	private int sCapa;     //안전재고량
	private int sAmount;   //재고량

	public Stock() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Stock(String cCode, String pTheme, String pCategory, String pName, String pCode, int sCapa, int sAmount) {
		super();
		this.cCode = cCode;
		this.pTheme = pTheme;
		this.pCategory = pCategory;
		this.pName = pName;
		this.pCode = pCode;
		this.sCapa = sCapa;
		this.sAmount = sAmount;
	}

	public String getcCode() {
		return cCode;
	}

	public void setcCode(String cCode) {
		this.cCode = cCode;
	}

	public String getpTheme() {
		return pTheme;
	}

	public void setpTheme(String pTheme) {
		this.pTheme = pTheme;
	}

	public String getpCategory() {
		return pCategory;
	}

	public void setpCategory(String pCategory) {
		this.pCategory = pCategory;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public int getsCapa() {
		return sCapa;
	}

	public void setsCapa(int sCapa) {
		this.sCapa = sCapa;
	}

	public int getsAmount() {
		return sAmount;
	}

	public void setsAmount(int sAmount) {
		this.sAmount = sAmount;
	}

	@Override
	public String toString() {
		return "Stock [cCode=" + cCode + ", pTheme=" + pTheme + ", pCategory=" + pCategory + ", pName=" + pName
				+ ", pCode=" + pCode + ", sCapa=" + sCapa + ", sAmount=" + sAmount + "]";
	}

	

	

	
}
