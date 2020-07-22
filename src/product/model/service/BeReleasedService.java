package product.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import order.model.vo.Transfer;
import product.model.dao.BeReleasedDAO;
import product.model.vo.BeReleased;

public class BeReleasedService {
	private BeReleasedDAO bereleasedDAO = new BeReleasedDAO();
	
	public List<BeReleased> selectAll(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<BeReleased> list = bereleasedDAO.selectAll(conn, cPage, numPerPage);
		close(conn);
		
//		System.out.println("bereleased service@service = " + list);
		
		return list;
	}

	public int selectBereleasedCount() {
		Connection conn = getConnection();
		int totalConetents = bereleasedDAO.selectBereleasedCount(conn);
		close(conn);
		return totalConetents;
	}

	public List<BeReleased> searchBeReleased(String[] searchArr, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<BeReleased> searchbrlist = bereleasedDAO.searchBeReleased(conn, searchArr, cPage, numPerPage);
//		System.out.println("tList@service=" + tList.toString());
		return searchbrlist;
	}

	public int selectTotalContents(String[] searchArr) {
		Connection conn = getConnection();
		int totalContents = bereleasedDAO.selectTotal(conn, searchArr);
		close(conn);
		return totalContents;
	}

}
