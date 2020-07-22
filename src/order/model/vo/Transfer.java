package order.model.vo;
import java.io.Serializable;
import java.sql.Date;

public class Transfer implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String tCode; //이송코드
	private Date tDate; //이송일
	private int tAmount; //이송량
	private String tStatus; // 이송여부
	private String departureCode; //출발지코드
	private String destinationCode; //도착지코드
	private String pCode; //상품코드
	private String tTitle; //이송요청품의서 제목
	private String tWriter; //이송요청서 작성자(재고담당)
	
	public Transfer() {
		super();
	}
	
	

	public Transfer(String tCode, Date tDate, int tAmount, String tStatus, String departureCode, String destinationCode,
			String pCode, String tTitle, String tWriter) {
		super();
		this.tCode = tCode;
		this.tDate = tDate;
		this.tAmount = tAmount;
		this.tStatus = tStatus;
		this.departureCode = departureCode;
		this.destinationCode = destinationCode;
		this.pCode = pCode;
		this.tTitle = tTitle;
		this.tWriter = tWriter;
	}




	public String gettCode() {
		return tCode;
	}

	public void settCode(String tCode) {
		this.tCode = tCode;
	}

	public Date gettDate() {
		return tDate;
	}

	public void settDate(Date tDate) {
		this.tDate = tDate;
	}

	public int gettAmount() {
		return tAmount;
	}

	public void settAmount(int tAmount) {
		this.tAmount = tAmount;
	}

	public String gettStatus() {
		return tStatus;
	}

	public void settStatus(String tStatus) {
		this.tStatus = tStatus;
	}

	public String getDepartureCode() {
		return departureCode;
	}

	public void setDepartureCode(String departureCode) {
		this.departureCode = departureCode;
	}

	public String getDestinationCode() {
		return destinationCode;
	}

	public void setDestinationCode(String destinationCode) {
		this.destinationCode = destinationCode;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public String gettTitle() {
		return tTitle;
	}

	public void settTitle(String tTitle) {
		this.tTitle = tTitle;
	}

	public String gettWriter() {
		return tWriter;
	}

	public void settWriter(String tWriter) {
		this.tWriter = tWriter;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Override
	public String toString() {
		return "Transfer [tCode=" + tCode + ", tDate=" + tDate + ", tAmount=" + tAmount + ", tStatus=" + tStatus
				+ ", departureCode=" + departureCode + ", destinationCode=" + destinationCode + ", pCode=" + pCode
				+ ", tTitle=" + tTitle + ", tWriter=" + tWriter + "]";
	}
	
}
