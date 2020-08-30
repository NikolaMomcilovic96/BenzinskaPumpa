<%-- 
    Document   : naplataRegistrovanim
    Created on : Aug 27, 2020, 10:12:20 PM
    Author     : nikol
--%>

<%@page import="java.sql.*" %>
<%@page import="binovi.Korisnik" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Naplata korisnicima</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .container{
                color: white;
                margin-top: 120px;
            }

            .kes{
                margin-left: 200px;
            }

            #link{
                margin-bottom: 10px;
            }

            .naplata{
                width: 800px;
                margin-bottom: 40px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <%
            Korisnik k = (Korisnik) request.getAttribute("korisnik");
        %>

        <div class="container" align="center">
            <a href="index.jsp" id="link" class="btn btn-secondary btn-lg">Neregistrovani korisnici</a>
            <a href="naplataNarudzbenica.jsp" id="link" class="btn btn-secondary btn-lg">Narudzbenice</a>

            <div class="naplata bg-secondary rounded">
                <h1 style="padding: 20px;">Unesite podatke za naplatu</h1>
                <form action="dodajRacun" method="post">
                    <table>
                        <tr>
                            <td><b>Poeni korisnika: </b></td>
                            <td><input type="text" name="poeni" id="poeni" value="<%=k.getPoeni()%>"></td>
                        </tr>
                        <tr>
                            <td><b>Količina sipanog goriva: </b></td>
                            <td><input type="text" name="kolicina" id="kolicina"> litara</td>
                        </tr>
                        <tr>
                            <td><b>Vrsta goriva: </b></td>
                            <td>
                                <select name="gorivo" id="gorivo" onclick="pozivFunkcija()">
                                    <option value="1">BMB 95</option>
                                    <option value="2">BMB 98</option>
                                    <option value="3">Dizel</option>
                                    <option value="4">Plin</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Ukupno za naplatu: </b></td>
                            <td><input type="text" name="ukupno" id="ukupno" readonly> dinara</td>
                        </tr>
                    </table>
                    <br>
                    <button type="submit" disabled="true" form="platiPoenima" class="btn btn-success btn-md" id="dugme">Naplati poenima</button>
                    <br>
                    <div class="row">
                        <div class="kes">
                            <h3>Keš</h3>
                            <table>
                                <tr>
                                    <td><b>Plaćeno: </b></td>
                                    <td><input id="placeno" onfocusout="izracunajKusur()" style="width: 120px;"></td>
                                </tr>
                                <tr>
                                    <td><b>Kusur: </b></td>
                                    <td><input id="kusur" readonly style="width: 120px;"></td>
                                </tr>
                            </table>
                        </div>
                        <div class="kartica">
                            <h3>Kartica</h3>
                            <table>
                                <tr>
                                    <td><b>Broj računa: </b></td>
                                    <td><input type="text" style="width: 120px;"></td>
                                </tr>
                                <tr>
                                    <td><b>PIN: </b></td>
                                    <td><input type="password" style="width: 120px;"></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <input type="hidden" name="noviPoeni" id="noviPoeni">
                    <input type="hidden" name="narudzbenica" value="">
                    <input type="hidden" name="kupac" value="<%=k.getIdKorisnika()%>">
                    <input type="hidden" name="datum" id="date">
                    <input type="hidden" name="vreme" id="time">
                    <input type="hidden" name="pumpa" value="<%=korisnik.getIdPumpe()%>">
                    <input type="hidden" name="prodavac" value="<%=korisnik.getIdKorisnika()%>">

                    <br>
                    <input type="submit" class="btn btn-success btn-lg" style="margin-bottom: 30px;" value="Naplata">
                </form>
                <form action="platiPoenima" id="platiPoenima" method="post">
                    <input type="hidden" name="noviPoeni" id="noviPoeni2">
                    <input type="hidden" name="narudzbenica" value="">
                    <input type="hidden" name="kupac" value="<%=k.getIdKorisnika()%>">
                    <input type="hidden" name="datum" id="date2">
                    <input type="hidden" name="vreme" id="time2">
                    <input type="hidden" name="pumpa" value="<%=korisnik.getIdPumpe()%>">
                    <input type="hidden" name="prodavac" value="<%=korisnik.getIdKorisnika()%>">
                    <input type="hidden" name="gorivo" id="gorivo2">
                    <input type="hidden" name="kolicina" id="kolicina2">
                    <input type="hidden" name="cena" id="ukupno2">
                </form>
            </div>
        </div>
        <script>
            function pozivFunkcija() {
                racunanjePoena();
                racunajCenu();
                prikaziDugme();
            }

            function racunanjePoena() {
                var gorivo = parseInt(document.getElementById('gorivo').value);
                var kolicina = parseInt(document.getElementById('kolicina').value);
                var trenutniPoeni = parseInt(document.getElementById('poeni').value);


                if (gorivo === 1)
                    document.getElementById('noviPoeni').value = trenutniPoeni + (kolicina * 3);
                else if (gorivo === 2)
                    document.getElementById('noviPoeni').value = trenutniPoeni + (kolicina * 5);
                else if (gorivo === 3)
                    document.getElementById('noviPoeni').value = trenutniPoeni + (kolicina * 4);
                else if (gorivo === 4)
                    document.getElementById('noviPoeni').value = trenutniPoeni + (kolicina * 2);
            }

            function izracunajKusur() {
                var placeno = parseInt(document.getElementById('placeno').value);
                var ukupno = parseInt(document.getElementById('ukupno').value);

                document.getElementById('kusur').value = placeno - ukupno;
            }

            function racunajCenu() {
            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                Statement stmt = con.createStatement();

                String upit = "SELECT * FROM gorivo WHERE idPumpe = '" + korisnik.getIdPumpe() + "'";

                ResultSet rs = stmt.executeQuery(upit);

                if (rs.next()) {
            %>
                var cena95 = <%=rs.getInt("cena95")%>;
                var cena98 = <%=rs.getInt("cena98")%>;
                var cenaDizel = <%=rs.getInt("cenaDizel")%>;
                var cenaPlin = <%=rs.getInt("cenaPlin")%>;
            <%
                }
            %>
                var kolicina = parseInt(document.getElementById('kolicina').value);
                var gorivo = parseInt(document.getElementById('gorivo').value);

                if (gorivo === 1) {
                    document.getElementById('ukupno').value = cena95 * kolicina;
                } else if (gorivo === 2) {
                    document.getElementById('ukupno').value = cena98 * kolicina;
                } else if (gorivo === 3) {
                    document.getElementById('ukupno').value = cenaDizel * kolicina;
                } else if (gorivo === 4) {
                    document.getElementById('ukupno').value = cenaPlin * kolicina;
                }
            }

            function prikaziDugme() {
                var ukupno = parseInt(document.getElementById('ukupno').value);
                var poeni = parseInt(document.getElementById('poeni').value);
                var kolicina = parseInt(document.getElementById('kolicina').value);
                var gorivo = parseInt(document.getElementById('gorivo').value);
                var ukupno = parseInt(document.getElementById('ukupno').value);
                var zaradjeniPoeni = 0;

                if (poeni > ukupno) {
                    document.getElementById('dugme').disabled = false;
                    document.getElementById('kolicina2').value = kolicina;
                    document.getElementById('ukupno2').value = ukupno;
                    document.getElementById('gorivo2').value = gorivo;

                    if (gorivo === 1)
                        zaradjeniPoeni = kolicina * 3;
                    else if (gorivo === 2)
                        zaradjeniPoeni = kolicina * 5;
                    else if (gorivo === 3)
                        zaradjeniPoeni = kolicina * 4;
                    else if (gorivo === 4)
                        zaradjeniPoeni = kolicina * 2;

                    document.getElementById('noviPoeni2').value = poeni - ukupno + zaradjeniPoeni;
                }
            }
        </script> <script>
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            today = yyyy + '-' + mm + '-' + dd;
            document.getElementById('date').value = today;
            document.getElementById('date2').value = today;
        </script>

        <script>
            function checkTime(i) {
                if (i < 10) {
                    i = "0" + i;
                }
                return i;
            }

            function startTime() {
                var today = new Date();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                m = checkTime(m);
                s = checkTime(s);
                document.getElementById('time').value = h + ":" + m + ":" + s;
                document.getElementById('time2').value = h + ":" + m + ":" + s;
                t = setTimeout(function () {
                    startTime();
                }, 500);
            }
            startTime();
        </script>
    </body>
</html>
