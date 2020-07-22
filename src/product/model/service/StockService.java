package product.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import order.model.vo.Transfer;
import product.model.dao.StockDAO;
import product.model.vo.BeReleased;
import product.model.vo.Stock;
import product.model.vo.StockToTransfer;

public class StockService {

	private StockDAO stockDAO = new StockDAO();

	public List<Stock> selectStockList(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<Stock> list = stockDAO.selectStockList(conn, cPage, numPerPage);
		close(conn);
		
//		System.out.println("list@service="+list);
		return list;
	}

	public int selectStockCount() {
		Connection conn = getConnection();
		int totalConetents = stockDAO.selectStockCount(conn);
		close(conn);
		return totalConetents;
	}


	public List<Stock> searchStock(String[] searchArr, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<Stock> sList = stockDAO.searchStock(conn, searchArr, cPage, numPerPage);
		close(conn);
//		System.out.println("sList@service=" + sList.toString());
		return sList;
	}

	public int selectTotalContents(String[] searchArr) {
		Connection conn = getConnection();
		int totalContents = stockDAO.selectTotal(conn, searchArr);
		close(conn);
		return totalContents;
	}

	public int insertStockToTransfer(StockToTransfer reqTransfer) {
		Connection conn = getConnection();
		
		int result = StockDAO.insertTransfer(conn, reqTransfer);
		
		if(result > 0) 
			commit(conn);
		else 
			rollback(conn);
		
//		System.out.println("result@service=" + result);
//		System.out.println("reqTransfer@service=" + reqTransfer);
		close(conn);
		return result;
	}

	public Transfer selectOneStockToTransfer(String tCode) {
		Connection conn = getConnection();
		Transfer t = StockDAO.selectOneStockToTransfer(conn, tCode);
		close(conn);
		return t;
	}

	public int updateTransfer(Transfer sttT) {
		Connection conn = getConnection();
		
		int result = StockDAO.updateTransfer(conn, sttT);
		if(result > 0) 
			commit(conn);
		else 
			rollback(conn);
//		System.out.println("result@service=" + result);
		close(conn);
		return result;
	}

	public int insertStockToBR(BeReleased BR) {
		Connection conn = getConnection();
		
		int result = StockDAO.insertStockToBR(conn, BR);
		
		if(result > 0) 
			commit(conn);
		else 
			rollback(conn);
		
		close(conn);
		
		return result;
	}
	
	
	
}
