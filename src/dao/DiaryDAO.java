package dao;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class DiaryDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	final int diaryInPage = 3;

	public DiaryDAO() {
		try {

			 String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; 
			 String dbID ="c##root"; String dbPassword = "root";
			 Class.forName("oracle.jdbc.OracleDriver"); 
			 conn =DriverManager.getConnection(dbURL, dbID, dbPassword);

			System.out.println("DiaryDAO DB연결완료");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}

	public int diarygetNext() { // 
		String SQL = "select diaryID from diary order by diaryID DESC";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // if not exist
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB Error
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
		return -1; // DB Error
	}
	
	public ArrayList<vo.DiaryVo> getList(String logId, int pageNumber) {
		// log, pageNumber
		String SQL = String.format("select * from diary where logId = ? and diaryId < ? and diaryAvailable = 1 and ROWNUM <=%d order by diaryId desc", diaryInPage);

		ArrayList<vo.DiaryVo> list = new ArrayList<vo.DiaryVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			pstmt.setInt(2, diarygetNext() - (pageNumber - 1) * diaryInPage);
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
		return list; // DB Error
	}

	public boolean nextPage(String logId, int pageNumber) {
		String SQL = "select count(*) from diary where logId = ? and diaryAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			rs.next();
			int numDiary = rs.getInt(1);
			
			if(numDiary > (pageNumber-1) * diaryInPage) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // if not exist next page
	}	
		
	public vo.DiaryVo getDiary(int diaryID) {
		String SQL = "select * from diary where diaryId = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, diaryID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo.DiaryVo diary = new vo.DiaryVo();
				diary.setDiaryId(rs.getInt(1));
				diary.setLogId(rs.getString(2));
				diary.setDiaryDate(rs.getString(3));
				diary.setDiaryContent(rs.getString(4));
				diary.setDiaryAvailable(rs.getInt(5));
				diary.setDiaryImagename(rs.getString(6));
				return diary;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // Invalid
	}

	public int diaryupdate(int diaryID, String diaryContent, String diaryImagename) {
		String sql = "update diary set diaryContent = ? , diaryImagename= ? where diaryID = ?";
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
		return -1; // DB Error
	}

	public int diarydelete(int diaryID) {
		String sql = "update diary set diaryAvailable = 0 where diaryID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, diaryID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB Error
	}
	public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {

		try {
			conn.close();
			pstmt.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void close(Connection conn, PreparedStatement pstmt) {
		try {
			conn.close();
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	public void close() {
		try {
			this.conn.close();
			this.pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
