package team2.menu_ordersheet;

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
 * 메뉴 주문서 DBBean
 * @author 정다영
 *
 */
public class Menu_OrderSheetDBBean {
	
	private static Menu_OrderSheetDBBean instance = new Menu_OrderSheetDBBean();
	
	public static Menu_OrderSheetDBBean getInstance() {
        return instance;
    }
	
	private Menu_OrderSheetDBBean(){}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/2014a2");
        return ds.getConnection();
    }
	
	/**
	 * 메뉴 주문서 등록
	 * @param menuOrderSheet
	 * @throws Exception
	 */
	public void insertMenuOrderSheet(Menu_OrderSheetDataBean menuOrderSheet) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("SELECT MAX(menu_ordersheet_num) FROM menu_ordersheet");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 

            sql = "INSERT INTO menu_ordersheet(menu_ordersheet_num, menu_pay_date, menu_order_sum_price, ";
            sql += "menu_payment_option, menu_receipt_yes_no)";
		    sql +="VALUES (?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, number);
            pstmt.setTimestamp(2, menuOrderSheet.getMenu_pay_date());
            pstmt.setString(3, menuOrderSheet.getMenu_order_sum_price());
            pstmt.setString(4, menuOrderSheet.getMenu_payment_option());
            pstmt.setString(5, menuOrderSheet.getMenu_receipt_yes_no());
	
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
	 * 메뉴 주문서 count
	 * @return
	 * @throws Exception
	 */
	public int getMenuOrderSheetCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("SELECT COUNT(*) FROM menu_ordersheet");
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
	 * 메뉴 주문서 목록 조회 
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<Menu_OrderSheetDataBean> getMenuOrderSheetList()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<Menu_OrderSheetDataBean> menuOrderSheetList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"SELECT * FROM menu_ordersheet ORDER BY menu_ordersheet_num desc");
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   menuOrderSheetList = new ArrayList<Menu_OrderSheetDataBean>();
               do{
            	   	Menu_OrderSheetDataBean menuOrderSheet = new Menu_OrderSheetDataBean();
            	   	menuOrderSheet.setMenu_ordersheet_num(rs.getInt("menu_ordersheet_num"));
            	   	menuOrderSheet.setMenu_pay_date(rs.getTimestamp("menu_pay_date"));
            	   	menuOrderSheet.setMenu_order_sum_price(rs.getString("menu_order_sum_price"));
            	   	menuOrderSheet.setMenu_payment_option(rs.getString("menu_payment_option"));
            	   	menuOrderSheet.setMenu_receipt_yes_no(rs.getString("menu_receipt_yes_no"));
            	   	menuOrderSheetList.add(menuOrderSheet);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return menuOrderSheetList;
	}
	
	/**
	 * 메뉴주문서 삭제
	 * @param selected
	 * @return
	 * @throws Exception
	 */
	public int deleteMenuOrderSheet(String selected)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        int x=-1;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
				  "DELETE FROM menu_ordersheet WHERE menu_ordersheet_num IN("+selected+")");
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
	 * 메뉴주문서 단건조회 By menu_ordersheet_num
	 * @param menuOrderSheetNum
	 * @return
	 * @throws Exception
	 */
	public Menu_OrderSheetDataBean getMenuOrderSheet(int menuOrderSheetNum) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       Menu_OrderSheetDataBean menuOrderSheet = null;
	       
	       try {
	           conn = getConnection();
	           
	           pstmt = conn.prepareStatement(
	           	"SELECT * FROM menu_ordersheet WHERE menu_ordersheet_num = ?");
	           pstmt.setInt(1, menuOrderSheetNum);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	    menuOrderSheet = new Menu_OrderSheetDataBean();
            	   	menuOrderSheet.setMenu_ordersheet_num(rs.getInt("menu_ordersheet_num"));
            	   	menuOrderSheet.setMenu_pay_date(rs.getTimestamp("menu_pay_date"));
            	   	menuOrderSheet.setMenu_order_sum_price(rs.getString("menu_order_sum_price"));
            	   	menuOrderSheet.setMenu_payment_option(rs.getString("menu_payment_option"));
            	   	menuOrderSheet.setMenu_receipt_yes_no(rs.getString("menu_receipt_yes_no"));
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
	       return menuOrderSheet;
	}
	
	/**
	 * 메뉴주문서 수정 - only 수취여부
	 * @param menuOrderSheet
	 * @throws Exception
	 */
	public void updateMenuOrderSheet(String receipt, int menuOrderSheetNum) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
				
            String sql = "UPDATE menu_ordersheet SET menu_receipt_yes_no = ? WHERE menu_ordersheet_num=?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, receipt);
            pstmt.setInt(2, menuOrderSheetNum);
            pstmt.executeUpdate();
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
}
