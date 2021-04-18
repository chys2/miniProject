package dao;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;

	public BbsDAO() {
		try {


			
//			 String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; 
//			 String dbID ="c##root"; String dbPassword = "root";
//			 Class.forName("oracle.jdbc.OracleDriver"); 
//			 conn =DriverManager.getConnection(dbURL, dbID, dbPassword);
			
			
			  InitialContext ic = new InitialContext();
			  
			  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
			  
			  conn = ds.getConnection();
			
			System.out.println("占쏙옙占쏙옙狗占�");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}

//	public String getDate() { //占쏙옙占쏙옙 占시곤옙 占쌍깍옙
//		String SQL="select to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') from dual;";
//		
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			rs=pstmt.executeQuery();
//			if (rs.next()) {
//				return rs.getString(1);
//			}
//		}catch(Exception e){
//			
//			e.printStackTrace();
//		}
//		return"";
//	}

	public int getNext() { // 占쌉쏙옙占쏙옙 占쏙옙호 占쌍깍옙
		String SQL = "select bbsID from bbs order by bbsID DESC";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 占쏙옙째 占쌉시뱄옙占쏙옙 占쏙옙占�
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙
	}

	public int write(String bbsTitle, String logId, String bbsContent, String bbsImagename) {
		String SQL = "insert into bbs values (?,?,?,to_char(sysdate,'yyyy-mm-dd hh24:mi'),?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, logId);
			pstmt.setString(4, bbsContent);
			pstmt.setInt(5, 1);
			pstmt.setString(6, bbsImagename);
			return pstmt.executeUpdate();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1; // 占쏙옙占쏙옙占쏙옙 占쏙옙占싱쏙옙 占쏙옙占쏙옙
	}

	public ArrayList<vo.BbsVo> getList(int pageNumber) {
		// 占쌉시깍옙 1占쏙옙 10占쏙옙占쏙옙占쏙옙 占쏙옙占�
		String SQL = "select * from bbs where bbsId < ?  and bbsAvailable = 1 and ROWNUM <=10 order by bbsID desc";
		ArrayList<vo.BbsVo> list = new ArrayList<vo.BbsVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
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

	public boolean nextPage(int pageNumber) {
		String SQL = "select * from bbs where bbsId < ? and bbsAvailable = 1 and ROWNUM <=10   order by bbsID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // 占쏙옙占쏙옙占쏙옙 占쏙옙占싱쏙옙 占쏙옙占쏙옙
	}

	public vo.BbsVo getBbs(int bbsID) {
		String SQL = "select * from bbs where bbsID = ?";
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
		}
		return null; // 占쏙옙占쏙옙占쏙옙 占쏙옙占싱쏙옙 占쏙옙占쏙옙
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent, String im_name) {
		String sql = "update bbs set bbsTitle = ?, bbsContent = ? , bbsImagename= ?"
				+ "where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setString(3, im_name);
			pstmt.setInt(4, bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return -1; //占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙
	}
	public int delete(int bbsID) {
		//占쏙옙占쏙옙 占쏙옙占쏙옙占싶몌옙 占쏙옙占쏙옙占싹댐옙 占쏙옙占쏙옙 占싣니띰옙 占쌉시깍옙 占쏙옙효占쏙옙占쌘몌옙 '0'占쏙옙占쏙옙 占쏙옙占쏙옙占싼댐옙
		String sql = "update bbs set bbsAvailable = 0 where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙 
	}

}
