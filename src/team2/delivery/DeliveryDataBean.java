package team2.delivery;

import team2.member_order_detail.Member_Order_DetailDataBean;

public class DeliveryDataBean {
	private int delivery_num;
	private Member_Order_DetailDataBean member_order_detail;
	private int member_order_detail_num;
	private String delivery_statement;
	private String deliver_message;
	
	
	public int getDelivery_num() {
		return delivery_num;
	}
	public void setDelivery_num(int delivery_num) {
		this.delivery_num = delivery_num;
	}
	public Member_Order_DetailDataBean getMember_order_detail() {
		return member_order_detail;
	}
	public void setMember_order_detail(
			Member_Order_DetailDataBean member_order_detail) {
		this.member_order_detail = member_order_detail;
	}
	public int getMember_order_detail_num() {
		return member_order_detail_num;
	}
	public void setMember_order_detail_num(int member_order_detail_num) {
		this.member_order_detail_num = member_order_detail_num;
	}
	public String getDelivery_statement() {
		return delivery_statement;
	}
	public void setDelivery_statement(String delivery_statement) {
		this.delivery_statement = delivery_statement;
	}
	public String getDeliver_message() {
		return deliver_message;
	}
	public void setDeliver_message(String deliver_message) {
		this.deliver_message = deliver_message;
	}
	
	
}
