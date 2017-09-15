package tw.iii.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/changeByAjax")
public class changeByAjax extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String passwd = request.getParameter("passwd");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		String user = request.getParameter("user");
		try {			
			Class.forName("com.mysql.jdbc.Driver");		
		} catch (Exception e) {
			System.out.println(e);
		}	
		Properties prop = new Properties();
		prop.setProperty("user", "root");
		prop.setProperty("password", "root");
		
		String name = passwd==null?(tel==null?"email":"tel"):"passwd";
		String value = name=="passwd"?passwd:(name=="tel"?tel:(name=="email"?email:null));
		String sql = "UPDATE member SET "+name+"=? WHERE user=?";
		try (
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/attractions",prop);
				PreparedStatement pstmt=conn.prepareStatement(sql);
				)
			{	
			pstmt.setString(1, value);
			pstmt.setString(2, user);
			pstmt.executeUpdate();
			}catch (Exception e){
				System.out.println(e);
			}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	

}
