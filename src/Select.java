import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;
import com.mysql.jdbc.Driver;


@WebServlet("/Select")
public class Select extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	PrintWriter out = res.getWriter();
	res.setContentType("text/html");
	
	/* NE PAS MODIFIER (Sauf indication)*/
	out.println("<!DOCTYPE html><html lang='fr'>");
	out.println("<head><meta charset='utf-8'><meta http-equiv='X-UA-Compatible' content='IE=edge'><meta name='viewport' content='width=device-width, initial-scale=1'>");
	
		/* Titre de la page HTML */
	out.println("<title>Menu</title>");
		/* **************** */
	
	out.println("<!-- Bootstrap core CSS --><link href='//getbootstrap.com/dist/css/bootstrap.min.css' rel='stylesheet'>");
	
	out.println("</head>");
	out.println("<body>");
	
	
	out.println("<div class='container'>");
	
		
	
		
	
	String query = "select * from Ville;";
	Connection con =null;
	try {
	    
	    // enregistrement du driver
		Class.forName("com.mysql.jdbc.Driver");
	    
	    // connexion a la base
	    con = DriverManager.getConnection("jdbc:mysql://localhost/sampledatabase?"+"user=root&password=root");
	    
	    // execution de la requete
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery(query);
	    
	    out.println("<pre>"+query+"</pre>");
	    
	    out.println("<table class='table table-bordered table-striped'>");
	    
	    out.print("<thead>");
		out.print("<tr>");
	    out.print("<th>NAME</th>");
	    out.print("<th>UNIVNAME</th>");
	    out.print("<th>DESCRIPTION</th>");
	    out.print("<th>DEPARTMENT</th>");
	    out.println("</tr>");
	    out.print("</thead>");
	    
	    out.print("<tbody>");
	    
	    while(rs.next())
		{
		    out.println("<tr>");
		    out.print("<td>"+rs.getString("Ville")+"</td>");
		    out.print("<td>"+rs.getString("UnivName")+"</td>");
		    out.print("<td>"+rs.getString("Description")+"</td>");
		    out.print("<td>"+rs.getString("Department")+"</td>");
		    out.println("</tr>");
		}
	    
		out.print("</tbody>");
		
	    out.println("</table>");
	    
	    
	}
	catch (Exception e) {			
		out.println("<div class='alert alert-warning' role='alert'>Erreur "+e.getClass()+" : "+e.getMessage()+"</div>");
	}
	finally
	    {
		try{con.close();} catch (Exception e){}
	    }
	
				
			out.println("</div>");
		out.println("</div>");
	out.println("</div>");

	out.println("</body></html>");
    }
}
