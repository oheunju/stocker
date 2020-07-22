package sales.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.util.HashMap;

import sales.model.dao.RevenueDAO;

public class RevenueService implements Serializable{

	private RevenueDAO revenueDAO = new RevenueDAO();

	public HashMap<Integer, Integer> AnnualRevenue1(int thisYear) {
		Connection conn = getConnection();
		
		HashMap<Integer, Integer> map = revenueDAO.AnnualRevenue1(conn, thisYear);
		
		close(conn);
		
		return map;
	}
	
	public HashMap<Integer, Integer> AnnualRevenue2(int thisYear) {
		Connection conn = getConnection();
		
		HashMap<Integer, Integer> map = revenueDAO.AnnualRevenue2(conn, thisYear);
		
		close(conn);
		
		return map;
	}
	public HashMap<Integer, Integer> MonthlyRevenue1(int thisYear) {
		Connection conn = getConnection();
		
		HashMap<Integer, Integer> map = revenueDAO.MonthlyRevenue1(conn, thisYear);
		
		close(conn);
		
		return map;
	}
	public HashMap<Integer, Integer> MonthlyRevenue2(int thisYear) {
		Connection conn = getConnection();
		
		HashMap<Integer, Integer> map = revenueDAO.MonthlyRevenue2(conn, thisYear);
		
		close(conn);
		
		return map;
	}
	public HashMap<String, Integer> DailyRevenue1() {
		Connection conn = getConnection();
		
		HashMap<String, Integer> map = revenueDAO.DailyRevenue1(conn);
		
		close(conn);
		
		return map;
	}
	public HashMap<String, Integer> DailyRevenue2() {
		Connection conn = getConnection();
		
		HashMap<String, Integer> map = revenueDAO.DailyRevenue2(conn);
		
		close(conn);
		
		return map;
	}
	public Integer TodayRevenue() {
		Connection conn = getConnection();
		
		Integer result = revenueDAO.TodayRevenue(conn);
		
		close(conn);
		return result;
	}



}
