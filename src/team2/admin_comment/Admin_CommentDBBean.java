package team2.admin_comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class Admin_CommentDBBean {
	
	private static Admin_CommentDBBean instance = new Admin_CommentDBBean();

	public static Admin_CommentDBBean getInstance() {
		return instance;
	}

	private Admin_CommentDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}

	
	
	/**
	 * 관리자 댓글 등록하기
	 * @param admin_comment
	 * @throws Exception
	 */
	public void insertAdmin_Comment(Admin_CommentDataBean admin_comment)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number = 0;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT MAX(admin_comment_num) FROM admin_comment");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "insert into admin_comment(admin_comment_num, QandA_board_num, admin_comment_content, admin_comment_date) values (?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, number);
			pstmt.setInt(2, admin_comment.getQandA_board_num());
			pstmt.setString(3, admin_comment.getAdmin_comment_content());
			pstmt.setTimestamp(4, admin_comment.getAdmin_comment_date());
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
	 * 관리자 댓글 수 가져오기
	 * @return
	 * @throws Exception
	 */
	public int getAdmin_CommentCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from admin_comment");
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

	
	
	public List<Admin_CommentDataBean> getAdmin_Comments(int QandA_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Admin_CommentDataBean> admin_commentList = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT admin_comment_num, admin_comment_content, admin_comment_date, a.QandA_board_num FROM admin_comment a, QandA_board q WHERE a.QandA_board_num=q.QandA_board_num AND a.QandA_board_num=?");
			pstmt.setInt(1, QandA_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				admin_commentList = new ArrayList<Admin_CommentDataBean>();
				do {
					Admin_CommentDataBean admin_comment = new Admin_CommentDataBean();
					admin_comment.setAdmin_comment_num(rs
							.getInt("admin_comment_num"));
					admin_comment.setAdmin_comment_content(rs
							.getString("admin_comment_content"));
					admin_comment.setAdmin_comment_date(rs
							.getTimestamp("admin_comment_date"));
					admin_comment.setQandA_board_num(rs
							.getInt("QandA_board_num"));
					
					admin_commentList.add(admin_comment);
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
		return admin_commentList;
	}

	
	
	
	
	public Admin_CommentDataBean getAdmin_Comment(int admin_comment_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Admin_CommentDataBean admin_comment = null;
		try {
			conn = getConnection();

			
			pstmt = conn.prepareStatement(
	            	"select * from admin_comment where admin_comment_num = ?");
			pstmt.setInt(1, admin_comment_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				admin_comment = new Admin_CommentDataBean();
				admin_comment.setAdmin_comment_num(rs
						.getInt("admin_comment_num"));
				admin_comment.setAdmin_comment_content(rs
						.getString("admin_comment_content"));
				admin_comment.setAdmin_comment_date(rs
						.getTimestamp("admin_comment_date"));
				admin_comment.setQandA_board_num(rs
						.getInt("QandA_board_num"));
				
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
		return admin_comment;
	}
	
	
	public int getAdmin_CommentCount2(int QandA_board_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int admin_comment_num = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(admin_comment_num) from admin_comment where QandA_board_num = ?");
			pstmt.setInt(1, QandA_board_num);
			rs = pstmt.executeQuery();
			if (rs.next())
				admin_comment_num = rs.getInt(1);
			else
				admin_comment_num = 0;
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
		return admin_comment_num;
	}
	

//	/**
//	 * 후기 게시글 수정하는 폼 조회하기
//	 * 
//	 * @param admin_board_num
//	 * @return
//	 * @throws Exception
//	 */
//	public Review_BoardDataBean updateGetReview_Board(int review_board_num)
//			throws Exception {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		Review_BoardDataBean review_board = null;
//		try {
//			conn = getConnection();
//
//			pstmt = conn
//					.prepareStatement("select * from review_board where review_board_num = ?");
//			pstmt.setInt(1, review_board_num);
//			rs = pstmt.executeQuery();
//
//			if (rs.next()) {
//				review_board = new Review_BoardDataBean();
//				review_board.setReview_board_num(rs.getInt("review_board_num"));
//				review_board.setReview_board_title(rs
//						.getString("review_board_title"));
//				review_board.setReview_board_content(rs
//						.getString("admin_board_content"));
//				review_board.setReview_board_passwd(rs
//						.getInt("review_board_passwd"));
//				review_board.setReview_board_date(rs
//						.getTimestamp("review_board_date"));
//				review_board.setReview_board_count(rs
//						.getInt("review_board_count"));
//				review_board.setLike_yes_no(rs.getInt("like_yes_no"));
//				review_board.setMember_num(rs.getInt("member_num"));
//				review_board.setMember_id(rs.getString("member_id"));
//				review_board.setRe_group_num(rs.getInt("re_group_num"));
//				review_board.setRe_step(rs.getInt("re_step"));
//				review_board.setRe_level(rs.getInt("re_level"));
//			}
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			if (rs != null)
//				try {
//					rs.close();
//				} catch (SQLException ex) {
//				}
//			if (pstmt != null)
//				try {
//					pstmt.close();
//				} catch (SQLException ex) {
//				}
//			if (conn != null)
//				try {
//					conn.close();
//				} catch (SQLException ex) {
//				}
//		}
//		return review_board;
//	}
//
//	/**
//	 * 후기 게시글 수정하기
//	 * 
//	 * @param admin_board
//	 * @return
//	 * @throws Exception
//	 */
//	public int updateReview_Board(Review_BoardDataBean review_board)
//			throws Exception {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		int dbpasswd = 0;
//		String sql = "";
//		int x = -1;
//		try {
//			conn = getConnection();
//
//			pstmt = conn
//					.prepareStatement("select review_board_passwd from review_board where review_board_num = ?");
//			pstmt.setInt(1, review_board.getReview_board_num());
//			rs = pstmt.executeQuery();
//
//			if (rs.next()) {
//				dbpasswd = rs.getInt("review_board_passwd");
//				if (dbpasswd == review_board.getReview_board_passwd()) {
//					sql = "update review_board set review_board_title=?, review_board_content=? where review_board_num=?";
//					pstmt = conn.prepareStatement(sql);
//
//					pstmt.setString(1, review_board.getReview_board_title());
//					pstmt.setString(2, review_board.getReview_board_content());
//					pstmt.setInt(3, review_board.getReview_board_num());
//					pstmt.executeUpdate();
//					x = 1;
//				} else {
//					x = 0;
//				}
//			}
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			if (rs != null)
//				try {
//					rs.close();
//				} catch (SQLException ex) {
//				}
//			if (pstmt != null)
//				try {
//					pstmt.close();
//				} catch (SQLException ex) {
//				}
//			if (conn != null)
//				try {
//					conn.close();
//				} catch (SQLException ex) {
//				}
//		}
//		return x;
//	}
//
	
	public void deleteAdmin_Comment(int admin_comment_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from admin_comment where admin_comment_num = ?";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, admin_comment_num);
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
	
	


