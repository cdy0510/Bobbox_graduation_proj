package team2.menu;
import team2.supplier.*;

public class MenuDataBean {
	private int menu_num;
	private String menu_name;
	private String menu_charge;
	private String menu_image;
	private double menu_kcal;
	private double menu_carbor;
	private double menu_protein;
	private double menu_fat;
	private double menu_natrium;
	private String menu_grade;
	private String menu_big_class;
	private String menu_small_class;
	private int menu_order_count;
	private SupplierDataBean supplier;
	private int supplier_num;
	private String supplier_name;
	private String menu_cost;
	
	public int getSupplier_num() {
		return supplier_num;
	}
	public void setSupplier_num(int supplier_num) {
		this.supplier_num = supplier_num;
	}
	public SupplierDataBean getSupplier() {
		return supplier;
	}
	public void setSupplier(SupplierDataBean supplier) {
		this.supplier = supplier;
	}
	public String getSupplier_name() {
		return supplier_name;
	}
	public void setSupplier_name(String supplier_name) {
		this.supplier_name = supplier_name;
	}
	public String getMenu_cost() {
		return menu_cost;
	}
	public void setMenu_cost(String menu_cost) {
		this.menu_cost = menu_cost;
	}
	public int getMenu_order_count() {
		return menu_order_count;
	}
	public void setMenu_order_count(int menu_order_count) {
		this.menu_order_count = menu_order_count;
	}
	public int getMenu_num() {
		return menu_num;
	}
	public void setMenu_num(int menu_num) {
		this.menu_num = menu_num;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_charge() {
		return menu_charge;
	}
	public void setMenu_charge(String menu_charge) {
		this.menu_charge = menu_charge;
	}
	public String getMenu_image() {
		return menu_image;
	}
	public void setMenu_image(String menu_image) {
		this.menu_image = menu_image;
	}
	public double getMenu_kcal() {
		return menu_kcal;
	}
	public void setMenu_kcal(double menu_kcal) {
		this.menu_kcal = menu_kcal;
	}
	public double getMenu_carbor() {
		return menu_carbor;
	}
	public void setMenu_carbor(double menu_carbor) {
		this.menu_carbor = menu_carbor;
	}
	public double getMenu_protein() {
		return menu_protein;
	}
	public void setMenu_protein(double menu_protein) {
		this.menu_protein = menu_protein;
	}
	public double getMenu_fat() {
		return menu_fat;
	}
	public void setMenu_fat(double menu_fat) {
		this.menu_fat = menu_fat;
	}
	public double getMenu_natrium() {
		return menu_natrium;
	}
	public void setMenu_natrium(double menu_natrium) {
		this.menu_natrium = menu_natrium;
	}
	public String getMenu_grade() {
		return menu_grade;
	}
	public void setMenu_grade(String menu_grade) {
		this.menu_grade = menu_grade;
	}
	public String getMenu_big_class() {
		return menu_big_class;
	}
	public void setMenu_big_class(String menu_big_class) {
		this.menu_big_class = menu_big_class;
	}
	public String getMenu_small_class() {
		return menu_small_class;
	}
	public void setMenu_small_class(String menu_small_class) {
		this.menu_small_class = menu_small_class;
	}
	public void setSupplier(int supplier_num){
		
	}
}
