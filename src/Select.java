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
	
		
	
		
	String resultat[] = req.getParameter("textField1").split(",");
	ArrayList<String> result = new ArrayList();
	for(int i = 0; i < resultat.length; i++)
		result.add(resultat[i]);
	ArrayList<String> resultfinal = new ArrayList();
	for(int i = 0; i < result.size(); i++){
		if(!resultfinal.contains(result.get(i)))
			resultfinal.add(result.get(i));
	}
	//Check pour pas les mêmes villes
	Connection con =null;
	try {
	    
	    // enregistrement du driver
		Class.forName("com.mysql.jdbc.Driver");
	    
	    // connexion a la base
	    con = DriverManager.getConnection("jdbc:mysql://localhost/sampledatabase?user=root&password=root");
	    
	    // execution de la requete
	    Statement stmt = con.createStatement();
	    

		out.println("<h1>Erasmus Application</h1> ");

	    out.println("<table class='table table-bordered table-striped'>");
	    
	    out.print("<thead>");
		out.print("<tr>");
	    out.print("<th>CITY</th>");
	    out.print("<th>INTEREST</th>");
	    out.print("<th>DESCRIPTION</th>");
	    out.print("<th>DEPARTMENT</th>");
	    out.println("</tr>");
	    out.print("</thead>");
	    
	    out.print("<tbody>");
	    String query = "";
	    String in = " and Langage in (";
	    ResultSet rs = null;
	    for(int i = 0; i < resultfinal.size();i++){
			query = "select NameCity, Langage from information where NameCity = '"+resultfinal.get(i)+"'";
			if(req.getParameter("C") != null){
				in += "'C'";
				if((req.getParameter("Java") != null) || (req.getParameter("Cobol") != null))
					in += ",";
			}
			if(req.getParameter("Java") != null){
				in += "'Java'";
				if((req.getParameter("Cobol") != null))
					in += ",";
			}
			if(req.getParameter("Cobol") != null){
				in += "'Cobol'";
			}
			in += ")";
			if(req.getParameter("C") != null || req.getParameter("Java") != null || req.getParameter("Cobol") != null)
				query += in;
			query += ";";
			in = " and Langage in (";
		    rs = stmt.executeQuery(query);
		    
		    
	    while(rs.next())
		{
		    out.println("<tr>");
		    out.print("<td>"+rs.getString("NameCity")+"</td>");
		    out.print("<td>"+rs.getString("Langage")+"</td>");
		  //  out.print("<td>"+rs.getString("Description")+"</td>");
		   // out.print("<td>"+rs.getString("Department")+"</td>");
		    out.println("</tr>");
		}
	    }
	    //out.println("<pre>"+query+"</pre>");
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
    //res.sendRedirect("map.jsp");
	//req.getRequestDispatcher("map.jsp").forward(req, res);

    }

}
