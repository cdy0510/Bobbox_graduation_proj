package team2.menu_ordersheet;

import java.sql.Timestamp;

/**
 * �޴� �ֹ��� DataBean
 * @author ���ٿ�
 *
 */
public class Menu_OrderSheetDataBean {
	
	/**
	 * �޴� �ֹ��� ��ȣ
	 */
	private int menu_ordersheet_num;
	/**
	 * �޴� ���� ��¥
	 */
	private Timestamp menu_pay_Timestamp;
	/**
	 * �޴� �ֹ� �� �ݾ�
	 */
	private String menu_order_sum_price;
	/**
	 * �޴� ���� ���
	 */
	private String menu_payment_option;
	/**
	 * �޴� ���� ����
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
