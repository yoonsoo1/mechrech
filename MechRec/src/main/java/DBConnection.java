package rbharatr_CSCI201_RecMech;

import java.sql.*;

public class DBConnection {
 
 
	private static String insertUser = "INSERT INTO users VALUES (?,?,?);";
 
	protected static Connection initializeDataBase() throws SQLException, ClassNotFoundException {
 
 
        String url = "jdbc:mysql://localhost:3306/MechRec";
        // Database name to access
 
        String username = "root";
        String password = "root";
 
        Connection connection;
        try {
 
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	connection = DriverManager.getConnection(url, username, password);
            System.out.println("Database connected!");
        } catch (SQLException e) {
            throw new IllegalStateException("Cannot connect the database!", e);
        }
 
        return connection;
 
	}
 
 
}
