package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class AccountBookDAO {
	private Connection conn;
	private ResultSet rs;

	public AccountBookDAO() {
		try {
			
			 String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; 
			  String dbID ="c##root"; 
			  String dbPassword = "root";
			  Class.forName("oracle.jdbc.OracleDriver"); 
			  conn =DriverManager.getConnection(dbURL, dbID, dbPassword);
				
/*
 * InitialContext ic = new InitialContext();
 * 
 * DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
 * 
 * conn = ds.getConnection();
 */
			 
			System.out.println("연결완료");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}
}
