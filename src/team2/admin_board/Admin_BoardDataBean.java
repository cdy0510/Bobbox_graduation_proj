package team2.admin_board;

import java.sql.Timestamp;

public class Admin_BoardDataBean {

	private int admin_board_num;
	private String admin_board_type;
	private String admin_board_title;
	private String admin_board_content;
	private Timestamp admin_board_date;
	private int admin_board_count;
	
	public int getAdmin_board_num() {
		return admin_board_num;
	}
	public void setAdmin_board_num(int admin_board_num) {
		this.admin_board_num = admin_board_num;
	}
	public String getAdmin_board_type() {
		return admin_board_type;
	}
	public void setAdmin_board_type(String admin_board_type) {
		this.admin_board_type = admin_board_type;
	}
	public String getAdmin_board_title() {
		return admin_board_title;
	}
	public void setAdmin_board_title(String admin_board_title) {
		this.admin_board_title = admin_board_title;
	}
	public String getAdmin_board_content() {
		return admin_board_content;
	}
	public void setAdmin_board_content(String admin_board_content) {
		this.admin_board_content = admin_board_content;
	}
	public Timestamp getAdmin_board_date() {
		return admin_board_date;
	}
	public void setAdmin_board_date(Timestamp admin_board_date) {
		this.admin_board_date = admin_board_date;
	}
	public int getAdmin_board_count() {
		return admin_board_count;
	}
	public void setAdmin_board_count(int admin_board_count) {
		this.admin_board_count = admin_board_count;
	}
	
	
}
