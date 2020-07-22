package order.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;

import order.model.vo.Transfer;
import product.model.vo.Product;

public class TransferDAO {
	private Properties prop = new Properties();
	
	public TransferDAO() {
		try {
			String fileName = TransferDAO.class
					.getResource("/sql/order/order-query.properties")
					.getPath();
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

public List<Transfer> selectTransferList(Connection conn, int cPage, int numPerPage) {
	List<Transfer> transferlist = new ArrayList<>();
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	String sql = prop.getProperty("selectTransferList");
	
	try {
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, (cPage-1)*numPerPage+1);
		pstmt.setInt(2, cPage*numPerPage);
		
		rset = pstmt.executeQuery();
		
		while(rset.next()) {
			Transfer t = new Transfer();
			t.settCode(rset.getString("T_CODE"));
			t.setpCode(rset.getString("P_CODE"));
			t.settAmount(rset.getInt("T_AMOUNT"));
			t.settDate(rset.getDate("T_DATE"));
			t.setDepartureCode(rset.getString("DEPARTURE_CODE"));
			t.setDestinationCode(rset.getString("DESTINATION_CODE"));
			t.settStatus(rset.getString("T_STATUS"));
			t.settTitle(rset.getString("T_TITLE"));
			t.settWriter(rset.getString("T_WRITER"));
			
			//리스트에 추가
			transferlist.add(t);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		close(rset);
		close(pstmt);
	}
	
//		System.out.println("list@dao="+list);
	
	return transferlist;
}

public int selectTransferCount(Connection conn) {
	PreparedStatement pstmt = null;
	int totalContents = 0;
	ResultSet rset = null;
	String sql = prop.getProperty("selectTransferCount");
	
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
//		System.out.println("totalContents@dao=" + totalContents);
	return totalContents;
}


public Product selectOne(Connection conn, String pCode) {
	Product product = null;
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	String sql = prop.getProperty("selectOne");
	
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pCode);
		
		rset = pstmt.executeQuery();
		
		while(rset.next()) {
			product = new Product();
			
			product.setpCode(rset.getString("P_CODE"));
			product.setpName(rset.getString("P_NAME"));
			product.setpColor(rset.getString("P_COLOR"));
			product.setpPrice(rset.getString("P_PRICE"));
			product.setpTheme(rset.getString("P_THEME"));
			product.setpCategory(rset.getString("P_CATEGORY"));
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(rset);
		close(pstmt);
	}
			
//	System.out.println("product@dao=" + product);
	return product;
}

public List<Transfer> searchTransfer(Connection conn, String[] searchArr, int cPage, int numPerPage) {
	List<Transfer> tList = new ArrayList<>();
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	String sql = prop.getProperty("searchTransferPaging");
	
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
			Transfer t = new Transfer();
			t.settCode(rset.getString("T_CODE"));
			t.setpCode(rset.getString("P_CODE"));
			t.settTitle(rset.getString("T_TITLE"));
			t.settStatus(rset.getString("T_STATUS"));
			t.setDepartureCode(rset.getString("DEPARTURE_CODE"));
			t.setDestinationCode(rset.getString("DESTINATION_CODE"));
			t.settAmount(rset.getInt("T_AMOUNT"));
			t.settDate(rset.getDate("T_DATE"));
			t.settWriter(rset.getString("T_WRITER"));
			
//			System.out.println("transfer@dao=" + t);
			tList.add(t);
		} 
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(rset);
		close(pstmt);
	}
//	System.out.println("tList@DAO=" + tList);
	return tList;
}

public int selectTotal(Connection conn, String[] searchArr) {
	int totalContents = 0;
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	String sql = prop.getProperty("transferFinderTotalContents");
	
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
	
//	System.out.println("totalContents@dao = " + totalContents);
	return totalContents;
}

public Transfer transferSelectOne(Connection conn, String tCode) {
	Transfer transfer = null;
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	String sql = prop.getProperty("transferSelectOne");
	
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, tCode);
		rset = pstmt.executeQuery();
		
		if(rset.next()) {
			transfer = new Transfer();
			transfer.settCode(rset.getString("T_CODE"));
			transfer.setpCode(rset.getString("P_CODE"));
			transfer.settAmount(rset.getInt("T_AMOUNT"));
			transfer.settDate(rset.getDate("T_DATE"));
			transfer.setDepartureCode(rset.getString("DEPARTURE_CODE"));
			transfer.setDestinationCode(rset.getString("DESTINATION_CODE"));
			transfer.settStatus(rset.getString("T_STATUS"));
			transfer.settTitle(rset.getString("T_TITLE"));
			transfer.settWriter(rset.getString("T_WRITER"));
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(rset);
		close(pstmt);
	}
//	System.out.println("transfer@dao = " + transfer);
	return transfer;
}


}
