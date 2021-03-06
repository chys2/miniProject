package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import Jdbc.JdbcUtil;

public class TitleImageDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public TitleImageDAO() {
		try {

//			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
//			String dbID = "c##root";
//			String dbPassword = "root";
//			Class.forName("oracle.jdbc.OracleDriver");
//			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

			 InitialContext ic = new InitialContext();
			 
			 DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
			 
			 conn = ds.getConnection();
			

			System.out.println("TitleImageDAO DB?????Ϸ?");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}

	public int update(String logid, String imagename) {
		String SQL = "update titleimage set imagename=? where logId = ? ";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, imagename);
			pstmt.setString(2, logid);
			pstmt.execute();
		

			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int insert(String logid, String imagename) {
		String SQL = "INSERT INTO titleimage VALUES (?,?)";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logid);
			pstmt.setString(2, imagename);
			pstmt.execute();
			return 1;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public String view(String logid) {
		String SQL = "select imagename from titleimage where logid = ?";
		String tatleDefault = "foot.jpg";
		String imagename = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				imagename = rs.getString(1);
			}
			if (imagename == null)
				return tatleDefault;
			else
				return imagename;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return imagename;
	}

	public ArrayList<vo.TitleimageVo> getList(String logId) {
		String SQL = "select * from titleimage where logid= ?";
		ArrayList<vo.TitleimageVo> list = new ArrayList<vo.TitleimageVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.TitleimageVo title = new vo.TitleimageVo();
				title.setLogId(rs.getString(1));
				title.setImagename(rs.getString(2));
				list.add(title);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public void close() {
		JdbcUtil.close(conn, pstmt, rs);
		System.out.println("imageclose");
	}

}
