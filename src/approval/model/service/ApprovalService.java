package approval.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import approval.model.dao.ApprovalDAO;
import order.model.vo.Order;
import order.model.vo.PageInfo;
import order.model.vo.Transfer;

public class ApprovalService {
	
	private ApprovalDAO approvalDAO = new ApprovalDAO();


	public List<Order> selectWaitingOrder(PageInfo pi) {
		Connection conn = getConnection();
		List<Order> orderList = approvalDAO.selectWaitingOrder(conn, pi);
		close(conn);
		return orderList;
	}

	public int getListCount() {
		Connection conn = getConnection();
		int listCount = approvalDAO.getListCount(conn);
		close(conn);
		return listCount;
	}

	public int getCompleteistCount() {
		Connection conn = getConnection();
		int listCount = approvalDAO.getCompleteListCount(conn);
		close(conn);
		return listCount;
	}

	public List<Order> selectCompleteOrder(PageInfo pi) {
		Connection conn = getConnection();
		List<Order> orderList = approvalDAO.selectCompleteOrder(conn, pi);
		close(conn);
		return orderList;
	}

	public List<Order> selectWaitingStockOrder(PageInfo pi) {
		Connection conn = getConnection();
		List<Order> orderList = approvalDAO.selectWaitingStockOrder(conn, pi);
		close(conn);
		return orderList;
	}

	public List<Transfer> selectWaitingStockTransfer(PageInfo pi) {
		Connection conn = getConnection();
		List<Transfer> tList = approvalDAO.selectWaitingStockTansfer(conn, pi);
//		System.out.println("tList@service=" + tList);
		close(conn);
		return tList;
	}

	public List<Transfer> selectCompleteTransfer(PageInfo pi) {
		Connection conn = getConnection();
		List<Transfer> tList = approvalDAO.selectCompleteTransfer(conn, pi);
//		System.out.println("tList@service=" + tList);
		close(conn);
		return tList;
	}
}
