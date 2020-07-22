package sales.model.vo;

import java.io.Serializable;

public class RankedTransfer implements Serializable{
	private int rnum;
	private int t_amount;
	private String p_code;
	private String p_name;
	public RankedTransfer() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RankedTransfer(int rnum, int t_amount, String p_code, String p_name) {
		super();
		this.rnum = rnum;
		this.t_amount = t_amount;
		this.p_code = p_code;
		this.p_name = p_name;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getT_amount() {
		return t_amount;
	}
	public void setT_amount(int t_amount) {
		this.t_amount = t_amount;
	}
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	@Override
	public String toString() {
		return "RankedTransfer [t_amount=" + t_amount + ", p_code=" + p_code + ", p_name=" +p_name+", rnum" +rnum+"]";
	}
	
	
}
