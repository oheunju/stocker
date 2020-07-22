package member.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import member.model.vo.Employee;
import member.model.vo.Todo;

public class EmpDAO {
	
private Properties prop = new Properties();
	
	public EmpDAO() {
		String fileName = EmpDAO.class.getResource("/sql/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public Employee selectone(Connection conn, String eCode) {
		Employee emp = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOne");
		
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, eCode);
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					emp = new Employee();
					
					emp.seteCode(rset.getInt("E_CODE"));
					emp.seteName(rset.getString("E_NAME"));
					emp.setePassword(rset.getString("E_PASSWORD"));
					emp.seteDept(rset.getString("E_DEPT"));
					emp.setePhone(rset.getString("E_PHONE"));
					emp.seteEmail(rset.getString("E_EMAIL"));
//					System.out.println("emp@dao.selectOne = " + emp);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rset);
				close(pstmt);
			}
//		System.out.println("emp@dao=" + emp);
		return emp;
	}

	public int updatePassword(Connection conn, int eCode, String encryptedNewPassword) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updatePassword");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, encryptedNewPassword);
			pstmt.setInt(2, eCode);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
//		System.out.println("result@dao =" + result);
		return result;
	}

	
	public List<Todo> selectTodo(Connection conn, int ecode) {
		List<Todo> todo = new ArrayList<Todo>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectTodo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ecode);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Todo t = new Todo(rset.getInt("m_code"), 
								  rset.getInt("e_code"), 
								  rset.getString("m_contents"), 
								  rset.getString("m_status"));
				todo.add(t);
				
//				System.out.println("todo@dao = " + t);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
//		System.out.println("todoList@dao = " + todo);
		
		return todo;
	}

	public int updateTodo(Connection conn, int m_code, String m_status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateTodo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			if(m_status.equals("C"))
				pstmt.setString(1, "W");
			else
				pstmt.setString(1, "C");
			
			pstmt.setInt(2, m_code);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
				
		
		return result;
	}

	public int deleteTodo(Connection conn, int m_code) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteTodo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_code);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
				
		
		return result;
	}

	public int insertTodo(Connection conn, int ecode, String mcoments) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertTodo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ecode);
			pstmt.setString(2, mcoments);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
				
		
		return result;
	}

	public Employee selectone(Connection conn, int writer) {
		Employee emp = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectWriter");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, writer);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				emp = new Employee(rset.getInt("e_code"), 
								   rset.getString("e_name"), 
								   rset.getString("e_password"), 
								   rset.getString("e_dept"), 
								   rset.getString("e_phone"), 
								   rset.getString("e_email"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	finally {
			close(pstmt);
		}
		return emp;
	}
}
