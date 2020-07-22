package product.model.vo;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;

public class Product implements Serializable{
	
	private String pCode; //상품코드
	private String pTheme; //테마
	private String pCategory; //카테고리
	private String pName; //상품명
	private String pColor; //컬러
	private String pPrice; //가격
	private String pImage; //상품이미지
	private String pQrImage; //qrCode
	
	public Product() {
		super();
	}
	
	/**
	 * 상품  selectOne
	 */
	public Product(String pCode, String pTheme, String pCategory, String pName, String pColor, String pPrice) {
		super();
		this.pCode = pCode;
		this.pTheme = pTheme;
		this.pCategory = pCategory;
		this.pName = pName;
		this.pColor = pColor;
		this.pPrice = pPrice;
	}
	
	public String getpCode() {
		return pCode;
	}
	public void setpCode(String pCode) {
		this.pCode = pCode;
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
	public String getpColor() {
		return pColor;
	}
	public void setpColor(String pColor) {
		this.pColor = pColor;
	}
	public String getpPrice() {
		return pPrice;
	}
	public void setpPrice(String pPrice) {
		this.pPrice = pPrice;
	}
	
	public String getpImage() {
		return pImage;
	}

	public void setpImage(String pImage) {
		this.pImage = pImage;
	}
	
	public String getpQrImage() {
		return pQrImage;
	}

	public void setpQrImage(String pQrImage) {
		this.pQrImage = pQrImage;
	}

	@Override
	public String toString() {
		return "Product [pCode=" + pCode + ", pTheme=" + pTheme + ", pCategory=" + pCategory + ", pName=" + pName
				+ ", pColor=" + pColor + ", pPrice=" + pPrice + ", pImage=" + pImage +", pQrImage=" + pQrImage +"]";
	}
}
