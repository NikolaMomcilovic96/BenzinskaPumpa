package binovi;

public class Firma {

    private int idFirme;
    private String naziv;
    private String adresa;
    private int PIB;
    private String lozinka;
    private int idRukovodioca;

    public Firma() {

    }

    public Firma(int idFirme, String naziv, String adresa, int PIB, String lozinka, int idRukovodioca) {
        this.idFirme = idFirme;
        this.naziv = naziv;
        this.adresa = adresa;
        this.PIB = PIB;
        this.lozinka = lozinka;
        this.idRukovodioca = idRukovodioca;
    }

    public int getIdFirme() {
        return idFirme;
    }

    public String getNaziv() {
        return naziv;
    }

    public String getAdresa() {
        return adresa;
    }

    public int getPIB() {
        return PIB;
    }

    public String getLozinka() {
        return lozinka;
    }

    public int getIdRukovodioca() {
        return idRukovodioca;
    }

    public void setIdFirme(int idFirme) {
        this.idFirme = idFirme;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public void setAdresa(String adresa) {
        this.adresa = adresa;
    }

    public void setPIB(int PIB) {
        this.PIB = PIB;
    }

    public void setLozinka(String lozinka) {
        this.lozinka = lozinka;
    }

    public void setIdRukovodioca(int idRukovodioca) {
        this.idRukovodioca = idRukovodioca;
    }

}
