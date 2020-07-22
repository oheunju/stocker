package common.mail;

public class Emailer {
	public String email = "";
	
	public Emailer(String email) {
		this.email = email;
	}

	public void sendMail(EmailDto dto) {
		
		//이메일 객체가 존재할때만 메일 보냄
		if (dto.getMailTo() != null && dto.getMailTo().length() > 0) {
			
//			System.out.println("dto.getEmail()=" + dto.getMailTo());
			
			GMail.send(dto.getMailTo(), dto.getTitle(), dto.getContent());
		}
	}
}