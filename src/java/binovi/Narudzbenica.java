package binovi;

public class Narudzbenica {

    private int idNarudzbenice;
    private String nazivGoriva;
    private int kolicina;
    private int idPumpe;
    private String datum;
    private String naplaceno;
    private int idFirme;

    public Narudzbenica(int idNarudzbenice, String nazivGoriva, int kolicina, int idPumpe, String datum, String naplaceno, int idFirme) {
        this.idNarudzbenice = idNarudzbenice;
        this.nazivGoriva = nazivGoriva;
        this.kolicina = kolicina;
        this.idPumpe = idPumpe;
        this.datum = datum;
        this.naplaceno = naplaceno;
        this.idFirme = idFirme;
    }

    public int getIdNarudzbenice() {
        return idNarudzbenice;
    }

    public String getNazivGoriva() {
        return nazivGoriva;
    }

    public int getKolicina() {
        return kolicina;
    }

    public int getIdFirme() {
        return idFirme;
    }

    public int getIdPumpe() {
        return idPumpe;
    }

    public String getDatum() {
        return datum;
    }

    public String getNaplaceno() {
        return naplaceno;
    }

    public void setIdNarudzbenice(int idNarudzbenice) {
        this.idNarudzbenice = idNarudzbenice;
    }

    public void setNazivGoriva(String nazivGoriva) {
        this.nazivGoriva = nazivGoriva;
    }

    public void setKolicina(int kolicina) {
        this.kolicina = kolicina;
    }

    public void setIdFirme(int idFirme) {
        this.idFirme = idFirme;
    }

    public void setIdPumpe(int idPumpe) {
        this.idPumpe = idPumpe;
    }

    public void setDatum(String datum) {
        this.datum = datum;
    }

    public void setNaplaceno(String naplaceno) {
        this.naplaceno = naplaceno;
    }

}
