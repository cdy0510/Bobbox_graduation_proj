package team2.menu_input;

import java.sql.Timestamp;

import team2.menu_ordersheet.Menu_OrderSheetDataBean;

/**
 * 
 * @author Á¤´Ù¿µ
 *
 */
public class Menu_InputDataBean {
	private int menu_input_num;
	private Menu_OrderSheetDataBean menuOrderSheet;
	private int menu_ordersheet_num;
	private Timestamp menu_input_date;
	public int getMenu_input_num() {
		return menu_input_num;
	}
	public void setMenu_input_num(int menu_input_num) {
		this.menu_input_num = menu_input_num;
	}
	public Menu_OrderSheetDataBean getMenuOrderSheet() {
		return menuOrderSheet;
	}
	public void setMenuOrderSheet(Menu_OrderSheetDataBean menuOrderSheet) {
		this.menuOrderSheet = menuOrderSheet;
	}
	public int getMenu_ordersheet_num() {
		return menu_ordersheet_num;
	}
	public void setMenu_ordersheet_num(int menu_ordersheet_num) {
		this.menu_ordersheet_num = menu_ordersheet_num;
	}
	public Timestamp getMenu_input_date() {
		return menu_input_date;
	}
	public void setMenu_input_date(Timestamp menu_input_date) {
		this.menu_input_date = menu_input_date;
	}
	
	
}
