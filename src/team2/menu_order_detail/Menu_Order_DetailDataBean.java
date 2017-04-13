package team2.menu_order_detail;

import java.sql.Timestamp;

import team2.menu.MenuDataBean;
import team2.menu_ordersheet.Menu_OrderSheetDataBean;

public class Menu_Order_DetailDataBean {
	
	private int menu_order_detail_num;
	private String menu_quantity;
	private String menu_sum_price;
	private MenuDataBean menu;
	private Menu_OrderSheetDataBean menu_ordersheet;
	private int menu_num;
	private int menu_ordersheet_num;
	private String menu_name;
	private Timestamp menu_pay_date;
	
	public Timestamp getMenu_pay_date() {
		return menu_pay_date;
	}
	public void setMenu_pay_date(Timestamp menu_pay_date) {
		this.menu_pay_date = menu_pay_date;
	}
	public int getMenu_order_detail_num() {
		return menu_order_detail_num;
	}
	public void setMenu_order_detail_num(int menu_order_detail_num) {
		this.menu_order_detail_num = menu_order_detail_num;
	}
	public String getMenu_quantity() {
		return menu_quantity;
	}
	public void setMenu_quantity(String menu_quantity) {
		this.menu_quantity = menu_quantity;
	}
	public String getMenu_sum_price() {
		return menu_sum_price;
	}
	public void setMenu_sum_price(String menu_sum_price) {
		this.menu_sum_price = menu_sum_price;
	}
	public MenuDataBean getMenu() {
		return menu;
	}
	public void setMenu(MenuDataBean menu) {
		this.menu = menu;
	}
	public Menu_OrderSheetDataBean getMenu_ordersheet() {
		return menu_ordersheet;
	}
	public void setMenu_ordersheet(Menu_OrderSheetDataBean menu_ordersheet) {
		this.menu_ordersheet = menu_ordersheet;
	}
	public int getMenu_num() {
		return menu_num;
	}
	public void setMenu_num(int menu_num) {
		this.menu_num = menu_num;
	}
	public int getMenu_ordersheet_num() {
		return menu_ordersheet_num;
	}
	public void setMenu_ordersheet_num(int menu_ordersheet_num) {
		this.menu_ordersheet_num = menu_ordersheet_num;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	

}
