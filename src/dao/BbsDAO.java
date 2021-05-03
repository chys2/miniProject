package dao;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.sql.*;
import javax.sql.*;

import Jdbc.JdbcUtil;

import javax.naming.*;

public class BbsDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public BbsDAO() {
		try {
			
			
//			 String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; String dbID ="c##root";
//			 String dbPassword = "root"; Class.forName("oracle.jdbc.OracleDriver");
//			 conn =DriverManager.getConnection(dbURL, dbID, dbPassword);
			 
				
				
				 InitialContext ic = new InitialContext();
				 
				 DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
				 
				 conn = ds.getConnection();
				
			 
			System.out.println("BbsDAO DB연결완료");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}


	public int bbsgetNext() { 
		//게시글 번호 부여
		String SQL = "select bbsID from bbs order by bbsID DESC";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}

	public int bbswrite(String bbsTitle, String logId, String bbsContent, String bbsImagename) {
		String SQL = "insert into bbs values (?,?,?,to_char(sysdate,'yyyy-mm-dd hh24:mi'),?,?,?)";
		//게시글 작성
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsgetNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, logId);
			pstmt.setString(4, bbsContent);
			pstmt.setInt(5, 1);
			pstmt.setString(6, bbsImagename);
			return pstmt.executeUpdate();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<vo.BbsVo> getList(int pageNumber) {
	
		String SQL = "select * from bbs where bbsId < ?  and bbsAvailable = 1 and ROWNUM <=10 order by bbsID desc";
		ArrayList<vo.BbsVo> list = new ArrayList<vo.BbsVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsgetNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.BbsVo bbs = new vo.BbsVo();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setLogId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsImagename(rs.getString(7));
				list.add(bbs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 占쏙옙체 占쌉시뱄옙 占쏙옙환
	}

	
	public ArrayList<vo.BbsVo> previewgetList(int pageNumber) {
	
		String SQL = "select * from bbs where bbsId < ?  and bbsAvailable = 1 and ROWNUM <=3 order by bbsID desc";
		ArrayList<vo.BbsVo> list = new ArrayList<vo.BbsVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsgetNext() - (pageNumber - 1) * 2);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.BbsVo bbs = new vo.BbsVo();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setLogId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsImagename(rs.getString(7));
				list.add(bbs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from bbs where bbsId < ? and bbsAvailable = 1 and ROWNUM <=10   order by bbsID desc";
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsgetNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 
	}

	public vo.BbsVo getBbs(int bbsID) {
		String SQL = "select * from bbs where bbsID = ?";
		//bbsid에 따른 게시글 내용 출력
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo.BbsVo bbs = new vo.BbsVo();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setLogId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsImagename(rs.getString(7));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return null; 
	}
	
	public int bbsupdate(int bbsID, String bbsTitle, String bbsContent, String bbsImagename ) {
		String sql = "update bbs set bbsTitle = ?, bbsContent = ? , bbsImagename =?"
				+ "where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setString(3, bbsImagename );
			pstmt.setInt(4, bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return -1; 
	}
	public int bbsdelete(int bbsID) {
		
		String sql = "update bbs set bbsAvailable = 0 where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public void close() {
		JdbcUtil.close(conn, pstmt, rs);
		System.out.println("bbsclose");
	}

}
