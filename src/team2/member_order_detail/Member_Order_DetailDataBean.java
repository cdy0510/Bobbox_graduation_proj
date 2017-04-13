package team2.member_order_detail;

import team2.keep.KeepDataBean;
import team2.member_order.Member_OrderDataBean;

public class Member_Order_DetailDataBean {

	private int member_order_detail_num;
	private KeepDataBean keep;
	private Member_OrderDataBean member_order;
	private String order_quantity;
	private String order_delivery_date;
	private String order_delivery_time;
	private String order_price;
	private String order_where;
	private int keep_num;
	private int member_order_num;
	
	private String member_id;
	private String member_pay_date;
	private String member_order_sum_price;
	
	public int getMember_order_detail_num() {
		return member_order_detail_num;
	}
	public void setMember_order_detail_num(int member_order_detail_num) {
		this.member_order_detail_num = member_order_detail_num;
	}
	public KeepDataBean getKeep() {
		return keep;
	}
	public void setKeep(KeepDataBean keep) {
		this.keep = keep;
	}
	public Member_OrderDataBean getMember_order() {
		return member_order;
	}
	public void setMember_order(Member_OrderDataBean member_order) {
		this.member_order = member_order;
	}
	public String getOrder_quantity() {
		return order_quantity;
	}
	public void setOrder_quantity(String order_quantity) {
		this.order_quantity = order_quantity;
	}
	public String getOrder_delivery_date() {
		return order_delivery_date;
	}
	public void setOrder_delivery_date(String order_delivery_date) {
		this.order_delivery_date = order_delivery_date;
	}
	public String getOrder_delivery_time() {
		return order_delivery_time;
	}
	public void setOrder_delivery_time(String order_delivery_time) {
		this.order_delivery_time = order_delivery_time;
	}
	public String getOrder_price() {
		return order_price;
	}
	public void setOrder_price(String order_price) {
		this.order_price = order_price;
	}
	public String getOrder_where() {
		return order_where;
	}
	public void setOrder_where(String order_where) {
		this.order_where = order_where;
	}
	public int getKeep_num() {
		return keep_num;
	}
	public void setKeep_num(int keep_num) {
		this.keep_num = keep_num;
	}
	public int getMember_order_num() {
		return member_order_num;
	}
	public void setMember_order_num(int member_order_num) {
		this.member_order_num = member_order_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pay_date() {
		return member_pay_date;
	}
	public void setMember_pay_date(String member_pay_date) {
		this.member_pay_date = member_pay_date;
	}
	public String getMember_order_sum_price() {
		return member_order_sum_price;
	}
	public void setMember_order_sum_price(String member_order_sum_price) {
		this.member_order_sum_price = member_order_sum_price;
	}

}
