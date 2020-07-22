package member.model.vo;

import java.io.Serializable;

public class Todo implements Serializable{
	private int m_code;
	private int e_code;
	private String m_contents;
	private String m_status;
	
	public Todo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Todo(int m_code, int e_code, String m_contents, String m_status) {
		super();
		this.m_code = m_code;
		this.e_code = e_code;
		this.m_contents = m_contents;
		this.m_status = m_status;
	}
	public int getM_code() {
		return m_code;
	}
	public void setM_code(int m_code) {
		this.m_code = m_code;
	}
	public int getE_code() {
		return e_code;
	}
	public void setE_code(int e_code) {
		this.e_code = e_code;
	}
	public String getM_contents() {
		return m_contents;
	}
	public void setM_contents(String m_contents) {
		this.m_contents = m_contents;
	}
	public String getM_status() {
		return m_status;
	}
	public void setM_status(String m_status) {
		this.m_status = m_status;
	}
	@Override
	public String toString() {
		return "Todo [m_code=" + m_code + ", e_code=" + e_code + ", m_contents=" + m_contents + ", m_status=" + m_status
				+ "]";
	}
	
	
}
