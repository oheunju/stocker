package product.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import order.model.vo.Order;
import order.model.vo.PageInfo;
import product.model.vo.BeReleased;
import product.model.vo.Warehousing;

public class WDAO {
private Properties prop = new Properties();
	
	public WDAO() {
		try {
			String fileName 
				= WDAO.class
						  .getResource("/sql/product/product-query.properties")
						  .getPath();
			prop.load(new FileReader(fileName));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}

	public List<Warehousing> selectAll(Connection conn, PageInfo pi) {
		List<Warehousing> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectAllWarehousing");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getlistLimit() + 1;
			int endRow = startRow + pi.getlistLimit() - 1;
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Warehousing w = new Warehousing(rset.getString("w_code"), 
									rset.getString("p_code"), 
									rset.getInt("w_amount"), 
									rset.getString("w_reason"),
									rset.getDate("w_date"), 
									rset.getString("c_code"));
				
				
				list.add(w);
				
//				System.out.println("w@dao = " + w);
				
			}
						
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
//		System.out.println("wList@dato = " + list);
		
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

	public int getSearchListCount(Connection conn, String[] search) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getSearchListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			cal.setTime(new Date());
	        cal.add(Calendar.DATE, +1);
			String today = sdf.format(cal.getTime());
			
			
			pstmt.setString(1, "%" + search[0] + "%");
			pstmt.setString(2, "%" + search[1] + "%");
			pstmt.setString(3, search[2].equals("") ? "2010-01-01" : search[2]);
			pstmt.setString(4, search[3].equals("") ? today : search[3]);
			
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

	public List<Warehousing> searchWarehousing(Connection conn, PageInfo pi, String[] search) {
		List<Warehousing> wList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchWarehousing");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			cal.setTime(new Date());
	        cal.add(Calendar.DATE, +1);
			String today = sdf.format(cal.getTime());
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getlistLimit() + 1;
			int endRow = startRow + pi.getlistLimit() - 1;
			
			pstmt.setString(1, "%" + search[0] + "%");
			pstmt.setString(2, "%" + search[1] + "%");
			pstmt.setString(3, search[2].equals("") ? "2010-01-01" : search[2]);
			pstmt.setString(4, search[3].equals("") ? today : search[3]);
			pstmt.setInt(5, startRow);
			pstmt.setInt(6, endRow);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Warehousing w = new Warehousing(rset.getString("w_code"), 
												rset.getString("p_code"), 
												rset.getInt("w_amount"), 
												rset.getString("w_reason"),
												rset.getDate("w_date"), 
												rset.getString("c_code"));
	
	
				wList.add(w);
//				System.out.println(w);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println(wList);
		return wList;
	}

}
