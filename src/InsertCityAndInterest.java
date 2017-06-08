import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;

@WebServlet("/InsertCityAndInterest")
public class InsertCityAndInterest extends HttpServlet 
{
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
    {
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
	
	out.println("<div class='page-header'>");
		out.println("<h1>Inscription</h1>");
	out.println("</div>");

	out.println("<div class='row'>");
		out.println("<div class='col-xs-12'>");
	
	Connection con=null;
	try 
	    {
		
		// enregistrement du driver
		Class.forName("com.mysql.jdbc.Driver");
		
		// connexion a la base
	    con = DriverManager.getConnection("jdbc:mysql://localhost/sampledatabase?user=root&password=root");
		
		String city = req.getParameter("insertcity");
		String intereset = req.getParameter("insertintereset");
		// Verification du login
		Statement stmt = con.createStatement();
		String query = "select * from city where NameCity='"+ city + "'";
		ResultSet rs = stmt.executeQuery(query);
		
		if(rs.next()) 
		    {
			out.println("<pre>Query : "+query+"</pre>");
			out.println("<div class='alert alert-danger' role='alert'>The city "+ city +" already exist, please choose an other one.</div>");
		    out.println("<a href='New'><button type='button' class='btn btn-default btn-lg'>Retour</button></a>");
		    }
		else
		    {
			String query2 = "insert into information values (";
			query2 += ("'"+city+"',");
			query2 += ("'"+intereset+"')");
			
			out.println("<pre>Query : "+query2+"</pre>");
			
			stmt.executeUpdate(query2);
			
			out.println("<div class='alert alert-success' role='alert'>The city :  " + city + ", and the intereset " + intereset +" has been created !</div>");
		    out.println("<a href='map3.jsp'><button type='button' class='btn btn-default btn-lg'>Back to the map</button></a>");
		    }
	    }
	catch (Exception e) {
		out.println("<div class='alert alert-warning' role='alert'>Erreur "+e.getClass()+" : "+e.getMessage()+"</div>");
	}
	finally{try {con.close();} catch (Exception e){}}

	out.println("</div>");
	out.println("</div>");
	out.println("</div>");
	out.println("</body></html>");

    }
}
