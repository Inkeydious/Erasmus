import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/SelectLangage")
public class SelectLangage extends HttpServlet {
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
	
	
	//Check pour pas les mêmes villes
	Connection con =null;
	String toutLangage="";

	try {
	    
	    // enregistrement du driver
		Class.forName("com.mysql.jdbc.Driver");
	    
	    // connexion a la base
	    con = DriverManager.getConnection("jdbc:mysql://localhost/sampledatabase?user=root&password=root");
	    
	    // execution de la requete
	    Statement stmt = con.createStatement();
	    String query = "select Langage from intereset;";
	    ResultSet rs = null;
		rs = stmt.executeQuery(query);
		    
		   
	    while(rs.next())
		{
		    toutLangage+= rs.getString("Langage") + ",";
		   // out.print("<td>"+rs.getString("Langage")+"</td>");
		  //  out.print("<td>"+rs.getString("Description")+"</td>");
		   // out.print("<td>"+rs.getString("Department")+"</td>");
		}
	    }
	    out.println("<pre>"+query+"</pre>");
	    //out.println("<pre>"+ req.getParameter("textField1")+"</pre>");
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
	out.println("<a href='map.jsp'><button type='button' >Previous page</button></a>");	
	out.println("</body></html>");
	req.setAttribute( "langage", toutLangage );
	this.getServletContext().getRequestDispatcher( "/mapdebibi2.jsp" ).forward( req, res );
    //res.sendRedirect("map.jsp");
	//req.getRequestDispatcher("map.jsp").forward(req, res);

    }

}
