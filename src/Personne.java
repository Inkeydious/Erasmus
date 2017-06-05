public class Personne
{
    public String login;
    public String mdp;
    public String nom;
    public String prenom;
    public String role;
    public String adresse;

    public Personne(String login, String mdp)
    {
	maj(login,mdp);
    }


	public void maj(String login, String mdp)
    {
	this.login = login;
	this.mdp = mdp;
	this.nom = nom;
	this.prenom = prenom;
	this.role = role;
	this.adresse = adresse;
    }


    
}
