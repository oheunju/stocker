package board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Board implements Serializable{
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private String boardContent;
	private String boardOriginalFileName;
	private String boardRenamedFileName;
	private Date boardDate;
	private int boardReadCount;
	private String boardeName;
	
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Board(int boardNo, String boardTitle, String boardWriter, String boardContent, String boardOriginalFileName,
			String boardRenamedFileName, Date boardDate, int boardReadCount, String boardeName) {
		super();
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardWriter = boardWriter;
		this.boardContent = boardContent;
		this.boardOriginalFileName = boardOriginalFileName;
		this.boardRenamedFileName = boardRenamedFileName;
		this.boardDate = boardDate;
		this.boardReadCount = boardReadCount;
		this.boardeName = boardeName;
	}
	public final int getBoardNo() {
		return boardNo;
	}
	public final void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public final String getBoardTitle() {
		return boardTitle;
	}
	public final void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public final String getBoardWriter() {
		return boardWriter;
	}
	public final void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public final String getBoardContent() {
		return boardContent;
	}
	public final void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public final String getBoardOriginalFileName() {
		return boardOriginalFileName;
	}
	public final void setBoardOriginalFileName(String boardOriginalFileName) {
		this.boardOriginalFileName = boardOriginalFileName;
	}
	public final String getBoardRenamedFileName() {
		return boardRenamedFileName;
	}
	public final void setBoardRenamedFileName(String boardRenamedFileName) {
		this.boardRenamedFileName = boardRenamedFileName;
	}
	public final Date getBoardDate() {
		return boardDate;
	}
	public final void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}
	public final int getBoardReadCount() {
		return boardReadCount;
	}
	public final void setBoardReadCount(int boardReadCount) {
		this.boardReadCount = boardReadCount;
	}
	public final String getBoardeName() {
		return boardeName;
	}
	public final void setBoardeName(String boardeName) {
		this.boardeName = boardeName;
	}
	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardWriter=" + boardWriter
				+ ", boardContent=" + boardContent + ", boardOriginalFileName=" + boardOriginalFileName
				+ ", boardRenamedFileName=" + boardRenamedFileName + ", boardDate=" + boardDate + ", boardReadCount="
				+ boardReadCount + ", boardeName=" + boardeName + "]";
	}
	
	
	

}
