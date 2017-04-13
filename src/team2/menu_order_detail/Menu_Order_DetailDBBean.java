package team2.menu_order_detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


/**
 * @author JooYoung
 *
 */
public class Menu_Order_DetailDBBean {
	
	private static Menu_Order_DetailDBBean instance = new Menu_Order_DetailDBBean();

	public static Menu_Order_DetailDBBean getInstance() {
		return instance;
	}

	private Menu_Order_DetailDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}

	
	/**
	 * 메뉴주문상세 등록하기
	 * @param menu_order_detail
	 * @throws Exception
	 */
	public void insertMenu_Order_Detail(Menu_Order_DetailDataBean menu_order_detail)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number = 0;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT MAX(menu_order_detail_num) FROM menu_order_detail");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			
			sql = "INSERT INTO menu_order_detail(menu_order_detail_num, menu_quantity, menu_sum_price,";
			sql += "menu_num, menu_ordersheet_num) values(?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, menu_order_detail.getMenu_quantity());
			pstmt.setString(3, menu_order_detail.getMenu_sum_price());
			pstmt.setInt(4, menu_order_detail.getMenu_num());
			pstmt.setInt(5, menu_order_detail.getMenu_ordersheet_num());
			
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
	 * 메뉴주문상세 갯수 조회하기
	 * @return
	 * @throws Exception
	 */
	public int getMenu_Order_DetailCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("SELECT COUNT(*) FROM menu_order_detail");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}
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
		return x;
	}
	
	/**
	 * 메뉴주문상세 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Menu_Order_DetailDataBean> getMenu_Order_Details()
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Menu_Order_DetailDataBean> menu_order_detailList = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT menu_order_detail_num, menu_quantity, menu_sum_price, d.menu_num,"
							+ "	 d.menu_ordersheet_num, menu_name"
							+ " FROM menu_order_detail d, menu m, menu_ordersheet mo"
							+ " WHERE d.menu_num = m.menu_num"
							+ " AND d.menu_ordersheet_num = mo.menu_ordersheet_num");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				menu_order_detailList = new ArrayList<Menu_Order_DetailDataBean>();
				do {
					Menu_Order_DetailDataBean menu_order_detail = new Menu_Order_DetailDataBean();
					menu_order_detail.setMenu_order_detail_num(rs
							.getInt("menu_order_detail_num"));
					menu_order_detail.setMenu_quantity(rs
							.getString("menu_quantity"));
					menu_order_detail.setMenu_sum_price(rs
							.getString("menu_sum_price"));
					menu_order_detail.setMenu_num(rs
							.getInt("menu_num"));
					menu_order_detail.setMenu_ordersheet_num(rs
							.getInt("menu_ordersheet_num"));
					menu_order_detail.setMenu_name(rs
							.getString("menu_name"));
					
					menu_order_detailList.add(menu_order_detail);
				} while (rs.next());
			}
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
		return menu_order_detailList;
	}
	

	
	/**
	 * 메뉴주문상세 단건 조회하기
	 * @param menu_order_detail_num
	 * @return
	 * @throws Exception
	 */
	public Menu_Order_DetailDataBean getMenu_Order_Detail(int menu_order_detail_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Menu_Order_DetailDataBean menu_order_detail = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select * from menu_order_detail where menu_order_detail_num = ?");
			pstmt.setInt(1, menu_order_detail_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				menu_order_detail = new Menu_Order_DetailDataBean();
				menu_order_detail.setMenu_order_detail_num(rs
						.getInt("menu_order_detail_num"));
				menu_order_detail.setMenu_quantity(rs
						.getString("menu_quantity"));
				menu_order_detail.setMenu_sum_price(rs
						.getString("menu_sum_price"));
				menu_order_detail.setMenu_num(rs
						.getInt("menu_num"));
				menu_order_detail.setMenu_ordersheet_num(rs
						.getInt("menu_ordersheet_num"));
				menu_order_detail.setMenu_name(rs
						.getString("menu_name"));

			}
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
		return menu_order_detail;
	}
	
	/**
	 * 메뉴주문상세 조회 BY orderSheetNum
	 * @param menuOrderSheetNum
	 * @return
	 * @throws Exception
	 */
	public List<Menu_Order_DetailDataBean> getMenu_Order_DetailByOrderSheet(int menuOrderSheetNum)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Menu_Order_DetailDataBean> menu_order_detailList = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT menu_order_detail_num, menu_quantity, menu_sum_price, d.menu_num,"
							+ "	 d.menu_ordersheet_num, menu_name"
							+ " FROM menu_order_detail d, menu m, menu_ordersheet mo"
							+ " WHERE d.menu_num = m.menu_num"
							+ " AND d.menu_ordersheet_num = mo.menu_ordersheet_num"
							+ " AND d.menu_ordersheet_num = ?");
			pstmt.setInt(1, menuOrderSheetNum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				menu_order_detailList = new ArrayList<Menu_Order_DetailDataBean>();
				do {
					Menu_Order_DetailDataBean menu_order_detail = new Menu_Order_DetailDataBean();
					menu_order_detail.setMenu_order_detail_num(rs
							.getInt("menu_order_detail_num"));
					menu_order_detail.setMenu_quantity(rs
							.getString("menu_quantity"));
					menu_order_detail.setMenu_sum_price(rs
							.getString("menu_sum_price"));
					menu_order_detail.setMenu_num(rs
							.getInt("menu_num"));
					menu_order_detail.setMenu_ordersheet_num(rs
							.getInt("menu_ordersheet_num"));
					menu_order_detail.setMenu_name(rs
							.getString("menu_name"));
					
					menu_order_detailList.add(menu_order_detail);
				} while (rs.next());
			}
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
		return menu_order_detailList;
	}
	/**
	 * 메뉴번호 조회 BY 메뉴주문서번호
	 * @param menuOrderSheetNum
	 * @return
	 * @throws Exception
	 */
	public int getMenuNumByMenuOrderSheetNum(int menuOrderSheetNum) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       int menuNum = 0;
	       
	       try {
	           conn = getConnection();
	           
	           pstmt = conn.prepareStatement(
	           	"SELECT menu_num FROM menu_order_detail WHERE menu_ordersheet_num = ?");
	           pstmt.setInt(1, menuOrderSheetNum);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	   menuNum = rs.getInt(1);
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
	       return menuNum;
	}
	
	/**
	 * 메뉴주문서 날짜 조회 by 메뉴주문서Num
	 * @param menuOrderSheetNum
	 * @return
	 * @throws Exception
	 */
	public Timestamp getMenuPayDateByMenuOrderSheetNum(int menuOrderSheetNum) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       Timestamp payDate = null;
	       
	       try {
	           conn = getConnection();
	           
	           pstmt = conn.prepareStatement(
	           	"SELECT m.menu_pay_date FROM menu_ordersheet m, menu_order_detail d"
	           	+ " WHERE m.menu_ordersheet_num = d.menu_ordersheet_num"
	           	+ " AND d.menu_ordersheet_num = ? GROUP BY m.menu_ordersheet_num");
	           pstmt.setInt(1, menuOrderSheetNum);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	   payDate = rs.getTimestamp(1);
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
	       return payDate;
	}
}
