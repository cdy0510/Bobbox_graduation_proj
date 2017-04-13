package team2.admin_comment;

import java.sql.Timestamp;

import team2.QandA_board.QandA_BoardDataBean;

public class Admin_CommentDataBean {
	private int admin_comment_num;
	private int QandA_board_num;
	private String admin_comment_content;
	private Timestamp admin_comment_date;
	private QandA_BoardDataBean QandA_Board;
	
	public int getAdmin_comment_num() {
		return admin_comment_num;
	}
	public void setAdmin_comment_num(int admin_comment_num) {
		this.admin_comment_num = admin_comment_num;
	}
	public int getQandA_board_num() {
		return QandA_board_num;
	}
	public void setQandA_board_num(int qandA_board_num) {
		QandA_board_num = qandA_board_num;
	}
	public String getAdmin_comment_content() {
		return admin_comment_content;
	}
	public void setAdmin_comment_content(String admin_comment_content) {
		this.admin_comment_content = admin_comment_content;
	}
	public Timestamp getAdmin_comment_date() {
		return admin_comment_date;
	}
	public void setAdmin_comment_date(Timestamp admin_comment_date) {
		this.admin_comment_date = admin_comment_date;
	}
	public QandA_BoardDataBean getQandA_Board() {
		return QandA_Board;
	}
	public void setQandA_Board(QandA_BoardDataBean qandA_Board) {
		QandA_Board = qandA_Board;
	}


}
