package team2.menu_input;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
/**
 * 
 * @author 정다영
 *
 */
public class Menu_InputDBBean {
	
	private static Menu_InputDBBean instance = new Menu_InputDBBean();

	public static Menu_InputDBBean getInstance() {
		return instance;
	}

	private Menu_InputDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}
	
	/**
	 * 메뉴 입고 등록
	 * @param menuInput
	 * @throws Exception
	 */
	public void insertMenuInput(Menu_InputDataBean menuInput)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number = 0;
		String sql = "";
		try {
			conn = getConnection();
			pstmt = conn
					.prepareStatement("SELECT MAX(menu_input_num) FROM menu_input");
			rs = pstmt.executeQuery();
			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "INSERT INTO menu_input(menu_input_num, menu_ordersheet_num, menu_input_date)";
			sql += "VALUES(?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setInt(2, menuInput.getMenu_ordersheet_num());
			pstmt.setTimestamp(3, menuInput.getMenu_input_date());
			
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}
	/**
	 * 메뉴입고 갯수 count
	 * @return
	 * @throws Exception
	 */
	public int getMenuInputCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("SELECT COUNT(*) FROM menu_input");
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
}
