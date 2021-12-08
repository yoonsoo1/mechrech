import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.google.gson.Gson;

import javax.servlet.annotation.WebServlet;

@WebServlet("/indexServlet")
public class indexServlet extends HttpServlet{
	protected void doGet(HttpServletRequest request, 
		    HttpServletResponse response) throws IOException
	{
		response.setContentType("application/json");
		String compJSON = "";
		String db = "jdbc:mysql://localhost:3306/mechrec";
		String user = "root";
		String pwd = "root";
		String sql = "SELECT c.companyName, c.companyID "
				+ "FROM Companies c\n" 
				+ "WHERE c.CompanyID = 1\n"
				+ "OR c.CompanyID = 2\n"
				+ "OR c.CompanyID = 3\n";	
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
			ArrayList<compName> cnl = new ArrayList<compName>();
			String companyName ="";
			int companyID = 0;
			if(!rs.next())
			{
				System.out.println("Error, No Posts to Call");
			}
			else
			{
				for(int i = 0; i < 3; i++)
				{
					companyID = rs.getInt("companyID");
					companyName = rs.getString("companyName");
					compName cn = new compName(companyID, companyName);
					cnl.add(cn);
					if(!rs.next())
					{
						break;
					}
				}
			}
			Gson comGson = new Gson();
			compJSON = comGson.toJson(cnl);
			response.getWriter().write(compJSON);
		}
		catch (SQLException sqle) {
			System.out.println("For Companies");
			System.out.println ("SQLException: " + sqle.getMessage());
			//out.println(sqle.getMessage());
		}
	}
	
	protected void doPost(HttpServletRequest request, 
		    HttpServletResponse response) throws IOException, ServletException
	{
		String coID  = (String) request.getParameter("companyID");
		HttpSession session = request.getSession();
		session.setAttribute("companyID", coID);
		response.sendRedirect(request.getContextPath() + "/Login.jsp");
		//request.getRequestDispatcher("compServlet").forward(request,response);
	}
}
