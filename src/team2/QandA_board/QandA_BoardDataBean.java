package team2.QandA_board;

import java.sql.Timestamp;

import team2.member.MemberDataBean;

public class QandA_BoardDataBean {

	private int QandA_board_num;
	private MemberDataBean member;
	private String QandA_board_title;
	private String QandA_board_content;
	private int QandA_board_passwd;
	private Timestamp QandA_board_date;
	private int QandA_board_count;
	private String member_id;
	private int member_num;
	

	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public int getQandA_board_num() {
		return QandA_board_num;
	}
	public void setQandA_board_num(int qandA_board_num) {
		QandA_board_num = qandA_board_num;
	}
	public MemberDataBean getMember() {
		return member;
	}
	public void setMember(MemberDataBean member) {
		this.member = member;
	}
	public String getQandA_board_title() {
		return QandA_board_title;
	}
	public void setQandA_board_title(String qandA_board_title) {
		QandA_board_title = qandA_board_title;
	}
	public String getQandA_board_content() {
		return QandA_board_content;
	}
	public void setQandA_board_content(String qandA_board_content) {
		QandA_board_content = qandA_board_content;
	}
	public int getQandA_board_passwd() {
		return QandA_board_passwd;
	}
	public void setQandA_board_passwd(int QandA_board_passwd) {
		this.QandA_board_passwd = QandA_board_passwd;
	}
	public Timestamp getQandA_board_date() {
		return QandA_board_date;
	}
	public void setQandA_board_date(Timestamp qandA_board_date) {
		QandA_board_date = qandA_board_date;
	}
	public int getQandA_board_count() {
		return QandA_board_count;
	}
	public void setQandA_board_count(int qandA_board_count) {
		QandA_board_count = qandA_board_count;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	
	
	
	
	
	
}
