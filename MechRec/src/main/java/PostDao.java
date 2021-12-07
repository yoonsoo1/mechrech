import java.sql.Connection;
import java.sql.DriverManager;

public class PostDao {
	public static Connection initializeConnection() {
		try {
			DriverManager.registerDriver(
	                new com.mysql.cj.jdbc.Driver());
			
			Connection con = DriverManager.getConnection("jdbc:mysql:// localhost:3306/"  +"mechrec",
                        "root", "root");
		
			return con;
		}catch(Exception e) {
			System.out.println("Could not conncet to database");
		}
		return null;
		
	}
}
