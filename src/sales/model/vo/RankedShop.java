package sales.model.vo;

import java.io.Serializable;

public class RankedShop implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int rank;
	private String s_code;
	private String s_name;
	private int totalsum;
	private String s_tel;
	public RankedShop() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RankedShop(int rank, String s_code, String s_name, int totalsum, String s_tel) {
		super();
		this.rank = rank;
		this.s_code = s_code;
		this.s_name = s_name;
		this.totalsum = totalsum;
		this.s_tel = s_tel;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public String getS_code() {
		return s_code;
	}
	public void setS_code(String s_code) {
		this.s_code = s_code;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public int getTotalsum() {
		return totalsum;
	}
	public void setTotalsum(int totalsum) {
		this.totalsum = totalsum;
	}
	public String getS_tel() {
		return s_tel;
	}
	public void setS_tel(String s_tel) {
		this.s_tel = s_tel;
	}
	@Override
	public String toString() {
		return "RankedShop [rank=" + rank + ", s_code=" + s_code + ", s_name=" + s_name + ", totalsum=" + totalsum
				+ ", s_tel=" + s_tel + "]";
	}
	
	
}
