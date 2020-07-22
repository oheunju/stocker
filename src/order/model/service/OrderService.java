package order.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import order.model.dao.OrderDAO;
import order.model.vo.Order;
import order.model.vo.PageInfo;
import product.model.vo.Product;
import sales.model.vo.Shop;

public class OrderService {
	private OrderDAO orderDAO = new OrderDAO();

	public List<Order> selectAll(PageInfo pi) {
		Connection conn = getConnection();
		List<Order> orderList = orderDAO.selectAll(conn, pi);
		close(conn);
		
//		System.out.println("orderList@service = " + orderList);
		
		return orderList;
	}

	public List<Product> selectAllProductList() {
		Connection conn = getConnection();
		List<Product> productList = orderDAO.selectAllProduct(conn);
		close(conn);
		
//		System.out.println("productList@service = " + productList);
		
		return productList;
	}

	public List<Product> searchProducts(String pCode) {
		Connection conn = getConnection();
		List<Product> pList = orderDAO.searchProducts(conn, pCode);
		close(conn);
		return pList;
	}

	public List<Order> searchOrder(PageInfo pi, String[] searchArr) {
		Connection conn = getConnection();
		List<Order> oList = orderDAO.searchOrder(conn, pi, searchArr);
		close(conn);
		return oList;
	}

	public int getListCount() {
		Connection conn = getConnection();
		int listCount = orderDAO.getListCount(conn);
		close(conn);
		return listCount;
	}

	public Order selectOneOrder(String oCode) {
		Connection conn = getConnection();
		Order order = orderDAO.selectOneOrder(conn, oCode);
		close(conn);
		return order;
	}

	public int getSearchListCount(String[] searchArr) {
		Connection conn = getConnection();
		int listCount = orderDAO.getListCount(conn, searchArr);
		close(conn);
		return listCount;
	}

	public int insertOrder(List<Order> orderList) {
		Connection conn = getConnection();
		
		int result = 1;
		
		for(Order o : orderList) 
			result *= orderDAO.insertOrder(conn, o);
		
		if(result != 0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return result;
	}

	public Product selectOneProduct(String getpCode) 
	{
		Connection conn = getConnection();
		Product p = orderDAO.selectOneProduct(conn, getpCode);
		close(conn);
		return p;
	}

	public Shop selectOneShop(String getsCode) 
	{
		Connection conn = getConnection();
		Shop s = orderDAO.selectOneShop(conn, getsCode);
		close(conn);
		return s;
	}

}
