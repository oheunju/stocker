package sales.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.io.Serializable;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;

import sales.model.dao.SalesDAO;
import sales.model.vo.MostSoldProduct;
import sales.model.vo.RankedShop;
import sales.model.vo.RankedTransfer;

public class SalesService implements Serializable {

	private SalesDAO salesDAO = new SalesDAO();

	public int CountInbound(int thisYear, int thisMonth) {
		Connection conn = getConnection();
		
		int countInbound = salesDAO.CountInbound(conn, thisYear, thisMonth);
		
		close(conn);
		
		return countInbound;
	}
	
	public int CountOutbound(int thisYear, int thisMonth) {
		Connection conn = getConnection();
		
		int countOutbound = salesDAO.CountOutbound(conn, thisYear, thisMonth);
		
		close(conn);
		
		return countOutbound;
	}
	
	public List<RankedShop> RankingShop(int thisYear){
		Connection conn = getConnection();
		
		List<RankedShop> list = salesDAO.RankingShop(conn, thisYear);
		
		close(conn);
		
		return list;
	}
	
	public List<MostSoldProduct> mostSoldProducts(int thisYear){
		Connection conn = getConnection();
		
		List<MostSoldProduct> list = salesDAO.mostSoldProducts(conn, thisYear);
		
		close(conn);
		
		return list;
	}
	
	public List<RankedTransfer> RankTransfer1(int thisYear){
		Connection conn = getConnection();
		
		List<RankedTransfer> list = salesDAO.RankTransfer1(conn, thisYear);
		
		close(conn);
		
		return list;
	}
	
	public List<RankedTransfer> RankTransfer2(int thisYear){
		Connection conn = getConnection();
		
		List<RankedTransfer> list = salesDAO.RankTransfer2(conn, thisYear);
		
		close(conn);
		
		return list;
	}
	
	public HashMap<String, Integer> StockCategory(){
		Connection conn = getConnection();
		
		HashMap<String, Integer> map = salesDAO.StockCategory(conn);
		
		close(conn);
		return map;
	}
	
	public HashMap<String, Integer> StockTheme(){
		Connection conn = getConnection();
		
		HashMap<String, Integer> map = salesDAO.StockTheme(conn);
		
		close(conn);
		return map;
	}
	
	public HashMap<Integer, Integer> AnnualInbound1 (int thisYear){
		Connection conn = getConnection();
		
		HashMap<Integer, Integer> map = salesDAO.AnnualInbound1(conn, thisYear);
		
		close(conn);
		
		return map;
	}
	
	public HashMap<Integer, Integer> AnnualInbound2 (int thisYear){
		Connection conn = getConnection();
		
		HashMap<Integer, Integer> map = salesDAO.AnnualInbound2(conn, thisYear);
		
		close(conn);
		
		return map;
	}
	public HashMap<Integer, Integer> AnnualOutbound1 (int thisYear){
		Connection conn = getConnection();
		
		HashMap<Integer, Integer> map = salesDAO.AnnualOutbound1(conn, thisYear);
		
		close(conn);
		
		return map;
	}
	public HashMap<Integer, Integer> AnnualOutbound2 (int thisYear){
		Connection conn = getConnection();
		
		HashMap<Integer, Integer> map = salesDAO.AnnualOutbound2(conn, thisYear);
		
		close(conn);
		
		return map;
	}
}
