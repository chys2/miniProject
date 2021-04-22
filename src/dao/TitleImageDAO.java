package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TitleImageDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public TitleImageDAO() {
		try {

			  String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; 
			  String dbID ="c##root"; 
			  String dbPassword = "root";
			  Class.forName("oracle.jdbc.OracleDriver"); 
			  conn =DriverManager.getConnection(dbURL, dbID, dbPassword);

			
//			 InitialContext ic = new InitialContext();
//			 
//			 DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
//			 
//			 conn = ds.getConnection();
//			

			System.out.println("연결완료");
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
			rs = pstmt.executeQuery();

			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}return 0;
	}
	public int insert(String logid, String imagename) {
		String SQL = "INSERT INTO titleimage VALUES (?,?)";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logid);
			pstmt.setString(2, imagename);
			pstmt.execute();
			rs = pstmt.executeQuery();
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
			while(rs.next()) {
			imagename = rs.getString(1);
			}
			if(imagename==null)
            return tatleDefault;
			else
			return imagename;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return imagename;
	}
	
}
