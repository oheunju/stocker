package board.model.vo;


public class Calendar {
	private String title;
	private String color;
	private String start;
	private String end;
	public Calendar() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Calendar(String title, String color, String start, String end) {
		super();
		this.title = title;
		this.color = color;
		this.start = start;
		this.end = end;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "Calendar [title=" + title + ", color=" + color + ", start=" + start + ", end=" + end + "]";
	}
	
	
	
}
