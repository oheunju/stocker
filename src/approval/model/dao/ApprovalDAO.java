package approval.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static common.JDBCTemplate.*;

import order.model.vo.Order;
import order.model.vo.PageInfo;
import order.model.vo.Transfer;

public class ApprovalDAO {
	private Properties prop = new Properties();
	
	public ApprovalDAO() {
		try {
			String fileName = ApprovalDAO.class
					.getResource("/sql/approval/approval-query.properties")
					.getPath();
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	public List<Order> selectWaitingOrder(Connection conn, PageInfo pi) {
		List<Order> list = new ArrayList<Order>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectWaitingOrder");
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getlistLimit() + 1;
			int endRow = startRow + pi.getlistLimit() - 1;
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Order o = new Order(rset.getString("o_code"), 
									rset.getString("c_code"), 
									rset.getString("p_code"), 
									rset.getInt("o_amount"),
									rset.getString("s_code"), 
									rset.getDate("o_date"),
									rset.getString("o_status"),
									rset.getInt("o_writer"),
									rset.getString("o_title"),
									rset.getString("o_comment"));
				
//				System.out.println("order@dao = " + o);
				
				list.add(o);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int getListCount(Connection conn) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			if(rset.next())
				listCount = rset.getInt(1);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}

	public int getCompleteListCount(Connection conn) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getCompleteListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			if(rset.next())
				listCount = rset.getInt(1);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}

	public List<Order> selectCompleteOrder(Connection conn, PageInfo pi) {
		List<Order> list = new ArrayList<Order>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCompleteOrder");
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getlistLimit() + 1;
			int endRow = startRow + pi.getlistLimit() - 1;
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Order o = new Order(rset.getString("o_code"), 
									rset.getString("c_code"), 
									rset.getString("p_code"), 
									rset.getInt("o_amount"),
									rset.getString("s_code"), 
									rset.getDate("o_date"),
									rset.getString("o_status"),
									rset.getInt("o_writer"),
									rset.getString("o_title"),
									rset.getString("o_comment"));
				
//				System.out.println("order@dao = " + o);
				
				list.add(o);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}


	public List<Order> selectWaitingStockOrder(Connection conn, PageInfo pi) {
		List<Order> list = new ArrayList<Order>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectWaitingOrder");
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getlistLimit() + 1;
			int endRow = startRow + pi.getlistLimit() - 1;
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Order o = new Order(rset.getString("o_code"), 
									rset.getString("c_code"), 
									rset.getString("p_code"), 
									rset.getInt("o_amount"),
									rset.getString("s_code"), 
									rset.getDate("o_date"),
									rset.getString("o_status"),
									rset.getInt("o_writer"),
									rset.getString("o_title"),
									rset.getString("o_comment"));
				
//				System.out.println("order@dao = " + o);
				
				list.add(o);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}


	public List<Transfer> selectWaitingStockTansfer(Connection conn, PageInfo pi) {
		List<Transfer> tlist = new ArrayList<Transfer>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectWaitingStockTransfer");
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getlistLimit() + 1;
			int endRow = startRow + pi.getlistLimit() - 1;
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();
			
			while(rset.next()) {

				Transfer s = new Transfer(rset.getString("t_code"), 
									rset.getDate("t_date"), 
									rset.getInt("t_amount"), 
									rset.getString("t_status"),
									rset.getString("departure_code"), 
									rset.getString("destination_code"),
									rset.getString("p_code"),
									rset.getString("t_title"),
									rset.getString("t_writer"));
				
//				System.out.println("stockorder@dao = " + s);
				tlist.add(s);
				
//				private String tCode; //이송코드
//				private Date tDate; //이송일
//				private int tAmount; //이송량
//				private String tStatus; // 이송여부
//				private String departureCode; //출발지코드
//				private String destinationCode; //도착지코드
//				private String pCode; //상품코드
//				private String tTitle; //이송요청품의서 제목
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return tlist;
	}

	public List<Transfer> selectCompleteTransfer(Connection conn, PageInfo pi) {
		List<Transfer> tList = new ArrayList<Transfer>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCompleteTransfer");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getlistLimit() + 1;
			int endRow = startRow + pi.getlistLimit() - 1;
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Transfer t = new Transfer(rset.getString("t_code"), 
						rset.getDate("t_date"), 
						rset.getInt("t_amount"), 
						rset.getString("t_status"),
						rset.getString("departure_code"), 
						rset.getString("destination_code"),
						rset.getString("p_code"),
						rset.getString("t_title"),
						rset.getString("t_writer"));
				
//				System.out.println("transfer@dao = " + t);
				
				tList.add(t);
				
//				System.out.println("tList@dao=" + tList);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return tList;
	}


}
