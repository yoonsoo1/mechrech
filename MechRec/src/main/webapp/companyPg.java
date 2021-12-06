import java.sql.*;
import java.io.*;

public class companyPg {
	public static class company {
		public int companyId;
		public String companyName;
		public double rating;
	}
	
	public static void main(String[] args) {
		String db = "jdbc:mysql://localhost/mechrec";
		String user = "root";
		String pwd = "root";
		String sql = "SELECT * FROM Companies";
		try(Connection conn = DriverManager.getConnection(db,user,pwd);
				Statement st = conn.createStatement();
				ResultSet rs = st.executeQuery(sql);) {
			while(rs.next()) {
				
			}
		}
		catch (SQLException ex) {
			System.out.println("SQLException: " + ex.getMessage());
		}
	}
}