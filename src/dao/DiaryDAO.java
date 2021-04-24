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

public class DiaryDAO {

	private Connection conn;
	private ResultSet rs;

	public DiaryDAO() {
		try {

			 String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; 
			 String dbID ="c##root"; String dbPassword = "root";
			 Class.forName("oracle.jdbc.OracleDriver"); 
			 conn =DriverManager.getConnection(dbURL, dbID, dbPassword);

//			InitialContext ic = new InitialContext();
//
//			DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
//
//			conn = ds.getConnection();

			System.out.println("¿¬°á¿Ï·á");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}

//	public String getDate() { //? ?™?˜™? ?™?˜™ ? ?‹œê³¤ì˜™ ? ?Œê¹ì˜™
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

	public int diarygetNext() { // ? ?Œ‰?™?˜™? ?™?˜™ ? ?™?˜™?˜¸ ? ?Œê¹ì˜™
		String SQL = "select diaryID from diary order by diaryID DESC";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // ì²? ? ?™?˜™ì§? ? ?Œ‰?‹œë±„ì˜™? ?™?˜™ ? ?™?˜™? ï¿?
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // ? ?™?˜™? ?™?˜™? ?‹¶ë¸ì˜™? ?‹±?™?˜™ ? ?™?˜™? ?™?˜™
	}

	public int diarywrite(String logId, String diaryContent, String diaryImagename) {
		String SQL = "insert into diary values (?,?,to_char(sysdate,'yyyy-mm-dd hh24:mi'),?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, diarygetNext());
			pstmt.setString(2, logId);
			pstmt.setString(3, diaryContent);
			pstmt.setInt(4, 1);
			pstmt.setString(5, diaryImagename);
			return pstmt.executeUpdate();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1; // ? ?™?˜™? ?™?˜™? ?™?˜™ ? ?™?˜™? ?‹±?™?˜™ ? ?™?˜™? ?™?˜™
	}

	public ArrayList<vo.DiaryVo> diarycheck(String logId) {
		String SQL = "select logid, count(diaryAvailable) from diary where diaryAvailable =1 and logid= ? group by logid";
		ArrayList<vo.DiaryVo> check = new ArrayList<vo.DiaryVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.DiaryVo diary = new vo.DiaryVo();
				diary.setLogId(rs.getString(1));
				diary.setCount(rs.getInt(2));
				check.add(diary);
			}
			System.out.println("test");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return check; // ? ?™?˜™ì²? ? ?Œ‰?‹œë±„ì˜™ ? ?™?˜™?™˜
	}

	public ArrayList<vo.DiaryVo> getList(String logId, int pageNumber) {
		// ? ?Œ‰?‹œê¹ì˜™ 1? ?™?˜™ 10? ?™?˜™? ?™?˜™? ?™?˜™ ? ?™?˜™? ï¿?
		String SQL = "select * from diary where logId = ? and diaryId < ? and diaryAvailable = 1 and ROWNUM <=10 order by diaryId desc";

		ArrayList<vo.DiaryVo> list = new ArrayList<vo.DiaryVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			pstmt.setInt(2, diarygetNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.DiaryVo diary = new vo.DiaryVo();
				diary.setDiaryId(rs.getInt(1));
				diary.setLogId(rs.getString(2));
				diary.setDiaryDate(rs.getString(3));
				diary.setDiaryContent(rs.getString(4));
				diary.setDiaryAvailable(rs.getInt(5));
				diary.setDiaryImagename(rs.getString(6));
				list.add(diary);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // ? ?™?˜™ì²? ? ?Œ‰?‹œë±„ì˜™ ? ?™?˜™?™˜
	}

	public boolean diarynextPage(int pageNumber) {
		String SQL = "select * from diary where diaryId < ? and diaryAvailable = 1 and ROWNUM <=10   order by diaryID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, diarygetNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // ? ?™?˜™? ?™?˜™? ?™?˜™ ? ?™?˜™? ?‹±?™?˜™ ? ?™?˜™? ?™?˜™
	}

	public ArrayList<vo.DiaryVo> getDiarylist(String logId) {
		String SQL = "select DiaryContent,DiaryImagename,diaryid,logid from diary where logId = ? and diaryAvailable = 1 and ROWNUM <=3  order by diaryID desc";
		
		ArrayList<vo.DiaryVo> list = new ArrayList<vo.DiaryVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo.DiaryVo diary = new vo.DiaryVo();
				diary.setDiaryContent(rs.getString(1));
				diary.setDiaryImagename(rs.getString(2));
				diary.setDiaryId(rs.getInt(3));
				diary.setLogId(rs.getString(4));
				list.add(diary);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // ? ?™?˜™? ?™?˜™? ?™?˜™ ? ?™?˜™? ?‹±?™?˜™ ? ?™?˜™? ?™?˜™
	}
	
	
	public vo.DiaryVo getDiary(String logId) {
		String SQL = "select DiaryContent,DiaryImagename,diaryid,logid,diarydate from diary where logId = ? and diaryAvailable = 1 and ROWNUM <=3  order by diaryID desc";
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo.DiaryVo diary = new vo.DiaryVo();
				diary.setDiaryContent(rs.getString(1));
				diary.setDiaryImagename(rs.getString(2));
				diary.setDiaryId(rs.getInt(3));
				diary.setLogId(rs.getString(4));
				diary.setDiaryDate(rs.getString(5));
				return diary;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // ? ?™?˜™? ?™?˜™? ?™?˜™ ? ?™?˜™? ?‹±?™?˜™ ? ?™?˜™? ?™?˜™
	}
//	public vo.DiaryVo getDiary(String logId) {
//		String SQL = "select * from diary where diaryID = ?";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1, logId);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				vo.DiaryVo diary = new vo.DiaryVo();
//				diary.setDiaryId(rs.getInt(1));
//				diary.setLogId(rs.getString(2));
//				diary.setDiaryDate(rs.getString(3));
//				diary.setDiaryContent(rs.getString(4));
//				diary.setDiaryAvailable(rs.getInt(5));
//				diary.setDiaryImagename(rs.getString(6));
//				return diary;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return null; // ? ?™?˜™? ?™?˜™? ?™?˜™ ? ?™?˜™? ?‹±?™?˜™ ? ?™?˜™? ?™?˜™
//	}

	public int diaryupdate(int diaryID, String diaryContent, String diaryImagename) {
		String sql = "update diary set diaryContent = ? , diaryImagename= ?" + "where diaryID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, diaryContent);
			pstmt.setString(2, diaryImagename);
			pstmt.setInt(3, diaryID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return -1; // ? ?™?˜™? ?™?˜™? ?‹¶ë¸ì˜™? ?‹±?™?˜™ ? ?™?˜™? ?™?˜™
	}

	public int diarydelete(int diaryID) {
		// ? ?™?˜™? ?™?˜™ ? ?™?˜™? ?™?˜™? ?‹¶ëªŒì˜™ ? ?™?˜™? ?™?˜™? ?‹¹?Œ?˜™ ? ?™?˜™? ?™?˜™ ? ?‹£?‹ˆ?°?˜™
		// ? ?Œ‰?‹œê¹ì˜™ ? ?™?˜™?š¨? ?™?˜™? ?Œ˜ëªŒì˜™ '0'? ?™?˜™? ?™?˜™ ? ?™?˜™? ?™?˜™? ?‹¼?Œ?˜™
		String sql = "update diary set diaryAvailable = 0 where diaryID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, diaryID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // ? ?™?˜™? ?™?˜™? ?‹¶ë¸ì˜™? ?‹±?™?˜™ ? ?™?˜™? ?™?˜™
	}

}
