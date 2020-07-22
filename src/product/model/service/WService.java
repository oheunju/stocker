package product.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import order.model.vo.Order;
import order.model.vo.PageInfo;
import product.model.dao.WDAO;
import product.model.vo.Warehousing;

public class WService {
	private WDAO wDAO = new WDAO();
	
	public List<Warehousing> selectAll(PageInfo pi) {
		Connection conn = getConnection();
		List<Warehousing> list = wDAO.selectAll(conn, pi);
		close(conn);
				
		return list;
	}

	public int getListCount() {
		Connection conn = getConnection();
		int listCount = wDAO.getListCount(conn);
		close(conn);
		return listCount;
	}

	public int getSearchListCount(String[] search) {
		Connection conn = getConnection();
		int listCount = wDAO.getSearchListCount(conn, search);
		close(conn);
		return listCount;
	}

	public List<Warehousing> searchWarehousing(PageInfo pi, String[] search) {
		Connection conn = getConnection();
		List<Warehousing> wList = wDAO.searchWarehousing(conn, pi, search);
		close(conn);
		return wList;
	}
}
