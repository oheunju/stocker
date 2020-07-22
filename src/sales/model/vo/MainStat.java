package sales.model.vo;

import java.io.Serializable;
import java.text.DecimalFormat;

public class MainStat implements Serializable{
	private transient DecimalFormat formatter = new DecimalFormat("###,###,###,###");
	
	private String thisYear;
	private String thisMonth;
	private int mInbound;
	private int mOutbound;
	private int drevenue;
	public MainStat() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MainStat(String thisYear, String thisMonth, int mInbound, int mOutbound, int drevenue) {
		super();
		this.thisYear = thisYear;
		this.thisMonth = thisMonth;
		this.mInbound = mInbound;
		this.mOutbound = mOutbound;
		this.drevenue = drevenue;
	}
	public String getThisYear() {
		return thisYear;
	}
	public void setThisYear(String thisYear) {
		this.thisYear = thisYear;
	}
	public String getThisMonth() {
		return thisMonth;
	}
	public void setThisMonth(String thisMonth) {
		this.thisMonth = thisMonth;
	}
	public String getmInbound() {
		return formatter.format((int)mInbound);
	}
	public void setmInbound(int mInbound) {
		this.mInbound = mInbound;
	}
	public String getmOutbound() {
		return formatter.format(mOutbound);
	}
	public void setmOutbound(int mOutbound) {
		this.mOutbound = mOutbound;
	}
	public String getDrevenue() {
		return formatter.format(drevenue);
	}
	public void setDrevenue(int drevenue) {
		this.drevenue = drevenue;
	}
	@Override
	public String toString() {
		return "MainStat [thisYear=" + thisYear + ", thisMonth=" + thisMonth + ", mInbound=" + mInbound + ", mOutbound="
				+ mOutbound + ", drevenue=" + drevenue + "]";
	}
	

}
