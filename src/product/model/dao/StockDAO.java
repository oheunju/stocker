package product.model.dao;

import static common.JDBCTemplate.*;
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

import order.model.vo.Transfer;
import product.model.vo.BeReleased;
import product.model.vo.Stock;
import product.model.vo.StockToTransfer;

public class StockDAO {
	
private static Properties prop = new Properties();
	
	public StockDAO() {
		try {
			String fileName = StockDAO.class
					.getResource("/sql/product/product-query.properties")
					.getPath();
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Stock> selectStockList(Connection conn, int cPage, int numPerPage) {
		List<Stock> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectStockList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Stock s = new Stock();
//				selectStockList=select C_CODE, P_THEME, P_NAME, P_CODE, S_CAPA, S_AMOUNT from stock left join product using(P_CODE) order by P_THEME
				s.setcCode(rset.getString("C_CODE"));
				s.setpTheme(rset.getString("P_THEME"));
				s.setpCategory(rset.getString("P_CATEGORY"));
				s.setpName(rset.getString("P_NAME"));
				s.setpCode(rset.getString("P_CODE"));
				s.setsCapa(rset.getInt("S_CAPA"));
				s.setsAmount(rset.getInt("S_AMOUNT"));
				
				//리스트에 추가
				list.add(s);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
//			System.out.println("list@dao="+list);
		
		return list;
	}

	public int selectStockCount(Connection conn) {
		PreparedStatement pstmt = null;
		int totalContents = 0;
		ResultSet rset = null;
		String sql = prop.getProperty("selectStockCount");
		
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

	public List<Stock> searchStock(Connection conn, String[] searchArr, int cPage, int numPerPage) {
		List<Stock> sList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchStock");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			for(int i = 0; i < 4; i++) {
				pstmt.setString(i+1, "%" + ((searchArr[i]).toUpperCase()).trim() + "%");
			}
			
			pstmt.setInt(5, (cPage - 1) * numPerPage + 1);
			pstmt.setInt(6, cPage * numPerPage);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Stock s = new Stock();
//				c_code, p_theme, p_name, p_code, s_capa, s_amount
				s.setcCode(rset.getString("C_CODE"));
				s.setpTheme(rset.getString("P_THEME"));
				s.setpCategory(rset.getString("P_CATEGORY"));
				s.setpName(rset.getString("P_NAME"));
				s.setpCode(rset.getString("P_CODE"));
				s.setsCapa(rset.getInt("S_CAPA"));
				s.setsAmount(rset.getInt("S_AMOUNT"));
				
//				System.out.println("transfer@dao=" + t);
				sList.add(s);
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println("tList@DAO=" + tList);
		return sList;
	}

	public int selectTotal(Connection conn, String[] searchArr) {
		int totalContents = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("stockerFinderTotalContents");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			
			for(int i = 0; i < 4; i++)
				pstmt.setNString(i+1, "%" + searchArr[i] + "%");
			
			
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
		
//		System.out.println("totalContents@dao = " + totalContents);
		return totalContents;
	}

	public static int insertTransfer(Connection conn, StockToTransfer reqTransfer) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertStockToTransfer");
		
		try {
			//1. Statement객체 생성(미완성쿼리 값대입)
			pstmt = conn.prepareStatement(sql);
//			insertStockToTransfer=insert into transfer values (seq_transfer.nextval, ?, ?, sysdate, ?, ?, 'C', ?)
			pstmt.setString(1, reqTransfer.getpCode());
			pstmt.setInt(2, reqTransfer.gettAmount());
			pstmt.setString(3, reqTransfer.getDepartureCode());
			pstmt.setString(4, reqTransfer.getDestinationCode());
			pstmt.setString(5, reqTransfer.gettTitle());
			pstmt.setString(6, reqTransfer.gettWriter());

			//2. 실행: executeUpdate
			result = pstmt.executeUpdate();
			
//			System.out.println("reqTransfer@dao=" + reqTransfer);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//3. 자원반납
			close(pstmt);
		}
		
//		System.out.println("result@dao="+result);
		return result;
	}

	public static Transfer selectOneStockToTransfer(Connection conn, String tCode) {
		Transfer t = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectOneStockToTransfer");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tCode);
			
			rset = pstmt.executeQuery();
			
			if(rset.next())
//				private String pCode; //상품코드
//			private int tAmount; //이송량
//			private Date tDate; //이송일
//			private String departureCode; //출발지코드
//			private String destinationCode; //도착지코드
//			private String tStatus; // 이송여부
//			private String tTitle; //이송요청품의서 제목
				t = new Transfer(
//						private String tCode; //이송코드
//						private Date tDate; //이송일
//						private int tAmount; //이송량
//						private String tStatus; // 이송여부
//						private String departureCode; //출발지코드
//						private String destinationCode; //도착지코드
//						private String pCode; //상품코드
//						private String tTitle; //이송요청품의서 제목
								  	rset.getString("t_code"),
								  	rset.getDate("t_date"), 
								  	rset.getInt("t_amount"), 
								  	rset.getString("t_status"), 
								  	rset.getString("departure_code"), 
								  	rset.getString("destination_code"), 
									rset.getString("p_code"), 
								  rset.getString("t_title"),
								  rset.getString("t_writer"));
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
				
		return t;
	}

	public static int updateTransfer(Connection conn, Transfer sttT) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateTransfer");
		
		try {
			//1. Statement객체 생성(미완성쿼리 값대입)
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sttT.gettCode());
			
			//2. 실행: executeUpdate
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//3. 자원반납
			close(pstmt);
		}
//		System.out.println("tCode@dao=" + sttT.gettCode());
//		System.out.println("result@dao=" + result);
		return result;
	}

	public static int insertStockToBR(Connection conn, BeReleased BR) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertStockToBR");
		
		try {
			//1. Statement객체 생성(미완성쿼리 값대입)
			pstmt = conn.prepareStatement(sql);
//			insertStockToBR=insert into be_released values (seq_be_released.nextval, ?, null, ?, ?, '매장출고', sysdate)
			pstmt.setString(1, BR.getoCode());
			pstmt.setString(2, BR.getpCode());
			pstmt.setInt(3, BR.getrAmount());

			//2. 실행: executeUpdate
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//3. 자원반납
			close(pstmt);
		}
		
//		System.out.println("dao@insertSTBR="+result);
//		System.out.println("result@dao="+result);
		return result;
	}

	

	

}
