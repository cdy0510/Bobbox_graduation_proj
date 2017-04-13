package team2.admin_board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.member.MemberDBBean;
import team2.member.MemberDataBean;

public class Admin_BoardDBBean {

	private static Admin_BoardDBBean instance = new Admin_BoardDBBean();

	public static Admin_BoardDBBean getInstance() {
		return instance;
	}

	private Admin_BoardDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}

	/**
	 * 관리자 게시글 등록하기
	 * 
	 * @param member
	 * @throws Exception
	 */
	public void insertAdmin_Board(Admin_BoardDataBean admin_board)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number = 0;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT MAX(admin_board_num) FROM admin_board");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "INSERT INTO admin_board(admin_board_num, admin_board_type, admin_board_title,";
			sql += "admin_board_content, admin_board_date, admin_board_count) values(?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, admin_board.getAdmin_board_type());
			pstmt.setString(3, admin_board.getAdmin_board_title());
			pstmt.setString(4, admin_board.getAdmin_board_content());
			pstmt.setTimestamp(5, admin_board.getAdmin_board_date());
			pstmt.setInt(6, admin_board.getAdmin_board_count());

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
	 * 관리자게시판 전체글 수 얻어오기
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getAdmin_BoardCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from admin_board");
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
	 * 관리자게시판 목록 조회하기
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<Admin_BoardDataBean> getAdmin_Boards(int start, int end)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Admin_BoardDataBean> admin_boardList = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from admin_board order by admin_board_num desc");
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				admin_boardList = new ArrayList<Admin_BoardDataBean>();
				do {
					Admin_BoardDataBean admin_board = new Admin_BoardDataBean();
					admin_board
							.setAdmin_board_num(rs.getInt("admin_board_num"));
					admin_board.setAdmin_board_type(rs
							.getString("admin_board_type"));
					admin_board.setAdmin_board_title(rs
							.getString("admin_board_title"));
					admin_board.setAdmin_board_content(rs
							.getString("admin_board_content"));
					admin_board.setAdmin_board_date(rs
							.getTimestamp("admin_board_date"));
					admin_board.setAdmin_board_count(rs
							.getInt("admin_board_count"));

					admin_boardList.add(admin_board);
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
		return admin_boardList;
	}

	/**
	 * 관리자 게시글 단건 조회하기
	 * 
	 * @param num
	 * @return
	 * @throws Exception
	 */
	public Admin_BoardDataBean getAdmin_Board(int admin_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Admin_BoardDataBean admin_board = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("update admin_board set admin_board_count=admin_board_count+1 where admin_board_num = ?");
			pstmt.setInt(1, admin_board_num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select * from admin_board where admin_board_num = ?");
			pstmt.setInt(1, admin_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				admin_board = new Admin_BoardDataBean();
				admin_board.setAdmin_board_num(rs.getInt("admin_board_num"));
				admin_board.setAdmin_board_type(rs
						.getString("admin_board_type"));
				admin_board.setAdmin_board_title(rs
						.getString("admin_board_title"));
				admin_board.setAdmin_board_content(rs
						.getString("admin_board_content"));
				admin_board.setAdmin_board_date(rs
						.getTimestamp("admin_board_date"));
				admin_board
						.setAdmin_board_count(rs.getInt("admin_board_count"));
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
		return admin_board;
	}

	/**
	 * 관리자 게시글 수정하는 폼 조회하기
	 * 
	 * @param admin_board_num
	 * @return
	 * @throws Exception
	 */
	public Admin_BoardDataBean updateGetAdmin_Board(int admin_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Admin_BoardDataBean admin_board = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select * from admin_board where admin_board_num = ?");
			pstmt.setInt(1, admin_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				admin_board = new Admin_BoardDataBean();
				admin_board.setAdmin_board_num(rs.getInt("admin_board_num"));
				admin_board.setAdmin_board_type(rs
						.getString("admin_board_type"));
				admin_board.setAdmin_board_title(rs
						.getString("admin_board_title"));
				admin_board.setAdmin_board_content(rs
						.getString("admin_board_content"));
				admin_board.setAdmin_board_date(rs
						.getTimestamp("admin_board_date"));
				admin_board
						.setAdmin_board_count(rs.getInt("admin_board_count"));
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
		return admin_board;
	}

	/**
	 * 관리자 게시글 수정하기
	 * 
	 * @param admin_board
	 * @return
	 * @throws Exception
	 */
	public int updateAdmin_Board(Admin_BoardDataBean admin_board, int admin_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x=-1;
		try {

			 conn = getConnection();

	            pstmt = conn.prepareStatement("select * from admin_board where admin_board_num = ?");
	            pstmt.setInt(1, admin_board_num);
				rs = pstmt.executeQuery();

			if (rs.next()){	
				
			String sql = "update admin_board set admin_board_type=?, admin_board_title=?, admin_board_content=? where admin_board_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, admin_board.getAdmin_board_type());
			pstmt.setString(2, admin_board.getAdmin_board_title());
			pstmt.setString(3, admin_board.getAdmin_board_content());
			pstmt.setInt(4, admin_board.getAdmin_board_num());
			pstmt.executeUpdate();
			
			x=1;
			 }else{
					x= 0;
				  
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {

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
	 * 관리자 게시글 삭제하기
	 * @param admin_board_num
	 * @throws Exception
	 */
	public void deleteAdmin_Board(int admin_board_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from admin_board where admin_board_num = ?";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, admin_board_num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {

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
}
