package team2.book;
import team2.cybermoney.CybermoneyDataBean;
import team2.menu_input.Menu_InputDataBean;
import team2.menu_ordersheet.Menu_OrderSheetDataBean;
/**
 * 
 * @author Á¤´Ù¿µ
 *
 */
public class BookDataBean {
	private int book_num;
	private String book_date;
	private Menu_OrderSheetDataBean menuOrderSheet;
	private Menu_InputDataBean menuInput;
	private int menu_input_num;
	private CybermoneyDataBean cybermoney;
	private int charge_num;
	private int sum_input;
	private int sum_charge;
	private int input_price;
	private int charge_price;
	private String member_id;
	private String supplier_name;
	
	public String getSupplier_name() {
		return supplier_name;
	}
	public void setSupplier_name(String supplier_name) {
		this.supplier_name = supplier_name;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getInput_price() {
		return input_price;
	}
	public void setInput_price(int input_price) {
		this.input_price = input_price;
	}
	public int getCharge_price() {
		return charge_price;
	}
	public void setCharge_price(int charge_price) {
		this.charge_price = charge_price;
	}
	public Menu_OrderSheetDataBean getMenuOrderSheet() {
		return menuOrderSheet;
	}
	public void setMenuOrderSheet(Menu_OrderSheetDataBean menuOrderSheet) {
		this.menuOrderSheet = menuOrderSheet;
	}
	public int getSum_input() {
		return sum_input;
	}
	public void setSum_input(int sum_input) {
		this.sum_input = sum_input;
	}
	public int getSum_charge() {
		return sum_charge;
	}
	public void setSum_charge(int sum_charge) {
		this.sum_charge = sum_charge;
	}
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}
	public String getBook_date() {
		return book_date;
	}
	public void setBook_date(String book_date) {
		this.book_date = book_date;
	}
	public Menu_InputDataBean getMenuInput() {
		return menuInput;
	}
	public void setMenuInput(Menu_InputDataBean menuInput) {
		this.menuInput = menuInput;
	}
	public int getMenu_input_num() {
		return menu_input_num;
	}
	public void setMenu_input_num(int menu_input_num) {
		this.menu_input_num = menu_input_num;
	}
	public CybermoneyDataBean getCybermoney() {
		return cybermoney;
	}
	public void setCybermoney(CybermoneyDataBean cybermoney) {
		this.cybermoney = cybermoney;
	}
	public int getCharge_num() {
		return charge_num;
	}
	public void setCharge_num(int charge_num) {
		this.charge_num = charge_num;
	}
	
	
}
