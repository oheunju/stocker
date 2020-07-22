package member.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import member.model.dao.EmpDAO;
import member.model.vo.Employee;
import member.model.vo.Todo;

public class EmpService {
	
	private EmpDAO empDAO = new EmpDAO();

	public Employee selectOne(int eCode) {
		Connection conn = getConnection();
		Employee emp = empDAO.selectone(conn, eCode);
		
//		System.out.println("emp@service=" + emp);
		return emp;
	}

	public int updatePassword(int eCode, String encryptedNewPassword) {
		Connection conn = getConnection();
		int result = empDAO.updatePassword(conn, eCode, encryptedNewPassword);
		
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		
//		System.out.println("result@service = " + result);
		return result;
	}
	
	public List<Todo> selectTodo(int ecode) {
		Connection conn = getConnection();
		List<Todo> todo = empDAO.selectTodo(conn, ecode);
		close(conn);
		return todo;
	}

	public int updateTodo(int m_code, String m_status) {
		Connection conn = getConnection();
		int result = empDAO.updateTodo(conn, m_code, m_status);
		
		if(result > 0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return result;
	}

	public int deleteTodo(int m_code) {
		Connection conn = getConnection();
		int result = empDAO.deleteTodo(conn, m_code);
		
		if(result > 0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return result;
	}

	public int insertTodo(int ecode, String mcoments) {
		Connection conn = getConnection();
		int result = empDAO.insertTodo(conn, ecode, mcoments);
		
		if(result > 0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return result;
	}

	public Employee selctOne(int writer) {
		Connection conn = getConnection();
		Employee emp = empDAO.selectone(conn, writer);
		return emp;
	}

}
