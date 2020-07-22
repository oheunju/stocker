package product.model.service;

import java.io.Serializable;
import java.sql.Connection;

import product.model.dao.ProductDAO;
import product.model.vo.Product;

import static common.JDBCTemplate.*;

public class ProductService implements Serializable{
	
	private ProductDAO productDAO = new ProductDAO();

	public Product selectOne(String pCode) {
		Connection conn = getConnection();
		Product product = productDAO.selectOne(conn, pCode);
		close(conn);
		
		return product;
	}
}
