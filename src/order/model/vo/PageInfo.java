package order.model.vo;

import java.io.Serializable;

public class PageInfo implements Serializable{

	private int totalList;
	private int currentPage;
	private int startPage;
	private int endPage;
	private int maxPage;
	private int pageLimit;
	private int listLimit;
	
	public PageInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PageInfo(int totalList, int currentPage, int startPage, int endPage, int maxPage, int pageLimit,
			int listLimit) {
		super();
		this.totalList = totalList;
		this.currentPage = currentPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.maxPage = maxPage;
		this.pageLimit = pageLimit;
		this.listLimit = listLimit;
	}

	public int gettotalList() {
		return totalList;
	}

	public void settotalList(int totalList) {
		this.totalList = totalList;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getPageLimit() {
		return pageLimit;
	}

	public void setPageLimit(int pageLimit) {
		this.pageLimit = pageLimit;
	}

	public int getlistLimit() {
		return listLimit;
	}

	public void setlistLimit(int listLimit) {
		this.listLimit = listLimit;
	}

	@Override
	public String toString() {
		return "PageInfo [totalList=" + totalList + ", currentPage=" + currentPage + ", startPage=" + startPage
				+ ", endPage=" + endPage + ", maxPage=" + maxPage + ", pageLimit=" + pageLimit + ", listLimit="
				+ listLimit + "]";
	}
	
	
}
