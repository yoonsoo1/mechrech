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
		HttpSession session = request.getSession(false);
		String coID  = (String) session.getAttribute("companyID");
		int companyID = Integer.parseInt(coID);
		System.out.println("companyID: " + companyID);
		//int companyID = Integer.parseInt();
		String db = "jdbc:mysql://localhost:3306/mechrec";
		String user = "root";
		String pwd = "root";
		String sql = "SELECT c.companyName, c.rating, c.phone, c.address "
				+ "FROM Companies c\n" 
				+ "WHERE c.CompanyID = " + companyID + ";";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		try (Connection conn = DriverManager.getConnection(db, user, pwd);
				PreparedStatement ps = conn.prepareStatement(sql);)
		{
			ResultSet rs = ps.executeQuery();
			String companyName ="";
			Double rating = (double) 0;
			String phone = "";
			String address = "";
			if(rs.next())
			{
				companyName = rs.getString("companyName");
				rating = BigDecimal.valueOf(rs.getDouble("rating"))
						.setScale(3, RoundingMode.HALF_UP)
						.doubleValue();
				phone = rs.getString("phone");
				address = rs.getString("address");
			}
			else
			{
				System.out.println("Company Not Found");
			}
			Company cny = new Company(companyName, rating, phone, address);
			Gson comGson = new Gson();
			compJSON = comGson.toJson(cny);
			
		}
		catch (SQLException sqle) {
			System.out.println("For Companies");
			System.out.println ("SQLException: " + sqle.getMessage());
			//out.println(sqle.getMessage());
		}
		
		
		// making review JSON
		db = "jdbc:mysql://localhost:3306/mechrec";
		user = "root";
		pwd = "root";
		sql = 	"SELECT p.userId, p.postMessage, p.postTimestamp, "
				+ "p.rating, p.carModel, p.carMake, p.carYear, p.img "
				+ "FROM Posts p\n"
				+ "WHERE p.CompanyID = " + companyID + "\n"
				+ "ORDER BY p.postTimestamp DESC;";

				/*
				"SELECT p.userId, p.postMessage, p.postTimestamp"
				+ ", p.rating, p.carModel, p.carMake, p.carYear, p.img "
				//+ ", s.serviceName, s.price "
				+ "FROM Posts p, Companies c\n"
				//+ ", Services s\n" 
				+ "WHERE c.CompanyID = " + companyID + "\n"
				//+ "AND p.postID = s.postID\n"
				+ "ORDER BY p.postTimestamp DESC";
				*/

		
		ArrayList<Review> reviews = new ArrayList<Review>();
		String revJSON = "";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		try (Connection conn = DriverManager.getConnection(db, user, pwd);
				PreparedStatement ps = conn.prepareStatement(sql);)
		{
			// save to JSON
			ResultSet rs = ps.executeQuery();
			if(!rs.next()) 
			{
				System.out.println("No Posts for the company found");
			}
			else
			{
				for(int i = 0; i < 10; i++)
				{
					String userId = rs.getString("userID");
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
					if(!rs.next())
					{
						break;
					}
				}
			}
			Gson revGson = new Gson();
			revJSON = revGson.toJson(reviews);
			String bothJson = "[" + compJSON + "," + revJSON + "]";
			response.getWriter().write(bothJson);
			//request.getRequestDispatcher("/Access.jsp").forward(request,  response);
		}
		catch (SQLException sqle) {
			System.out.println("For Reviews");
			System.out.println ("SQLException: " + sqle.getMessage());
			//out.println(sqle.getMessage());
		}
	}
	protected void doPost(HttpServletRequest request, 
		    HttpServletResponse response) throws IOException, ServletException
	{		
		doGet(request,response);
	}
	
}
