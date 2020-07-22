package sales.model.vo;

import java.io.Serializable;

public class MostSoldProduct implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int quantity;
	private String p_name;
	
	public MostSoldProduct() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MostSoldProduct(int quantity, String p_name) {
		super();
		this.quantity = quantity;
		this.p_name = p_name;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	@Override
	public String toString() {
		return "MostSoldProduct [quantity=" + quantity + ", p_name=" + p_name + "]";
	}
	
	
}
