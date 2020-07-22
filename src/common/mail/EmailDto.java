package common.mail;

public class EmailDto {
	String mailTo = "";
	String title = "";
	String password = "";
	String content = "";
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getMailTo() {
		return mailTo;
	}
	public void setMailTo(String mailTo) {
		this.mailTo = mailTo;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append(mailTo).append("|");
		sb.append(title).append("|");
		sb.append(password).append("|");
		sb.append(content).append(")");		
		return  sb.toString();
	}
	
}
