package binovi;

public class Korisnik {

    private int idKorisnika;
    private String ime;
    private String prezime;
    private String email;
    private String korinickoIme;
    private String lozinka;
    private int telefon;
    private int poeni;
    private String tipKorisnika;
    private int idPumpe;

    public Korisnik(int idKorisnika, String ime, String prezime, String email, String korinickoIme, String lozinka, int telefon, int poeni, String tipKorisnika, int idPumpe) {
        this.idKorisnika = idKorisnika;
        this.ime = ime;
        this.prezime = prezime;
        this.email = email;
        this.korinickoIme = korinickoIme;
        this.lozinka = lozinka;
        this.telefon = telefon;
        this.poeni = poeni;
        this.tipKorisnika = tipKorisnika;
        this.idPumpe = idPumpe;
    }

    public Korisnik() {

    }

    public int getIdKorisnika() {
        return idKorisnika;
    }

    public String getIme() {
        return ime;
    }

    public String getPrezime() {
        return prezime;
    }

    public String getEmail() {
        return email;
    }

    public int getTelefon() {
        return telefon;
    }

    public String getTipKorisnika() {
        return tipKorisnika;
    }

    public String getKorinickoIme() {
        return korinickoIme;
    }

    public String getLozinka() {
        return lozinka;
    }

    public int getIdPumpe() {
        return idPumpe;
    }

    public void setIdKorisnika(int idKorisnika) {
        this.idKorisnika = idKorisnika;
    }

    public void setIme(String ime) {
        this.ime = ime;
    }

    public void setPrezime(String prezime) {
        this.prezime = prezime;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTelefon(int telefon) {
        this.telefon = telefon;
    }

    public void setTipKorisnika(String tipKorisnika) {
        this.tipKorisnika = tipKorisnika;
    }

    public void setKorinickoIme(String korinickoIme) {
        this.korinickoIme = korinickoIme;
    }

    public void setLozinka(String lozinka) {
        this.lozinka = lozinka;
    }

    public void setIdPumpe(int idPumpe) {
        this.idPumpe = idPumpe;
    }

    public int getPoeni() {
        return poeni;
    }

    public void setPoeni(int poeni) {
        this.poeni = poeni;
    }

}
