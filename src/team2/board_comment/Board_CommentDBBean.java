package team2.board_comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.review_board.Review_BoardDBBean;
import team2.review_board.Review_BoardDataBean;

public class Board_CommentDBBean {
	
	private static Board_CommentDBBean instance = new Board_CommentDBBean();

	public static Board_CommentDBBean getInstance() {
		return instance;
	}

	private Board_CommentDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}

	
	
	
	/**
	 * 게시판 댓글 등록하기
	 * @param board_comment
	 * @throws Exception
	 */
	public void insertBoard_Comment(Board_CommentDataBean board_comment)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number = 0;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT MAX(board_comment_num) FROM board_comment");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "insert into board_comment(board_comment_num, review_board_num, member_num,";
			sql += "board_comment_content, board_comment_date) values (?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, number);
			pstmt.setInt(2, board_comment.getReview_board_num());
			pstmt.setInt(3, board_comment.getMember_num());
			pstmt.setString(4, board_comment.getBoard_comment_content());
			pstmt.setTimestamp(5, board_comment.getBoard_comment_date());
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
	 * 게시판 댓글 수 가져오기
	 * @return
	 * @throws Exception
	 */
	public int getBoard_CommentCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from board_comment");
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
	 * 게시판 댓글 리스트 출력하기
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<Board_CommentDataBean> getBoard_Comments(int review_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Board_CommentDataBean> board_commentList = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT board_comment_num, board_comment_content, board_comment_date, b.member_num, member_id, b.review_board_num FROM board_comment b, member m, review_board r WHERE b.member_num=m.member_num AND b.review_board_num=r.review_board_num AND b.review_board_num=?");
			pstmt.setInt(1, review_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board_commentList = new ArrayList<Board_CommentDataBean>();
				do {
					Board_CommentDataBean board_comment = new Board_CommentDataBean();
					board_comment.setBoard_comment_num(rs
							.getInt("board_comment_num"));
					board_comment.setBoard_comment_content(rs
							.getString("board_comment_content"));
					board_comment.setBoard_comment_date(rs
							.getTimestamp("board_comment_date"));
					board_comment.setMember_num(rs
							.getInt("member_num"));
					board_comment.setReview_board_num(rs
							.getInt("review_board_num"));
					board_comment.setMember_id(rs.getString("member_id"));
					
					board_commentList.add(board_comment);
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
		return board_commentList;
	}

	
	
	public Board_CommentDataBean getBoard_Comment(int board_comment_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Board_CommentDataBean board_comment = null;
		try {
			conn = getConnection();

			
			pstmt = conn.prepareStatement(
	            	"select * from board_comment where board_comment_num = ?");
			pstmt.setInt(1, board_comment_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board_comment = new Board_CommentDataBean();
				board_comment.setBoard_comment_num(rs
						.getInt("board_comment_num"));
				board_comment.setBoard_comment_content(rs
						.getString("board_comment_content"));
				board_comment.setBoard_comment_date(rs
						.getTimestamp("board_comment_date"));
				board_comment.setMember_num(rs
						.getInt("member_num"));
				board_comment.setReview_board_num(rs
						.getInt("review_board_num"));
				board_comment.setMember_id(rs
						.getString("member_id"));
				
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
		return board_comment;
	}

	
	public int getBoard_CommentCount2(int review_board_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int board_comment_num = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(board_comment_num) from board_comment where review_board_num = ?");
			pstmt.setInt(1, review_board_num);
			rs = pstmt.executeQuery();
			if (rs.next())
				board_comment_num = rs.getInt(1);
			else
				board_comment_num = 0;
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
		return board_comment_num;
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
	/**
	 * 댓글 삭제하기
	 * 
	 * @param admin_board_num
	 * @return 
	 * @throws Exception
	 */
	public int deleteBoard_Comment(Board_CommentDataBean board_comment, int board_comment_num, int member_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int memberNum=0;
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select member_num from board_comment where board_comment_num = ?");
			pstmt.setInt(1, board_comment_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				memberNum = rs.getInt("member_num");
				if (memberNum == board_comment.getMember_num()) {
		
					pstmt = conn
							.prepareStatement("delete from board_comment where board_comment_num=?");
					pstmt.setInt(1, board_comment_num);
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
	
	

}
