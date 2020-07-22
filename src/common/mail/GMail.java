package common.mail;

import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class GMail {

	static String userName = "noreply.stockerproject@gmail.com"; //시스템용 이메일
	static String password = "hcyjplzhectawrup"; //시스템용 비밀번호

	private static class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(userName, password);
		}
	}

	public static void send(String to, String title, String body) {

		Properties props = new Properties();
		
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.put("mail.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		// props.put("mail.smtp.port", "25");
		props.put("mail.smtp.port", "587");

		Session session = Session.getDefaultInstance(props, new SMTPAuthenticator());

		try {
			// session.setDebug(true); // 메일을 전송할 때 상세한 상황을 콘솔에 출력

			// session = Session.getDefaultInstance(p);
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(userName));
			message.setSubject(title);
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//			message.setSubject(title);
			message.setText(body);

			BodyPart messageBodyPart = new MimeBodyPart();
			
			// Fill the message
			messageBodyPart.setText(body);
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
			/*
			 * if(!attachfile.isEmpty()){ // Part two is attachment messageBodyPart = new
			 * MimeBodyPart(); File file = new File(Const.getUploadPath() + "\\" +
			 * attachfile); FileDataSource fds = new FileDataSource(file);
			 * messageBodyPart.setDataHandler(new DataHandler(fds));
			 * messageBodyPart.setFileName(fds.getName());
			 * multipart.addBodyPart(messageBodyPart); }
			 */
			// Put parts in message
			message.setContent(multipart, "text/plain;charset=utf-8");

			// Send the message
			Transport.send(message);
//			System.out.println("Gmail SMTP서버를 이용한 메일보내기 성공");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}	
	}

}