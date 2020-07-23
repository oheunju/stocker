package common;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class JDBCTemplate {

    public static Connection getConnection() 
    {
        Connection conn = null;
        try
        {
            // JNDI Java Naming Directory Interface
            Context ctx = new InitialContext();
            DataSource pool = (DataSource) ctx.lookup("java:/comp/env/myoracle");
            conn = pool.getConnection();
            conn.setAutoCommit(false);
        }
        catch (SQLException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (NamingException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return conn;
    }
	
	public static void commit(Connection conn){
		try {
			
			if(conn != null && !conn.isClosed())
				conn.commit();
			
 		} catch(SQLException e) {
 			e.printStackTrace();
 		}
	}
	
	public static void rollback(Connection conn){
		try {
			
			if(conn != null && !conn.isClosed())
				conn.rollback();
			
 		} catch(SQLException e) {
 			e.printStackTrace();
 		}
	}
	
	
	public static void close(Connection conn) {
		
		try {		
			if(conn != null && !conn.isClosed())
				conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void close(PreparedStatement pstmt) {
		
		try {		
			if(pstmt != null && !pstmt.isClosed())
				pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void close(ResultSet rset) {
		
		try {		
			if(rset != null && !rset.isClosed())
				rset.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}

}