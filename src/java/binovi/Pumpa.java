package binovi;

public class Pumpa {

    private int idPumpe;
    private String naziv;
    private String adresa;
    private int idMenadzera;

    public Pumpa(int idPumpe, String naziv, String adresa, int idMenadzera) {
        this.idPumpe = idPumpe;
        this.naziv = naziv;
        this.adresa = adresa;
        this.idMenadzera = idMenadzera;
    }

    public int getIdPumpe() {
        return idPumpe;
    }

    public String getNaziv() {
        return naziv;
    }

    public String getAdresa() {
        return adresa;
    }

    public int getIdMenadzera() {
        return idMenadzera;
    }

    public void setIdPumpe(int idPumpe) {
        this.idPumpe = idPumpe;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public void setAdresa(String adresa) {
        this.adresa = adresa;
    }

    public void setIdMenadzera(int idMenadzera) {
        this.idMenadzera = idMenadzera;
    }

}
