package common.utill;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

public class Utils {
	
	public static String getEncryptedPassword(String password) {
		String encryptedPassword = null;
		
		//1.byte[]로 변환
		byte[] bytes = null;
		try {
			bytes = password.getBytes("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		//2. MessageDigest객체 생성
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("sha-512");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		//3. MessageDigest객체를 통한 암호화
		md.update(bytes);
		byte[] encryptedBytes = md.digest(); //암호화
		
		//4. Base64인코더를 통한 인코딩
		Base64.Encoder encoder = Base64.getEncoder(); 
		encryptedPassword = encoder.encodeToString(encryptedBytes);
		
//		System.out.println("암호화/인코딩전 : " + new String(encryptedBytes));
//		System.out.println("암호화/인코딩처리후 : " + encryptedPassword);
		
		return encryptedPassword;
	}

	/**
	 * String 인자가 비어있는지 아닌지 체크
	 * @param s
	 * @return 비었으면 true, 아니면 false
	 */
	public static boolean isEmpty(String s) {
		return ((null == s)||s.equals(""));
	}
	
	public static String getPageBarHTML(int cPage, int numPerPage, int totalContents, String url) {
		String pageBar = "";
		int pageBarSize = 5; //페이지바에 표시될 페이지번호수
		//(공식2) 
		int totalPage = (int)Math.ceil((double)totalContents/numPerPage);
		//(공식3) pageStart 시작페이지번호 구하기
		// 1 2 3 4 5 => pageStart = 1
		// 6 7 8 9 10 => pageStart = 6
		// 11 12 13 14 15 => pageStart = 11
		//....
		int pageStart = ((cPage-1) / pageBarSize) * pageBarSize + 1; //cPage, pageBarSize
		int pageEnd = pageStart + pageBarSize - 1;
		
		// 증감변수
		int pageNo = pageStart;
		
		//[이전] 영역
		if(pageNo == 1) {
			
		}
		else {
			pageBar += "<a href='"+url+"cPage="+(pageNo-1)+"style='color:b66dff'><i class='mdi mdi-chevron-left' style='color:#b66dff'></i></a>";
		
		}
		
		//페이지번호 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			//현재페이지인 경우
			if(pageNo == cPage) {
				pageBar += "<span class='cPage' style='color:#b66dff'>"+pageNo+"</span>";
			}
			else {
				pageBar += "<a href='"+url+"cPage="+pageNo+"' style='color:#b66dff'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		//[다음] 영역
		if(pageNo > totalPage) {
			
		}
		else {
			pageBar += "<a href='"+url+"cPage="+pageNo+"' style='color:#b66dff'><i class='mdi mdi-chevron-right' style='color:#b66dff'></i></a>";
		}
		
		return pageBar;
	}
	

	//qrCode
    public static void generateQRCodeImage(String text, int width, int height, String filePath)
            throws WriterException, IOException {
    	
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);

        Path path = FileSystems.getDefault().getPath(filePath);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
    }

	public static boolean isEmpty(int i) {
			String s = String.valueOf(i);
			return ((null == s)||s.equals(""));
	}
}
