package binovi;

public class Gorivo {
    private int idCena;
    private int cena95;
    private int cena98;
    private int cenaDizel;
    private int cenaPlin;
    private int idPumpe;

    public Gorivo() {
    }

    public Gorivo(int idCena, int cena95, int cena98, int cenaDizel, int cenaPlin, int idPumpe) {
        this.idCena = idCena;
        this.cena95 = cena95;
        this.cena98 = cena98;
        this.cenaDizel = cenaDizel;
        this.cenaPlin = cenaPlin;
        this.idPumpe = idPumpe;
    }

    public int getIdCena() {
        return idCena;
    }

    public int getCena95() {
        return cena95;
    }

    public int getCena98() {
        return cena98;
    }

    public int getCenaDizel() {
        return cenaDizel;
    }

    public int getCenaPlin() {
        return cenaPlin;
    }

    public int getIdPumpe() {
        return idPumpe;
    }

    public void setIdCena(int idCena) {
        this.idCena = idCena;
    }

    public void setCena95(int cena95) {
        this.cena95 = cena95;
    }

    public void setCena98(int cena98) {
        this.cena98 = cena98;
    }

    public void setCenaDizel(int cenaDizel) {
        this.cenaDizel = cenaDizel;
    }

    public void setCenaPlin(int cenaPlin) {
        this.cenaPlin = cenaPlin;
    }

    public void setIdPumpe(int idPumpe) {
        this.idPumpe = idPumpe;
    }
    
    
    
    
}
