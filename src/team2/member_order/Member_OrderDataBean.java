package team2.member_order;

import java.sql.Timestamp;

public class Member_OrderDataBean {

	private int member_order_num;
	private Timestamp member_pay_date;
	private String member_order_sum_price;
	
	
	public int getMember_order_num() {
		return member_order_num;
	}
	public void setMember_order_num(int member_order_num) {
		this.member_order_num = member_order_num;
	}
	public Timestamp getMember_pay_date() {
		return member_pay_date;
	}
	public void setMember_pay_date(Timestamp member_pay_date) {
		this.member_pay_date = member_pay_date;
	}
	public String getMember_order_sum_price() {
		return member_order_sum_price;
	}
	public void setMember_order_sum_price(String member_order_sum_price) {
		this.member_order_sum_price = member_order_sum_price;
	}
	
}
