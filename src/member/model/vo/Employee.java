package member.model.vo;

import java.io.Serializable;

public class Employee implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int eCode; //사번
	private String eName; //사원명
	private String ePassword; //비밀번호
	private String eDept; //부서
	private String ePhone; //전화번호
	private String eEmail; //이메일
	
	public Employee() {
		super();
	}

	public Employee(int eCode, String eName, String ePassword, String eDept, String ePhone, String eEmail) {
		super();
		this.eCode = eCode;
		this.eName = eName;
		this.ePassword = ePassword;
		this.eDept = eDept;
		this.ePhone = ePhone;
		this.eEmail = eEmail;
	}

	public int geteCode() {
		return eCode;
	}

	public void seteCode(int eCode) {
		this.eCode = eCode;
	}

	public String geteName() {
		return eName;
	}

	public void seteName(String eName) {
		this.eName = eName;
	}

	public String getePassword() {
		return ePassword;
	}

	public void setePassword(String ePassword) {
		this.ePassword = ePassword;
	}

	public String geteDept() {
		return eDept;
	}

	public void seteDept(String eDept) {
		this.eDept = eDept;
	}

	public String getePhone() {
		return ePhone;
	}

	public void setePhone(String ePhone) {
		this.ePhone = ePhone;
	}

	public String geteEmail() {
		return eEmail;
	}

	public void seteEmail(String eEmail) {
		this.eEmail = eEmail;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Employee [eCode=" + eCode + ", eName=" + eName + ", ePassword=" + ePassword + ", eDept=" + eDept
				+ ", ePhone=" + ePhone + ", eEmail=" + eEmail + "]";
	}

}
