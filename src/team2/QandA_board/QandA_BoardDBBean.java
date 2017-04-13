package team2.QandA_board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.admin_board.Admin_BoardDataBean;
import team2.review_board.Review_BoardDBBean;
import team2.review_board.Review_BoardDataBean;

public class QandA_BoardDBBean {
	
	private static QandA_BoardDBBean instance = new QandA_BoardDBBean();

	public static QandA_BoardDBBean getInstance() {
		return instance;
	}

	private QandA_BoardDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}


	@SuppressWarnings("resource")
	public void insertQandA_Board(QandA_BoardDataBean QandA_board)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number = 0;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT MAX(QandA_board_num) FROM QandA_board");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "INSERT INTO QandA_board(QandA_board_num, QandA_board_title, QandA_board_content,";
			sql += "QandA_board_passwd, QandA_board_date, QandA_board_count, member_num) values(?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, QandA_board.getQandA_board_title());
			pstmt.setString(3, QandA_board.getQandA_board_content());
			pstmt.setInt(4, QandA_board.getQandA_board_passwd());
			pstmt.setTimestamp(5, QandA_board.getQandA_board_date());
			pstmt.setInt(6, QandA_board.getQandA_board_count());
			pstmt.setInt(7, QandA_board.getMember_num());

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
	public int getQandA_BoardCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from QandA_board");
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
	 * Q&A게시판 리스트 가져오기
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<QandA_BoardDataBean> getQandA_Boards(int start, int end)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QandA_BoardDataBean> QandA_boardList = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT QandA_board_num, QandA_board_title, QandA_board_content, QandA_board_passwd, "
							+ "QandA_board_date, QandA_board_count, member_id, q.member_num FROM QandA_board q, member m where q.member_num=m.member_num order by QandA_board_num desc");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				QandA_boardList = new ArrayList<QandA_BoardDataBean>();
				do {
					QandA_BoardDataBean QandA_board = new QandA_BoardDataBean();
					QandA_board.setQandA_board_num(rs
							.getInt("QandA_board_num"));
					QandA_board.setQandA_board_title(rs
							.getString("QandA_board_title"));
					QandA_board.setQandA_board_content(rs
							.getString("QandA_board_content"));
					QandA_board.setQandA_board_passwd(rs
							.getInt("QandA_board_passwd"));
					QandA_board.setQandA_board_date(rs
							.getTimestamp("QandA_board_date"));
					QandA_board.setQandA_board_count(rs
							.getInt("QandA_board_count"));
					QandA_board.setMember_num(rs
							.getInt("member_num"));
					QandA_board.setMember_id(rs
							.getString("member_id"));
					QandA_boardList.add(QandA_board);
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
		return QandA_boardList;
	}


	
	/**
	 * Q&A게시판 단건 조회하기
	 * @param QandA_board_num
	 * @return
	 * @throws Exception
	 */
	public QandA_BoardDataBean getQandA_Board(int QandA_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QandA_BoardDataBean QandA_board = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("update QandA_board set QandA_board_count=QandA_board_count+1 where QandA_board_num = ?");
			pstmt.setInt(1, QandA_board_num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select QandA_board_num, QandA_board_title, QandA_board_content, QandA_board_passwd, "
					+ "QandA_board_date, QandA_board_count, q.member_num, member_id from QandA_board q, member m "
					+ "where q.member_num=m.member_num and QandA_board_num = ?");
			pstmt.setInt(1, QandA_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				QandA_board = new QandA_BoardDataBean();
				QandA_board.setQandA_board_num(rs
						.getInt("QandA_board_num"));
				QandA_board.setQandA_board_title(rs
						.getString("QandA_board_title"));
				QandA_board.setQandA_board_content(rs
						.getString("QandA_board_content"));
				QandA_board.setQandA_board_passwd(rs
						.getInt("QandA_board_passwd"));
				QandA_board.setQandA_board_date(rs
						.getTimestamp("QandA_board_date"));
				QandA_board.setQandA_board_count(rs
						.getInt("QandA_board_count"));
				QandA_board.setMember_num(rs
						.getInt("member_num"));
				QandA_board.setMember_id(rs
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
		return QandA_board;
	}


	
	
	/**
	 * 
	 * @param QandA_board_num
	 * @return
	 * @throws Exception
	 */
	public QandA_BoardDataBean updateGetQandA_Board(int QandA_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QandA_BoardDataBean QandA_board = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select QandA_board_num, QandA_board_title, QandA_board_content, QandA_board_passwd, "
					+ "QandA_board_date, QandA_board_count, q.member_num, member_id from QandA_board q, member m "
					+ "where q.member_num=m.member_num and QandA_board_num = ?");
			pstmt.setInt(1, QandA_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				QandA_board = new QandA_BoardDataBean();
				QandA_board.setQandA_board_num(rs
						.getInt("QandA_board_num"));
				QandA_board.setQandA_board_title(rs
						.getString("QandA_board_title"));
				QandA_board.setQandA_board_content(rs
						.getString("QandA_board_content"));
				QandA_board.setQandA_board_passwd(rs
						.getInt("QandA_board_passwd"));
				QandA_board.setQandA_board_date(rs
						.getTimestamp("QandA_board_date"));
				QandA_board.setQandA_board_count(rs
						.getInt("QandA_board_count"));
				QandA_board.setMember_num(rs
						.getInt("member_num"));
				QandA_board.setMember_id(rs
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
		return QandA_board;
	}

	
	
	public int updateQandA_Board(QandA_BoardDataBean QandA_board, int QandA_board_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x=-1;
		try {

			 conn = getConnection();

	            pstmt = conn.prepareStatement("select * from QandA_board where QandA_board_num = ?");
	            pstmt.setInt(1, QandA_board_num);
				rs = pstmt.executeQuery();

			if (rs.next()){	
				
			String sql = "update QandA_board set QandA_board_title=?, QandA_board_content=? where QandA_board_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, QandA_board.getQandA_board_title());
			pstmt.setString(2, QandA_board.getQandA_board_content());
			pstmt.setInt(3, QandA_board.getQandA_board_num());
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


	
	public int deleteQandA_Board(int QandA_board_num, int QandA_board_passwd)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int dbpasswd = 0;
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select QandA_board_passwd from QandA_board where QandA_board_num = ?");
			pstmt.setInt(1, QandA_board_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getInt("");
				if (dbpasswd == QandA_board_passwd) {
					pstmt = conn
							.prepareStatement("delete from QandA_board where QandA_board_num=?");
					pstmt.setInt(1, QandA_board_num);
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
	
	public int getQandA_Board_Passwd(int QandA_board_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int QandA_board_passwd = 0;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select QandA_board_passwd from QandA_board where QandA_board_num = ?");
			pstmt.setInt(1, QandA_board_num);
			rs = pstmt.executeQuery();
			if (rs.next()){
				QandA_board_passwd = rs.getInt(1);
			}else{
				QandA_board_passwd = 0;
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
		return QandA_board_passwd;
	}

	
	
	public List<QandA_BoardDataBean> getQandA_Boards2(int start, int end, QandA_BoardDataBean QandA_board)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QandA_BoardDataBean> QandA_boardList2 = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT QandA_board_num, QandA_board_title, QandA_board_content, QandA_board_passwd, "
							+ "QandA_board_date, QandA_board_count, member_id, q.member_num FROM QandA_board q, member m where q.member_num=m.member_num where q.memeber_num=?");
			
			pstmt.setInt(1, QandA_board.getMember_num());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				QandA_boardList2 = new ArrayList<QandA_BoardDataBean>();
				do {
					QandA_board = new QandA_BoardDataBean();
					QandA_board.setQandA_board_num(rs
							.getInt("QandA_board_num"));
					QandA_board.setQandA_board_title(rs
							.getString("QandA_board_title"));
					QandA_board.setQandA_board_content(rs
							.getString("QandA_board_content"));
					QandA_board.setQandA_board_passwd(rs
							.getInt("QandA_board_passwd"));
					QandA_board.setQandA_board_date(rs
							.getTimestamp("QandA_board_date"));
					QandA_board.setQandA_board_count(rs
							.getInt("QandA_board_count"));
					QandA_board.setMember_num(rs
							.getInt("member_num"));
					QandA_board.setMember_id(rs
							.getString("member_id"));
					QandA_boardList2.add(QandA_board);
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
		return QandA_boardList2;
	}

	
	public void deleteQandA_Board2(int QandA_board_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from QandA_board where QandA_board_num = ?";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, QandA_board_num);
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
