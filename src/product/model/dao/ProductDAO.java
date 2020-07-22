package product.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import static common.JDBCTemplate.*;
import order.model.vo.Order;
import product.model.vo.Product;

public class ProductDAO {
	
	private Properties prop = new Properties();
	
	public ProductDAO () {
		try {
			String fileName = ProductDAO.class
					.getResource("/sql/product/product-query.properties")
					.getPath();
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
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
				product.setpTheme(rset.getString("P_THEME"));
				product.setpCategory(rset.getString("P_CATEGORY"));
				product.setpName(rset.getString("P_NAME"));
				product.setpColor(rset.getString("P_COLOR"));
				product.setpPrice(rset.getString("P_PRICE"));
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
//		System.out.println("product@dao = " + product);
		return product;
	}

}
