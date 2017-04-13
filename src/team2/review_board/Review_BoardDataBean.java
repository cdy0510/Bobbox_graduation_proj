package team2.review_board;

import java.sql.Timestamp;

import team2.member.MemberDataBean;

public class Review_BoardDataBean {

	private int review_board_num;
	private MemberDataBean member;
	private String review_board_title;
	private String review_board_content;
	private int review_board_passwd;
	private Timestamp review_board_date;
	private int review_board_count;
	private int like_yes_no;
	private int re_group_num;
	private int re_step;
	private int re_level;
	private String member_id;
	private int member_num;
	
	public int getReview_board_num() {
		return review_board_num;
	}
	public void setReview_board_num(int review_board_num) {
		this.review_board_num = review_board_num;
	}
	public MemberDataBean getMember() {
		return member;
	}
	public void setMember(MemberDataBean member) {
		this.member = member;
	}
	public String getReview_board_title() {
		return review_board_title;
	}
	public void setReview_board_title(String review_board_title) {
		this.review_board_title = review_board_title;
	}
	public String getReview_board_content() {
		return review_board_content;
	}
	public void setReview_board_content(String review_board_content) {
		this.review_board_content = review_board_content;
	}
	public int getReview_board_passwd() {
		return review_board_passwd;
	}
	public void setReview_board_passwd(int review_board_passwd) {
		this.review_board_passwd = review_board_passwd;
	}
	public Timestamp getReview_board_date() {
		return review_board_date;
	}
	public void setReview_board_date(Timestamp review_board_date) {
		this.review_board_date = review_board_date;
	}
	public int getReview_board_count() {
		return review_board_count;
	}
	public void setReview_board_count(int review_board_count) {
		this.review_board_count = review_board_count;
	}
	public int getLike_yes_no() {
		return like_yes_no;
	}
	public void setLike_yes_no(int like_yes_no) {
		this.like_yes_no = like_yes_no;
	}
	public int getRe_group_num() {
		return re_group_num;
	}
	public void setRe_group_num(int re_group_num) {
		this.re_group_num = re_group_num;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	
	

}
