package tw.backStage;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;


@WebServlet("/loginMember")
public class loginMember extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user");
		String passwd = request.getParameter("passwd");
		
		//若沒有已存在session,就會自動新創立一個
		HttpSession session = request.getSession();
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		
		Properties prop = new Properties();
		prop.setProperty("user", "root");
		prop.setProperty("password", "root");
		String sql = "SELECT * FROM member3 where user=? and passwd=?";
		try {			
			Class.forName("com.mysql.jdbc.Driver");		
		} catch (Exception e) {
			System.out.println(e);
		}		
		try (
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ming"
				                       ,prop);
				PreparedStatement pstmt=conn.prepareStatement(sql);			
				)
			{					
				pstmt.setString(1, user);
				pstmt.setString(2, passwd);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					//將名稱傳回主頁
					session.setAttribute("user", user);
					request.getRequestDispatcher("changePassword.jsp").forward(request, response);
				}else {
					out.println("<script type=\"text/javascript\">");
					out.println("alert('帳號或密碼輸入錯誤,請重新輸入');");
					out.println("location='logIn.jsp';");
					out.println("</script>");
				}
			}
			catch (Exception e){
				System.out.println(e);
			}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
