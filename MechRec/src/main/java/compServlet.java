import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.google.gson.*;

@WebServlet("/compServlet")
public class compServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, 
    HttpServletResponse response) throws IOException
	{
		response.setContentType("application/json");
		// make company JSON
		String compJSON = "";
		int companyID = 0;
		String db = "jdbc:mysql://localhost:3306/mechrec";
		String user = "root";
		String pwd = "groot0107";
		String sql = "SELECT c.companyName, c.rating,"
				+ "FROM Companies c\n" 
				+ "WHERE c.CompanyID = " + companyID;
		
		try (Connection conn = DriverManager.getConnection(db, user, pwd);
				PreparedStatement ps = conn.prepareStatement(sql);)
		{
			ResultSet rs = ps.executeQuery();
			String companyName = rs.getString("companyName");
			Double rating = BigDecimal.valueOf(rs.getDouble("rating"))
					.setScale(3, RoundingMode.HALF_UP)
					.doubleValue();
			Company cny = new Company(companyName, rating);
			Gson comGson = new Gson();
			compJSON = comGson.toJson(cny);
		}
		catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
			//out.println(sqle.getMessage());
		}
		
		
		// making review JSON
		db = "jdbc:mysql://localhost:3306/mechrec";
		user = "root";
		pwd = "groot0107";
		sql = "SELECT p.userId, p.postMessage, p.postTimestamp"
				+ ", p.rating, p.carModel, p.carMake, p.carYear, p.img"
				+ ", s.serviceName, s.price "
				+ "FROM Posts p Companies c Services s\n" 
				+ "WHERE p.CompanyID = c.CompanyID\n"
				+ "AND p.postID = s.postID\n"
				+ "AND c.CompanyID = " + companyID + "\n"
				+ "ORDER BY p.postTimestamp DESC";

		
		ArrayList<Review> reviews = new ArrayList<Review>();
		
		try (Connection conn = DriverManager.getConnection(db, user, pwd);
				PreparedStatement ps = conn.prepareStatement(sql);)
		{
			// save to JSON
			ResultSet rs = ps.executeQuery();
			for(int i = 0; i < 10; i++)
			{
				String userId = rs.getString("userId");
				String postMessage = rs.getString("postMessage");
				String postTimestamp = rs.getString("postTimestamp");
				double rating = rs.getDouble("rating");
				String carModel = rs.getString("carModel");
				String carMake = rs.getString("carMake");
				int carYear = rs.getInt("carYear");
				String img = rs.getString("img");
				Review r = new Review(userId, postMessage,postTimestamp,
						rating, carModel, carMake, carYear, img);
				reviews.add(r);
			}
			Gson revGson = new Gson();
			String revJSON = revGson.toJson(reviews);
			String bothJson = "[" + compJSON + "," + revJSON + "]";
			response.getWriter().write(bothJson);
			//request.getRequestDispatcher("/Access.jsp").forward(request,  response);
		}
		catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
			//out.println(sqle.getMessage());
		}
	}
}
