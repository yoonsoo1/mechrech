

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
/**
 * Servlet implementation class LoginValidation
 */
@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final byte[] SALT = new byte[] { (byte)0xe0, 0x4f, (byte)0xd0,
		    0x20, (byte)0xea, 0x3a, 0x69, 0x10, (byte)0xa2, (byte)0xd8, 0x08, 0x00, 0x2b,
		    0x30, 0x30, (byte)0x9d };

 
    /**
     * Default constructor. 
     */
    public loginServlet() {
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
//      doGet(request, response);
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
      
        //Check for 
        if(username == null || password == null) {
            request.setAttribute("errorMessage", "Fields cannot be blank");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        } else if(username.equals("")|| password.equals("")) {
              request.setAttribute("errorMessage", "Invalid user or password");
              request.getRequestDispatcher("Login.jsp").forward(request, response);
              return;
        } 
        
        try {
            Connection con = DBConnection.initializeDataBase();
            PreparedStatement st = con.prepareStatement("SELECT email,userID,hashPass FROM Users WHERE (userID=?)");
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            String resUsername = "", resEmail = "";
			String resHashPass = null;
            while(rs.next()) {
                
                resUsername = rs.getString("userID");
                resEmail = rs.getString("email");
                resHashPass = rs.getString("hashPass");
				           
                
            }
            
            String hashedPassword = null;
			try {
	            MessageDigest md = MessageDigest.getInstance("SHA-256");
	            md.update(SALT);
	            byte[] bytes = md.digest(password.getBytes());
	            StringBuilder sb = new StringBuilder();
	            for (int i = 0; i < bytes.length; i++) {
	                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	            }
	            hashedPassword = sb.toString();
	        } catch (NoSuchAlgorithmException e) {
	        	request.setAttribute("errorMessage", "Incorrect email and or password");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
	            
	        }

            if(resHashPass == null) {
            	request.setAttribute("errorMessage", "Incorrect email and or password");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }
			
            if(resHashPass.equals(hashedPassword)) {
                HttpSession sesh = request.getSession();
                sesh.setAttribute("username", resUsername);
                System.out.println("Session created for " + username);
            }else {
                request.setAttribute("errorMessage", "Incorrect email and or password");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }
            st.close();
            con.close();
        }catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage","somethign happened on our end");
            return;
        }
        
        request.setAttribute("errorMessage", "logged in");
        request.getRequestDispatcher("index.jsp").forward(request, response);
        
        
    }
    
    private boolean isUsernameValid(String email) {
        return email.matches("(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])");
    }
 
}
