package tw.iii.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/changeData")
public class changeData extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String user=(String)session.getAttribute("user");
		if(user==null){
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		String passwd = request.getParameter("passwd");
		
		try {			
			Class.forName("com.mysql.jdbc.Driver");		
		} catch (Exception e) {
			System.out.println(e);
		}	
		Properties prop = new Properties();
		prop.setProperty("user", "root");
		prop.setProperty("password", "root");
		
		String sql = "UPDATE manager SET passwd=? WHERE user=?";
		try (
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/attractions",prop);
				PreparedStatement pstmt=conn.prepareStatement(sql);
				)
			{	
			pstmt.setString(1, passwd);
			pstmt.setString(2, user);
			pstmt.executeUpdate();
			request.getRequestDispatcher("change.jsp").forward(request, response);
			}catch (Exception e){
				System.out.println(e);
			}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
