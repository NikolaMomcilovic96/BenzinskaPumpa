package binovi;

public class Racun {

    private int idRacuna;
    private int idPumpe;
    private int idProdavca;
    private int idKorisnika;
    private int idNarudzbenice;
    private int kolicina;
    private String gorivo;
    private int cena;
    private String datum;
    private String vreme;

    public Racun(int idRacuna, int idPumpe, int idProdavca, int idKorisnika, int idNarudzbenice, int kolicina, String gorivo, int cena, String datum, String vreme) {
        this.idRacuna = idRacuna;
        this.idPumpe = idPumpe;
        this.idProdavca=idProdavca;
        this.idKorisnika = idKorisnika;
        this.idNarudzbenice = idNarudzbenice;
        this.kolicina=kolicina;
        this.gorivo=gorivo;
        this.cena = cena;
        this.datum = datum;
        this.vreme = vreme;
    }

    public int getIdRacuna() {
        return idRacuna;
    }

    public int getIdPumpe() {
        return idPumpe;
    }

    public int getIdKorisnika() {
        return idKorisnika;
    }

    public int getIdNarudzbenice() {
        return idNarudzbenice;
    }

    public int getCena() {
        return cena;
    }

    public int getIdProdavca() {
        return idProdavca;
    }

    public int getKolicina() {
        return kolicina;
    }

    public String getGorivo() {
        return gorivo;
    }

    public String getDatum() {
        return datum;
    }

    public String getVreme() {
        return vreme;
    }

    public void setIdRacuna(int idRacuna) {
        this.idRacuna = idRacuna;
    }

    public void setIdKorisnika(int idKorisnika) {
        this.idKorisnika = idKorisnika;
    }

    public void setIdNarudzbenice(int idNarudzbenice) {
        this.idNarudzbenice = idNarudzbenice;
    }

    public void setCena(int cena) {
        this.cena = cena;
    }

    public void setDatum(String datum) {
        this.datum = datum;
    }

    public void setVreme(String vreme) {
        this.vreme = vreme;
    }

    public void setIdPumpe(int idPumpe) {
        this.idPumpe = idPumpe;
    }

    public void setIdProdavca(int idProdavca) {
        this.idProdavca = idProdavca;
    }

    public void setKolicina(int kolicina) {
        this.kolicina = kolicina;
    }

    public void setGorivo(String gorivo) {
        this.gorivo = gorivo;
    }

}
