package team2.board_comment;

import java.sql.Timestamp;

import team2.member.MemberDataBean;
import team2.review_board.Review_BoardDataBean;

public class Board_CommentDataBean {
	
	private int board_comment_num;
	private Review_BoardDataBean board;
	private MemberDataBean member;
	private String board_comment_content;
	private Timestamp board_comment_date;
	private int member_num;
	private int review_board_num;
	private String member_id;

	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getBoard_comment_num() {
		return board_comment_num;
	}
	public void setBoard_comment_num(int board_comment_num) {
		this.board_comment_num = board_comment_num;
	}
	public Review_BoardDataBean getBoard() {
		return board;
	}
	public void setBoard(Review_BoardDataBean board) {
		this.board = board;
	}
	public MemberDataBean getMember() {
		return member;
	}
	public void setMember(MemberDataBean member) {
		this.member = member;
	}
	public String getBoard_comment_content() {
		return board_comment_content;
	}
	public void setBoard_comment_content(String board_comment_content) {
		this.board_comment_content = board_comment_content;
	}
	public Timestamp getBoard_comment_date() {
		return board_comment_date;
	}
	public void setBoard_comment_date(Timestamp board_comment_date) {
		this.board_comment_date = board_comment_date;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public int getReview_board_num() {
		return review_board_num;
	}
	public void setReview_board_num(int review_board_num) {
		this.review_board_num = review_board_num;
	}

	
	

}
