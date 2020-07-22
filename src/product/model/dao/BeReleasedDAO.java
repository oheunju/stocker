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

import order.model.dao.OrderDAO;
import order.model.vo.Order;
import order.model.vo.Transfer;
import product.model.vo.BeReleased;

public class BeReleasedDAO {
private Properties prop = new Properties();
	
	public BeReleasedDAO() {
		try {
			String fileName 
				= BeReleasedDAO.class
						  .getResource("/sql/product/product-query.properties")
						  .getPath();
			prop.load(new FileReader(fileName));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}

	public List<BeReleased> selectAll(Connection conn, int cPage, int numPerPage) {
		List<BeReleased> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectAllReleased");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				BeReleased br = new BeReleased(rset.getString("r_code"), 
									rset.getString("o_code"), 
									rset.getString("t_code"), 
									rset.getString("p_code"),
									rset.getInt("r_amount"), 
									rset.getString("r_reason"),
									rset.getDate("r_date"));
				
//				System.out.println("bereleased@dao = " + br);
				
				list.add(br);
			}
			
			
			
//			System.out.println("list@dao = " + list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return list;
	}

	public int selectBereleasedCount(Connection conn) {
		PreparedStatement pstmt = null;
		int totalContents = 0;
		ResultSet rset = null;
		String sql = prop.getProperty("selectBereleasedCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				totalContents = rset.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
//			System.out.println("totalContents@dao=" + totalContents);
		return totalContents;
	}

	public List<BeReleased> searchBeReleased(Connection conn, String[] searchArr, int cPage, int numPerPage) {
		List<BeReleased> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchBereleasedPaging");
		
		try {
			pstmt = conn.prepareStatement(sql);
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			cal.setTime(new Date());
			cal.add(Calendar.DATE, +1);
			String today = sdf.format(cal.getTime());
			
			for(int i = 0; i <= 3; i++) {
				pstmt.setString(i+1, "%" + ((searchArr[i]).toUpperCase()).trim() + "%");
			}
					
			pstmt.setString(5, searchArr[4].equals("") ? "2010-01-01" : searchArr[4]);
			pstmt.setString(6, searchArr[5].equals("") ? today : searchArr[5]);
			pstmt.setInt(7, (cPage - 1) * numPerPage + 1);
			pstmt.setInt(8, cPage * numPerPage);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				BeReleased br = new BeReleased(rset.getString("r_code"), 
						rset.getString("o_code"), 
						rset.getString("t_code"), 
						rset.getString("p_code"),
						rset.getInt("r_amount"), 
						rset.getString("r_reason"),
						rset.getDate("r_date"));
	
			//	System.out.println("bereleased@dao = " + br);
				
				list.add(br);
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int selectTotal(Connection conn, String[] searchArr) {
		int totalContents = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bereleasedFinderTotalContents");
		
		try {
			pstmt = conn.prepareStatement(sql);
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			cal.setTime(new Date());
			cal.add(Calendar.DATE, +1);
			String today = sdf.format(cal.getTime());
			
			for(int i = 0; i <= 3; i++)
				pstmt.setNString(i+1, "%" + searchArr[i] + "%");
			
			pstmt.setString(5, searchArr[4].equals("") ? "2010-01-01" : searchArr[4]);
			pstmt.setString(6, searchArr[5].equals("") ? today : searchArr[5]);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				totalContents = rset.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContents;
	}

}
