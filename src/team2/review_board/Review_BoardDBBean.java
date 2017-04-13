package team2.review_board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.member.MemberDataBean;

public class Review_BoardDBBean {

	private static Review_BoardDBBean instance = new Review_BoardDBBean();

	public static Review_BoardDBBean getInstance() {
		return instance;
	}

	private Review_BoardDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}

	
	
	/**
	 * 후기 게시글 등록하기
	 * 
	 * @param member
	 * @throws Exception
	 */
	@SuppressWarnings("resource")
	public void insertReview_Board(Review_BoardDataBean review_board)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;


		int review_board_num = review_board.getReview_board_num();
		int re_group_num = review_board.getRe_group_num();
		int re_step = review_board.getRe_step();
		int re_level = review_board.getRe_level();
		int number = 0;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT MAX(review_board_num) FROM review_board");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			if (review_board_num != 0) {
				sql = "update review_board set re_step=re_step+1 ";
				sql += "where re_group_num= ? and re_step> ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, re_group_num);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			} else {
				re_group_num = number;
				re_step = 0;
				re_level = 0;
			}
			sql = "insert into review_board(review_board_num, review_board_title, review_board_content,";
			sql += "review_board_passwd, review_board_date, review_board_count, re_group_num,"
					+ "re_step, re_level, like_yes_no, member_num) values (?,?,?,?,?,?,?,?,?,?,?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, number);
			pstmt.setString(2, review_board.getReview_board_title());
			pstmt.setString(3, review_board.getReview_board_content());
			pstmt.setInt(4, review_board.getReview_board_passwd());
			pstmt.setTimestamp(5, review_board.getReview_board_date());
			pstmt.setInt(6, review_board.getReview_board_count());
			pstmt.setInt(7, review_board.getRe_group_num());
			pstmt.setInt(8, review_board.getRe_step());
			pstmt.setInt(9, review_board.getRe_level());
			pstmt.setInt(10, review_board.getLike_yes_no());
			pstmt.setInt(11, review_board.getMember_num());
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
	 * 후기게시판 전체글 수 얻어오기
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getReview_BoardCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from review_board");
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
	 * 후기게시판 목록 조회하기
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<Review_BoardDataBean> getReview_Boards(int start, int end)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Review_BoardDataBean> review_boardList = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT review_board_num, review_board_title, review_board_content, review_board_passwd, "
							+ "review_board_date, review_board_count, like_yes_no, r.member_num, member_id, re_group_num, re_step, "
							+ "re_level FROM review_board r, member m WHERE r.member_num=m.member_num order by review_board_num desc, re_step asc limit ?,? ");
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				review_boardList = new ArrayList<Review_BoardDataBean>(end);
				do {
					Review_BoardDataBean review_board = new Review_BoardDataBean();
					review_board.setReview_board_num(rs
							.getInt("review_board_num"));
					review_board.setReview_board_title(rs
							.getString("review_board_title"));
					review_board.setReview_board_content(rs
							.getString("review_board_content"));
					review_board.setReview_board_passwd(rs.getInt("review_board_passwd"));
					review_board.setReview_board_date(rs
							.getTimestamp("review_board_date"));
					review_board.setReview_board_count(rs
							.getInt("review_board_count"));
					review_board.setLike_yes_no(rs.getInt("like_yes_no"));
					review_board.setMember_num(rs.getInt("member_num"));
					review_board.setMember_id(rs.getString("member_id"));
					review_board.setRe_group_num(rs.getInt("re_group_num"));
					review_board.setRe_step(rs.getInt("re_step"));
					review_board.setRe_level(rs.getInt("re_level"));

					review_boardList.add(review_board);
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
		return review_boardList;
	}

	
	
	/**
	 * 후기 게시글 단건 조회하기
	 * 
	 * @param num
	 * @return
	 * @throws Exception
	 */
	public Review_BoardDataBean getReview_Board(int review_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Review_BoardDataBean review_board = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("update review_board set review_board_count=review_board_count+1 where review_board_num = ?");
			pstmt.setInt(1, review_board_num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement(
	            	"SELECT review_board_num, review_board_title, review_board_content, review_board_passwd, "
							+ "review_board_date, review_board_count, like_yes_no, r.member_num, member_id, re_group_num, re_step, "
							+ "re_level from review_board r, member m where r.member_num=m.member_num and review_board_num = ?");
			pstmt.setInt(1, review_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				review_board = new Review_BoardDataBean();
				review_board.setReview_board_num(rs
						.getInt("review_board_num"));
				review_board.setReview_board_title(rs
						.getString("review_board_title"));
				review_board.setReview_board_content(rs
						.getString("review_board_content"));
				review_board.setReview_board_passwd(rs.getInt("review_board_passwd"));
				review_board.setReview_board_date(rs
						.getTimestamp("review_board_date"));
				review_board.setReview_board_count(rs
						.getInt("review_board_count"));
				review_board.setLike_yes_no(rs
						.getInt("like_yes_no"));
				review_board.setMember_num(rs
						.getInt("member_num"));
				review_board.setMember_id(rs
						.getString("member_id"));
				review_board.setRe_group_num(rs
						.getInt("re_group_num"));
				review_board.setRe_step(rs
						.getInt("re_step"));
				review_board.setRe_level(rs
						.getInt("re_level"));
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
		return review_board;
	}

	/**
	 * 후기 게시글 수정하는 폼 조회하기
	 * 
	 * @param admin_board_num
	 * @return
	 * @throws Exception
	 */
	public Review_BoardDataBean updateGetReview_Board(int review_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Review_BoardDataBean review_board = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(
	            	"SELECT review_board_num, review_board_title, review_board_content, review_board_passwd, review_board_date, review_board_count, like_yes_no, r.member_num, member_id, re_group_num, re_step, re_level from review_board r, member m where r.member_num=m.member_num and review_board_num = ?");
			pstmt.setInt(1, review_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				review_board = new Review_BoardDataBean();
				review_board.setReview_board_num(rs.getInt("review_board_num"));
				review_board.setReview_board_title(rs
						.getString("review_board_title"));
				review_board.setReview_board_content(rs
						.getString("review_board_content"));
				review_board.setReview_board_passwd(rs.getInt("review_board_passwd"));
				review_board.setReview_board_date(rs
						.getTimestamp("review_board_date"));
				review_board.setReview_board_count(rs
						.getInt("review_board_count"));
				review_board.setLike_yes_no(rs.getInt("like_yes_no"));
				review_board.setMember_num(rs.getInt("member_num"));
				review_board.setMember_id(rs.getString("member_id"));
				review_board.setRe_group_num(rs.getInt("re_group_num"));
				review_board.setRe_step(rs.getInt("re_step"));
				review_board.setRe_level(rs.getInt("re_level"));
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
		return review_board;
	}

	/**
	 * 후기 게시글 수정하기
	 * 
	 * @param admin_board
	 * @return
	 * @throws Exception
	 */
	public int updateReview_Board(Review_BoardDataBean review_board)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int dbpasswd = 0;
		String sql = "";
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select review_board_passwd from review_board where review_board_num = ?");
			pstmt.setInt(1, review_board.getReview_board_num());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getInt("review_board_passwd");
				if (dbpasswd == review_board.getReview_board_passwd()) {
					sql = "update review_board set review_board_title=?, review_board_content=? where review_board_num=?";
					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, review_board.getReview_board_title());
					pstmt.setString(2, review_board.getReview_board_content());
					pstmt.setInt(3, review_board.getReview_board_num());
					pstmt.executeUpdate();
					x = 1;
				} else {
					x = 0;
				}
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
	 * 후기 게시글 삭제하기
	 * 
	 * @param admin_board_num
	 * @return 
	 * @throws Exception
	 */
	public int deleteReview_Board(Review_BoardDataBean review_board)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int dbpasswd = 0;
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select review_board_passwd from review_board where review_board_num = ?");
			pstmt.setInt(1, review_board.getReview_board_num());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getInt("review_board_passwd");
				if (dbpasswd == review_board.getReview_board_passwd()) {
					pstmt = conn.prepareStatement("delete from review_board where review_board_num=?");
					pstmt.setInt(1, review_board.getReview_board_num());
					pstmt.executeUpdate();
					x = 1; 
				} else
					x = 0; 
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

	
	public int deleteReview_Board2(String selected)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        int x=-1;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement("DELETE FROM review_board WHERE review_board_num IN("+selected+")");
				pstmt.executeUpdate();
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
	  }	
	
	
	
	
	public void deleteReview_Board2(int review_board_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from review_board where review_board_num = ?";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review_board_num);
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