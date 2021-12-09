

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;



/**
 * Servlet implementation class PostServlet
 */
@WebServlet("/PostServlet")
@MultipartConfig(
		  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		  maxFileSize = 1024 * 1024 * 10,      // 10 MB
		  maxRequestSize = 1024 * 1024 * 100   // 100 MB
//		  location="/MechRec/postphotos"
)
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	
		
		HttpSession session = request.getSession(false);
		
		if(session.getAttribute("username") == null) {
			request.setAttribute("errorMessage", "Please log in to post");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
			
			return;
		}
	
		
		String message = request.getParameter("message").trim();
		String carModel = request.getParameter("carModel").trim();
		String carMake = request.getParameter("carMake").trim();
		String userID =  (String) session.getAttribute("username");
		int companyID = Integer.parseInt((String) session.getAttribute("companyID"));
		double rating = 0;
		
		Path currentRelativePath = Paths.get("");
		String s = currentRelativePath.toAbsolutePath().toString();
		System.out.println("Current absolute path is: " + s);
		
		String canonicalPath = new File(".").getCanonicalPath();
		System.out.println("Current directory path using canonical path method :- " + canonicalPath);
		System.out.println(new File(".").getAbsoluteFile());


		
		System.out.println(companyID);
		if(request.getParameter("rating") != null) {
			try{
			rating = Double.parseDouble(request.getParameter("rating"));
			}catch(NumberFormatException e) {
				request.setAttribute("errorMessage", "Pleasae enter a valid rating (1.0-5.0)");
				request.getRequestDispatcher("post.jsp").forward(request, response);
				return;
			}
		
			
			
		}
		
		
		int carYear = 0;
		if(request.getParameter("carYear") != null) {
			try{
				carYear = Integer.parseInt(request.getParameter("carYear"));
			}catch(NumberFormatException e) {
				request.setAttribute("errorMessage", "Pleasae enter a valid year (1900-2022)");
				request.getRequestDispatcher("post.jsp").forward(request, response);
				return;
			}
		}
		System.out.println(rating);
		System.out.println(carYear);
		System.out.println(carModel);
		
	
		
		if(!request.getParameterMap().containsKey("message") || !request.getParameterMap().containsKey("carModel") || !request.getParameterMap().containsKey("carMake") || !request.getParameterMap().containsKey("carYear") ) {
			
			request.setAttribute("errorMessage", "Form values missing");
			request.getRequestDispatcher("post.jsp").forward(request, response);
			return;
			
		}else if(message.length()>255) {
			request.setAttribute("errorMessage", "Post message length is too long, 255 characters only");
			request.getRequestDispatcher("post.jsp").forward(request, response);
			return;
		}else if(carModel.length() >30) {
			request.setAttribute("errorMessage", "Car Model length too long");
			request.getRequestDispatcher("post.jsp").forward(request, response);
			return;
		}else if(carMake.length() > 30) {
			request.setAttribute("errorMessage", "Car Make");
			request.getRequestDispatcher("post.jsp").forward(request, response);
			return;
		}else if(carYear > 2023 || carYear < 1900) {
			request.setAttribute("errorMessage", "Car Year is invalid (1900-2023) only compatible");
			request.getRequestDispatcher("post.jsp").forward(request, response);
			return;
		}else if(rating>5 || rating<0) {
			request.setAttribute("errorMessage", "Rating is invalid");
			request.getRequestDispatcher("post.jsp").forward(request, response);
			return;
		}
		
		
	

		Part part = request.getPart("file");
		String encoded = null;
		String filename = part.getSubmittedFileName();
		String ext = filename.substring(filename.indexOf(".")+1);
		if(part != null) {
			byte[] bytes = IOUtils.toByteArray(part.getInputStream());
			
			encoded = Base64.getEncoder().encodeToString(bytes);
		}
		
		String formattedBase64 ="data:image/";
		formattedBase64 +=ext;
		formattedBase64 +=";base64,";
		formattedBase64 +=encoded;
		
		Connection connection = PostDao.initializeConnection();
		String QUERY = "INSERT INTO Posts(CompanyID, userID, postMessage, rating, carModel, carMake, carYear,img) values ((SELECT CompanyID from Companies where CompanyID=?),?,?,?,?,?,?,?)"; 
		PreparedStatement st;
		try {
			st = connection.prepareStatement(QUERY);
			st.setInt(1, companyID);
			st.setString(2, userID);
			st.setString(3, message);
			st.setDouble(4, rating);
			st.setString(5, carModel);
			st.setString(6, carMake);
			st.setInt(7, carYear);
			st.setString(8, formattedBase64);
			
			st.executeUpdate();
		}catch(SQLException e) {
			System.out.println("Error " + e.getLocalizedMessage());
			request.setAttribute("errorMessage", "Something messed up on our end");
			request.getRequestDispatcher("post.jsp").forward(request, response);
			return;
		}
		
		System.out.println("Insert succesful");
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
		
		
		
	}
	
	public String randomString() {
			int leftLimit = 48; // numeral '0'
		    int rightLimit = 122; // letter 'z'
		    int targetStringLength = 10;
		    Random random = new Random();
	
		    String generatedString = random.ints(leftLimit, rightLimit + 1)
		      .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
		      .limit(targetStringLength)
		      .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
		      .toString();
	
		    return generatedString;
	}
		
	

}
