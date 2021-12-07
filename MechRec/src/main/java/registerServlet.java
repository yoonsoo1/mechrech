package rbharatr_CSCI201_RecMech;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
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
import javax.servlet.http.HttpServletResponseWrapper;
/**
 * Servlet implementation class SignupValidation
 */
@WebServlet("/registerServlet")
public class registerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registerServlet() {
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
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if(email == null || username == null || password == null) {
            request.setAttribute("errorMessageSign", "Fields cannot be blank");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }
        
        if(!isEmailValid(email)) {
            request.setAttribute("errorMessageSign", "Invalid Email entered");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }
        
        
        try {
            Connection con = DBConnection.initializeDataBase();
            PreparedStatement st = con.prepareStatement("SELECT email,userID FROM Users WHERE (userID=?) OR (email=?)");
            /* CHECK FOR USERNAME AS WELL */
            st.setString(1, username);
            st.setString(2, email);
            ResultSet rs = st.executeQuery();
            if(rs.next()) {
                request.setAttribute("errorMessageSign", "An account with that email and/or username already exists");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            
            st.close();
            con.close();
        }catch(Exception e) {
            e.printStackTrace();
            
        }
        
        try {
            Connection con = DBConnection.initializeDataBase();
            PreparedStatement st = con.prepareStatement("INSERT INTO Users(email,userID,HashPass) VALUES (?,?,?);");
            st.setString(1, email);
            st.setString(2, username);
            /*STORE PASSWORD AS STRING*/
            st.setString(3, password);
            
            
            // HASHING PASSWORD
            
            
//            SecureRandom random = new SecureRandom();
//            byte [] salt = new byte[16];
//            random.nextBytes(salt);
//            MessageDigest md = MessageDigest.getInstance("SHA-512");
//            md.update(salt);
//            byte[] hashedPassword = md.digest(password.getBytes(StandardCharsets.UTF_8));
//            st.setBytes(3, hashedPassword);
//            st.setBytes(4, salt);
            
            
            //st.setString4(4, "12341");
            
            st.executeUpdate();
            request.setAttribute("errorMessageSign", "Sign up succesful please log in");
            st.close();
            con.close();
        }catch(Exception e) {
            e.printStackTrace();
            return;
        }
        
        request.setAttribute("errorMessageSign", "Signed up succesffully, now, login");
        request.getRequestDispatcher("Register.jsp").forward(request, response);
        
    }
    
    private boolean isEmailValid(String email) {
            return email.matches("(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])");
    }
    
 
}
