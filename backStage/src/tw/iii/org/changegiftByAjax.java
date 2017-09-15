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


@WebServlet("/changegiftByAjax")
public class changegiftByAjax extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Name = request.getParameter("name");
		String produce = request.getParameter("produce");
		String price = request.getParameter("price");
		String tel = request.getParameter("tel");
		String ID = request.getParameter("ID");
		System.out.println(tel);
		try {			
			Class.forName("com.mysql.jdbc.Driver");		
		} catch (Exception e) {
			System.out.println(e);
		}	
		Properties prop = new Properties();
		prop.setProperty("user", "root");
		prop.setProperty("password", "root");
		
		String name = Name==null?(tel==null?(produce==null?(price==null?"":"Price"):"ProduceOrg"):"ContactTel"):"Name";
		String value = name=="Name"?Name:(name=="ContactTel"?tel:(name=="ProduceOrg"?produce:(name=="Price"?price:null)));
		String sql = "UPDATE gift SET "+name+"=? WHERE ID=?";
		try (
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/attractions",prop);
				PreparedStatement pstmt=conn.prepareStatement(sql);
				)
			{	
			pstmt.setString(1, value);
			pstmt.setString(2, ID);
			
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
