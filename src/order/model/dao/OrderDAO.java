package order.model.dao;

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

import org.apache.poi.ss.usermodel.Cell;

import com.oreilly.servlet.MultipartRequest;

import order.model.vo.Order;
import order.model.vo.PageInfo;
import product.model.vo.Product;
import sales.model.vo.Shop;


public class OrderDAO {
	private Properties prop = new Properties();
	
	public OrderDAO() {
		try {
			String fileName 
				= OrderDAO.class
						  .getResource("/sql/order/order-query.properties")
						  .getPath();
			prop.load(new FileReader(fileName));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}

	public List<Order> selectAll(Connection conn, PageInfo pi) {
		List<Order> orderList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAllCompleteOrderList");
		
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
				
				orderList.add(o);
			}
			
//			System.out.println("orderList@dao = " + orderList);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return orderList;
	}

	public List<Product> selectAllProduct(Connection conn) {
		List<Product> pList = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selecAllProduct");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Product p = new Product(rset.getString("p_code"), 
										rset.getString("p_theme"),
										rset.getString("p_category"), 
										rset.getString("p_name"), 
										rset.getString("p_color"), 
										rset.getString("p_price"));
				
//				System.out.println("product@dao = " + p);
				
				pList.add(p);
			}
			
//			System.out.println("pList@dao = " + pList);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return pList;
	}

	public List<Product> searchProducts(Connection conn, String pCode) {
		List<Product> pList = new ArrayList<Product>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchProducts");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+pCode+"%");
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Product p = new Product(rset.getString("p_code"), 
										rset.getString("p_theme"), 
										rset.getString("p_category"),
										rset.getString("p_name"), 
										rset.getString("p_color"), 
										rset.getString("p_price"));
//				System.out.println("product@dao = " + p);
				pList.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return pList;
	}

	public List<Order> searchOrder(Connection conn, PageInfo pi, String[] searchArr) {
		List<Order> oList = new ArrayList<Order>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchOrder");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			cal.setTime(new Date());
	        cal.add(Calendar.DATE, +1);
			String today = sdf.format(cal.getTime());
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getlistLimit() + 1;
			int endRow = startRow + pi.getlistLimit() - 1;
			
			for(int i = 0; i <= 3; i++) 
				pstmt.setString(i+1, "%" + ((searchArr[i]).toUpperCase()).trim() + "%");
			
			pstmt.setString(5, searchArr[4].equals("") ? "2010-01-01" : searchArr[4]);
			pstmt.setString(6, searchArr[5].equals("") ? today : searchArr[5]);
			pstmt.setInt(7, startRow);
			pstmt.setInt(8, endRow);
			
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
				oList.add(o);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return oList;
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

	public Order selectOneOrder(Connection conn, String oCode) {
		Order order = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectOneOrder");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, oCode);
			
			rset = pstmt.executeQuery();
			
			if(rset.next())
				order = new Order(rset.getString("o_code"), 
								  rset.getString("c_code"), 
								  rset.getString("p_code"), 
								  rset.getInt("o_amount"), 
								  rset.getString("s_code"), 
								  rset.getDate("o_date"), 
								  rset.getString("o_status"), 
								  rset.getInt("o_writer"),
								  rset.getString("o_title"), 
								  rset.getString("o_comment"));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
				
		return order;
	}

	public int getListCount(Connection conn, String[] searchArr) {
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
			
			for(int i = 0; i <= 3; i++) 
				pstmt.setString(i+1, "%" + searchArr[i] + "%");
			
			pstmt.setString(5, searchArr[4].equals("") ? "2010-01-01" : searchArr[4]);
			pstmt.setString(6, searchArr[5].equals("") ? today : searchArr[5]);
			
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

	public int insertOrder(Connection conn, Order order) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertOrder");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order.getpCode());
			pstmt.setInt(2, order.getoAmount());
			pstmt.setString(3, order.getsCode());
			pstmt.setString(4, order.getcCode());
			pstmt.setInt(5, order.getWriter());
			pstmt.setString(6, order.getoTitle());
			pstmt.setString(7, order.getoComment());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
				
		
		return result;
	}

	

	public Product selectOneProduct(Connection conn, String getpCode) 
	{
		Product p = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectOne");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, getpCode);
			
			rset = pstmt.executeQuery();
			
			if(rset.next())
			{
				p = new Product(rset.getString("p_code"), 
								rset.getString("p_theme"), 
								rset.getString("p_category"),
								rset.getString("p_name"), 
								rset.getString("p_color"), 
								rset.getString("p_price"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return p;
	}

	public Shop selectOneShop(Connection conn, String getsCode) {
		Shop s = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectOneShop");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, getsCode);
			
			rset = pstmt.executeQuery();
			
			if(rset.next())
			{
				s = new Shop(rset.getString("s_code"), 
							 rset.getString("s_name"), 
							 rset.getString("s_location"), 
							 rset.getString("s_tel"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return s;
	}

}
