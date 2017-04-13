package team2.menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
/**
 * 
 * @author 정다영
 *
 */
public class MenuDBBean {
	private static MenuDBBean instance = new MenuDBBean();
	
	public static MenuDBBean getInstance() {
        return instance;
    }
	
	private MenuDBBean(){}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/2014a2");
        return ds.getConnection();
    }
	
	/**
	 * 메뉴 등록
	 * @param menu
	 * @throws Exception
	 */
	public void insertMenu(MenuDataBean menu) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number=0;
        String sql="";
        String grade = "Green";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(menu_num) from menu");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 

            sql = "insert into menu(menu_num, menu_name, menu_charge, menu_image, ";
		    sql+="menu_kcal, menu_carbor, menu_protein, menu_fat, menu_natrium, ";
		    sql+="menu_grade, menu_big_class, menu_small_class, menu_order_count, supplier_num, menu_cost)";
		    sql+="values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, number);
            pstmt.setString(2, menu.getMenu_name());
            pstmt.setString(3, menu.getMenu_charge());
            pstmt.setString(4, menu.getMenu_image());
			pstmt.setDouble(5, menu.getMenu_kcal());
            pstmt.setDouble(6, menu.getMenu_carbor());
            pstmt.setDouble(7, menu.getMenu_protein());
            pstmt.setDouble(8, menu.getMenu_fat());
			pstmt.setDouble(9, menu.getMenu_natrium());
			pstmt.setString(10, grade);
			pstmt.setString(11, menu.getMenu_big_class());
			pstmt.setString(12, menu.getMenu_small_class());
			pstmt.setInt(13, 1);
			pstmt.setInt(14, menu.getSupplier_num());
			pstmt.setString(15, menu.getMenu_cost());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
	
	/**
	 * 메뉴 갯수 Count
	 * @return
	 * @throws Exception
	 */
	public int getMenuCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("SELECT COUNT(*) FROM menu");
           rs = pstmt.executeQuery();

           if (rs.next()) {
              x= rs.getInt(1);
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return x;
   }
	
	/**
	 * 메뉴 목록 보기
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<MenuDataBean> getMenuList()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<MenuDataBean> menuList=null;
       
       try {
           conn = getConnection();
           
           String sql = "SELECT menu_num, menu_name, menu_charge, menu_image, menu_kcal, menu_carbor, menu_protein,";
           sql += " menu_fat, menu_natrium, menu_grade, menu_big_class, menu_small_class,";
           sql += " m.supplier_num, s.supplier_name, menu_cost FROM menu m, supplier s WHERE m.supplier_num = s.supplier_num";
           pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();
           
           pstmt = conn.prepareStatement(sql);
           if (rs.next()) {
        	   menuList = new ArrayList<MenuDataBean>();
               do{
            	   	MenuDataBean menu = new MenuDataBean();
					menu.setMenu_num(rs.getInt("menu_num"));
					menu.setMenu_name(rs.getString("menu_name"));
					menu.setMenu_charge(rs.getString("menu_charge"));
					menu.setMenu_image(rs.getString("menu_image"));
					menu.setMenu_kcal(rs.getDouble("menu_kcal"));
					menu.setMenu_carbor(rs.getDouble("menu_carbor"));
					menu.setMenu_protein(rs.getDouble("menu_protein"));
					menu.setMenu_fat(rs.getDouble("menu_fat"));
					menu.setMenu_natrium(rs.getDouble("menu_natrium"));
					menu.setMenu_grade(rs.getString("menu_grade"));
					menu.setMenu_big_class(rs.getString("menu_big_class"));
					menu.setMenu_small_class(rs.getString("menu_small_class"));
					menu.setSupplier_num(rs.getInt("supplier_num"));
					menu.setSupplier_name(rs.getString("supplier_name"));
					menu.setMenu_cost(rs.getString("menu_cost"));
					menuList.add(menu);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return menuList;
   }
	
	/**
	 * 분류별로 메뉴 
	 * @return
	 * @throws Exception
	 */
	public List<MenuDataBean> getSortedMenuList(String sort)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<MenuDataBean> menuList=null;
       
       try {
           conn = getConnection();
           
           String sql = "SELECT menu_num, menu_name, menu_charge, menu_image, menu_kcal, menu_carbor, menu_protein,";
           sql += " menu_fat, menu_natrium, menu_grade, menu_big_class, menu_small_class,";
           sql += " m.supplier_num, s.supplier_name, menu_cost FROM menu m, supplier s WHERE m.supplier_num = s.supplier_num ";
           sql += " AND menu_big_class = ?";
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, sort);
           rs = pstmt.executeQuery();
           
           pstmt = conn.prepareStatement(sql);
           if (rs.next()) {
        	   menuList = new ArrayList<MenuDataBean>();
               do{
            	   	MenuDataBean menu = new MenuDataBean();
					menu.setMenu_num(rs.getInt("menu_num"));
					menu.setMenu_name(rs.getString("menu_name"));
					menu.setMenu_charge(rs.getString("menu_charge"));
					menu.setMenu_image(rs.getString("menu_image"));
					menu.setMenu_kcal(rs.getDouble("menu_kcal"));
					menu.setMenu_carbor(rs.getDouble("menu_carbor"));
					menu.setMenu_protein(rs.getDouble("menu_protein"));
					menu.setMenu_fat(rs.getDouble("menu_fat"));
					menu.setMenu_natrium(rs.getDouble("menu_natrium"));
					menu.setMenu_grade(rs.getString("menu_grade"));
					menu.setMenu_big_class(rs.getString("menu_big_class"));
					menu.setMenu_small_class(rs.getString("menu_small_class"));
					menu.setSupplier_num(rs.getInt("supplier_num"));
					menu.setSupplier_name(rs.getString("supplier_name"));
					menu.setMenu_cost(rs.getString("menu_cost"));
					menuList.add(menu);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return menuList;
   }
	
	/**
	 * 메뉴 삭제
	 * @param num
	 * @return
	 * @throws Exception
	 */
	public int deleteMenu(String selected)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        int x=-1;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
				  "DELETE FROM menu WHERE menu_num IN("+selected+")");
				pstmt.executeUpdate();
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
	  }	
	
	/**
	 * 메뉴 단건 조회
	 * @param menuNum
	 * @return
	 * @throws Exception
	 */
	public MenuDataBean getMenu(int menuNum) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       MenuDataBean menu=null;
	       
	       try {
	           conn = getConnection();
	           
	           String sql = "SELECT menu_num, menu_name, menu_charge, menu_image, menu_kcal, menu_carbor, menu_protein,";
	           sql += " menu_fat, menu_natrium, menu_grade, menu_big_class, menu_small_class,";
	           sql += " m.supplier_num, supplier_name, menu_cost FROM menu m, supplier s WHERE m.supplier_num = s.supplier_num";
	           sql += " AND menu_num = ?";
	           
	           pstmt = conn.prepareStatement(sql);
	           pstmt.setInt(1, menuNum);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	    menu = new MenuDataBean();
					menu.setMenu_num(rs.getInt("menu_num"));
					menu.setMenu_name(rs.getString("menu_name"));
					menu.setMenu_charge(rs.getString("menu_charge"));
					menu.setMenu_image(rs.getString("menu_image"));
					menu.setMenu_kcal(rs.getDouble("menu_kcal"));
					menu.setMenu_carbor(rs.getDouble("menu_carbor"));
					menu.setMenu_protein(rs.getDouble("menu_protein"));
					menu.setMenu_fat(rs.getDouble("menu_fat"));
					menu.setMenu_natrium(rs.getDouble("menu_natrium"));
					menu.setMenu_grade(rs.getString("menu_grade"));
					menu.setMenu_big_class(rs.getString("menu_big_class"));
					menu.setMenu_small_class(rs.getString("menu_small_class"));
					menu.setSupplier_num(rs.getInt("supplier_num"));
					menu.setSupplier_name(rs.getString("supplier_name"));
					menu.setMenu_cost(rs.getString("menu_cost"));
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return menu;
	}
	
	/**
	 * 메뉴 수정
	 * @param menu
	 * @throws Exception
	 */
	public void updateMenu(MenuDataBean menu) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("SELECT * FROM menu WHERE menu_num = ?");
            pstmt.setInt(1, menu.getMenu_num());
			rs = pstmt.executeQuery();
			if (rs.next()){
				
            sql = "UPDATE menu m, supplier s SET menu_name=?, menu_charge=?, menu_image=?, ";
		    sql+="menu_kcal=?, menu_carbor=?, menu_protein=?, menu_fat=?, menu_natrium=?, ";
		    sql+="menu_big_class=?, menu_small_class=?, m.supplier_num=?, menu_cost=? WHERE m.supplier_num = s.supplier_num AND m.menu_num=?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, menu.getMenu_name());
            pstmt.setString(2, menu.getMenu_charge());
            pstmt.setString(3, menu.getMenu_image());
			pstmt.setDouble(4, menu.getMenu_kcal());
            pstmt.setDouble(5, menu.getMenu_carbor());
            pstmt.setDouble(6, menu.getMenu_protein());
            pstmt.setDouble(7, menu.getMenu_fat());
			pstmt.setDouble(8, menu.getMenu_natrium());
			pstmt.setString(9, menu.getMenu_big_class());
			pstmt.setString(10, menu.getMenu_small_class());
			pstmt.setInt(11, menu.getSupplier_num());
			pstmt.setString(12, menu.getMenu_cost());
			pstmt.setInt(13, menu.getMenu_num());
			
            pstmt.executeUpdate();
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
	
	/**
	 * 공급업체별 메뉴조회
	 * @param supplier_name
	 * @return
	 * @throws Exception
	 */
	public List<MenuDataBean> getSupplierMenuList(String supplier_name)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<MenuDataBean> menuList=null;
       
       try {
           conn = getConnection();
           
           String sql = "SELECT menu_num, menu_name, menu_charge, menu_image, menu_kcal, menu_carbor, menu_protein,";
           sql += " menu_fat, menu_natrium, menu_grade, menu_big_class, menu_small_class,";
           sql += " m.supplier_num, s.supplier_name, menu_cost FROM menu m, supplier s WHERE m.supplier_num = s.supplier_num ";
           sql += " AND supplier_name = ?";
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, supplier_name);
           rs = pstmt.executeQuery();
           
           pstmt = conn.prepareStatement(sql);
           if (rs.next()) {
        	   menuList = new ArrayList<MenuDataBean>();
               do{
            	   	MenuDataBean menu = new MenuDataBean();
					menu.setMenu_num(rs.getInt("menu_num"));
					menu.setMenu_name(rs.getString("menu_name"));
					menu.setMenu_charge(rs.getString("menu_charge"));
					menu.setMenu_image(rs.getString("menu_image"));
					menu.setMenu_kcal(rs.getDouble("menu_kcal"));
					menu.setMenu_carbor(rs.getDouble("menu_carbor"));
					menu.setMenu_protein(rs.getDouble("menu_protein"));
					menu.setMenu_fat(rs.getDouble("menu_fat"));
					menu.setMenu_natrium(rs.getDouble("menu_natrium"));
					menu.setMenu_grade(rs.getString("menu_grade"));
					menu.setMenu_big_class(rs.getString("menu_big_class"));
					menu.setMenu_small_class(rs.getString("menu_small_class"));
					menu.setSupplier_num(rs.getInt("supplier_num"));
					menu.setSupplier_name(rs.getString("supplier_name"));
					menu.setMenu_cost(rs.getString("menu_cost"));
					menuList.add(menu);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return menuList;
   }
	
	/**
	 * 메뉴번호로 공급업체이름 조회
	 * @param menuNum
	 * @return
	 * @throws Exception
	 */
	public int getSupplierNumByMenuNum(int menuNum) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       int supplierNum = 0;
	       
	       try {
	           conn = getConnection();
	           
	           String sql = "SELECT supplier_num FROM menu WHERE menu_num = ?";
	           
	           pstmt = conn.prepareStatement(sql);
	           pstmt.setInt(1, menuNum);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	   supplierNum = rs.getInt(1);
	           } else {
	        	   supplierNum = 0;
	           }
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return supplierNum;
	}
	
	/**
	 * ¼ö·®°ú ¸Þ´º¹øÈ£¸¦ ¹Þ¾Æ ÁÖ¹®È½¼ö Áõ°¡ ½ÃÅ°±â
	 * @param order_amount
	 * @param menu_num
	 * @throws Exception
	 */
	public void updateOrderCount(String order_amount, int menu_num) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int amount = Integer.parseInt(order_amount);

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("SELECT * FROM menu WHERE menu_num = ?");
            pstmt.setInt(1, menu_num);
			rs = pstmt.executeQuery();
			if (rs.next()){
	            pstmt = conn.prepareStatement("UPDATE menu SET menu_order_count=? WHERE menu_num=?");
	            
	            int dbcount = Integer.parseInt(rs.getString("menu_order_count"));
	            dbcount += amount;
	            
	            pstmt.setInt(1, dbcount);
	            pstmt.setInt(2, menu_num);
				
	            pstmt.executeUpdate();
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
	
}
