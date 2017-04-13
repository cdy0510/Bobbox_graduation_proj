package team2.menu_ordersheet;

import java.sql.Timestamp;

/**
 * 메뉴 주문서 DataBean
 * @author 정다영
 *
 */
public class Menu_OrderSheetDataBean {
	
	/**
	 * 메뉴 주문서 번호
	 */
	private int menu_ordersheet_num;
	/**
	 * 메뉴 결제 날짜
	 */
	private Timestamp menu_pay_Timestamp;
	/**
	 * 메뉴 주문 총 금액
	 */
	private String menu_order_sum_price;
	/**
	 * 메뉴 결제 방법
	 */
	private String menu_payment_option;
	/**
	 * 메뉴 수취 여부
	 */
	private String menu_receipt_yes_no;
	
	public int getMenu_ordersheet_num() {
		return menu_ordersheet_num;
	}
	public void setMenu_ordersheet_num(int menu_ordersheet_num) {
		this.menu_ordersheet_num = menu_ordersheet_num;
	}
	public Timestamp getMenu_pay_date() {
		return menu_pay_Timestamp;
	}
	public void setMenu_pay_date(Timestamp menu_pay_Timestamp) {
		this.menu_pay_Timestamp = menu_pay_Timestamp;
	}
	public String getMenu_order_sum_price() {
		return menu_order_sum_price;
	}
	public void setMenu_order_sum_price(String menu_order_sum_price) {
		this.menu_order_sum_price = menu_order_sum_price;
	}
	public String getMenu_payment_option() {
		return menu_payment_option;
	}
	public void setMenu_payment_option(String menu_payment_option) {
		this.menu_payment_option = menu_payment_option;
	}
	public String getMenu_receipt_yes_no() {
		return menu_receipt_yes_no;
	}
	public void setMenu_receipt_yes_no(String menu_receipt_yes_no) {
		this.menu_receipt_yes_no = menu_receipt_yes_no;
	}
	
}
