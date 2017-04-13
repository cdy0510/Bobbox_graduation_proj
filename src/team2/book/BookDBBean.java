package team2.book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.cybermoney.CybermoneyDataBean;
import team2.menu_ordersheet.Menu_OrderSheetDataBean;
/**
 * 
 * @author 정다영
 *
 */
public class BookDBBean {
	private static BookDBBean instance = new BookDBBean();

	public static BookDBBean getInstance() {
		return instance;
	}

	private BookDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}
	
	/**
	 * 장부 등록
	 * @param book
	 * @throws Exception
	 */
	public void insertBook(BookDataBean book)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT MAX(book_num) FROM book");
			rs = pstmt.executeQuery();
						
			int number = 0;
			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "insert into book(book_num, book_date, menu_input_num, "
					+ "charge_num) values(?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, book.getBook_date());
			pstmt.setInt(3, book.getMenu_input_num());
			pstmt.setInt(4, book.getCharge_num());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) {}
			if (pstmt != null)
				try { pstmt.close(); } catch (SQLException ex) {}
			if (conn != null)
				try { conn.close(); } catch (SQLException ex) {}
		}
	}
	
	/**
	 * 장부 갯수 Count
	 * @return
	 * @throws Exception
	 */
	public int getBookCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("SELECT COUNT(*) FROM book");
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
	 * 날짜별 장부 목록조회
	 * @return
	 * @throws Exception
	 */
	public List<BookDataBean> getBookList()
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookDataBean> bookList = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT book_num, book_date, SUM(mo.menu_order_sum_price), SUM(c.charge_price)"
							+ " FROM book b, menu_input m, cybermoney c, menu_ordersheet mo"
							+ " WHERE b.menu_input_num = m.menu_input_num"
							+ " AND b.charge_num = c.charge_num"
							+ " AND m.menu_ordersheet_num = mo.menu_ordersheet_num"
							+ "  GROUP BY book_date DESC ORDER BY book_date DESC");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bookList = new ArrayList<BookDataBean>();
				do {
					BookDataBean book = new BookDataBean();
					book.setBook_num(rs.getInt("book_num"));
					book.setBook_date(rs.getString("book_date"));
					book.setSum_input(rs.getInt("SUM(mo.menu_order_sum_price)"));
					book.setSum_charge(rs.getInt("SUM(c.charge_price)"));
					bookList.add(book);
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
		return bookList;
	}

	/**
	 * 장부 상세 조회 by BookDate
	 * @param bookNum
	 * @return
	 * @throws Exception
	 */
	public List<BookDataBean> getBook(String bookDate) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<BookDataBean> bookList = null;
	       
	       try {
	           conn = getConnection();
	           pstmt = conn.prepareStatement(
	           	"SELECT book_num, book_date, mo.menu_order_sum_price, c.charge_price, mem.member_id, s.supplier_name "
	           	+ " FROM book b, menu_input m, cybermoney c, menu_ordersheet mo, member mem, supplier s, menu me, menu_order_detail d"
	           	+ " WHERE b.menu_input_num = m.menu_input_num"
	           	+ " AND b.charge_num = c.charge_num"
	           	+ " AND m.menu_ordersheet_num = mo.menu_ordersheet_num"
	           	+ " AND c.member_num = mem.member_num "
	           	+ " AND mo.menu_ordersheet_num = d.menu_ordersheet_num"
	           	+ " AND d.menu_num = me.menu_num"
	           	+ " AND me.supplier_num = s.supplier_num"
	           	+ " AND book_date = ?"
	           	+ " GROUP BY book_num DESC");
	           
	           pstmt.setString(1, bookDate);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	    bookList = new ArrayList<BookDataBean>();
	        	    do{
	        	    	BookDataBean book = new BookDataBean();
	        	    	book.setBook_num(rs.getInt("book_num"));
	            	   	book.setBook_date(rs.getString("book_date"));
	            	   	book.setInput_price(rs.getInt("mo.menu_order_sum_price"));
	            	   	book.setCharge_price(rs.getInt("c.charge_price"));
	            	   	book.setMember_id(rs.getString("mem.member_id"));
	            	   	book.setSupplier_name(rs.getString("s.supplier_name"));
	            	   	bookList.add(book);
	        	    } while (rs.next());
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
	       return bookList;
	}
}
