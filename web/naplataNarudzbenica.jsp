<%-- 
    Document   : naplataNarudzbenica
    Created on : Aug 27, 2020, 6:06:25 PM
    Author     : nikol
--%>

<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Naplata narudzbenica</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .container{
                margin-top: 120px;
                color: white;
            }

            .row{
                width: 100%;
            }

            .naplata{
                width: 500px;
                padding: 20px;
                margin-left: 100px;
                margin-bottom: 40px;
            }

            .lista{
                margin-left: 100px;
                width: 300px;
                padding: 20px;
                margin-bottom: 40px;
            }

            .narudzbenica{
                background-color: darkslategray;
                padding: 10px;
                margin: 10px;
            }

            .container a{
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="container" align="center">
            <a href="index.jsp" class="btn btn-secondary btn-lg">Neregistrovani korisnici</a>
            <form action="proslediKorisnika" method="post" style="margin-bottom: 10px;">
                <b>Unesite šifru korisnika: </b>
                <input type="text" name="sifra" required style="width:50px;">
                <input type="submit" class="btn btn-secondary btn-lg" value="Prijavljeni korisnici">
            </form>
            <div class="row">
                <div class="naplata bg-secondary rounded">
                    <h1 style="padding: 20px;">Unesite podatke za naplatu narudžbenice</h1>
                    <form action="dodajRacun" method="post">
                        <table>
                            <tr>
                                <td><b>Šifra narudžbenice: </b></td>
                                <td><input type="text" name="narudzbenica"></td>
                            </tr>
                            <tr>
                                <td><b>Količina sipanog goriva: </b></td>
                                <td><input type="text" name="kolicina" id="kolicina"> litara</td>
                            </tr>
                            <tr>
                                <td><b>Vrsta goriva: </b></td>
                                <td>
                                    <select name="gorivo" id="gorivo" onclick="racunajCenu()">
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
                        <div class="kartica">
                            <h3>Podaci o firmi</h3>
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

                        <input type="hidden" name="kupac" value="">
                        <input type="hidden" name="datum" id="date">
                        <input type="hidden" name="vreme" id="time">
                        <input type="hidden" name="pumpa" value="<%=korisnik.getIdPumpe()%>">
                        <input type="hidden" name="prodavac" value="<%=korisnik.getIdKorisnika()%>">

                        <br>
                        <input type="submit" class="btn btn-success btn-lg" style="margin-bottom: 30px;" value="Naplata">
                    </form>
                </div>
                <div class="lista bg-secondary rounded">
                    <h2 style="margin-top: 20px; margin-bottom: 20px;">Lista narudžbenica</h2>
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection kon = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                        Statement st = kon.createStatement();

                        String funk = "SELECT * FROM narudzbenica WHERE idPumpe = '" + korisnik.getIdPumpe() + "' AND naplaceno = 'ne'";

                        ResultSet rss = st.executeQuery(funk);

                        while (rss.next()) {
                    %>
                    <div class="narudzbenica rounded">
                        <table id="nar">
                            <tr>
                                <td>Šifra narudžbenice: </td>
                                <td><%=rss.getInt("idNarudzbenice")%></td>
                            </tr>
                            <tr>
                                <td>Količina: </td>
                                <td><%=rss.getInt("kolicina")%></td>
                            </tr>
                            <tr>
                                <td>Vrsta goriva: </td>
                                <td><%=rss.getString("nazivGoriva")%></td>
                            </tr>
                        </table>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>

        
        <script>
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
        </script> <script>
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            today = yyyy + '-' + mm + '-' + dd;
            document.getElementById('date').value = today;
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
                t = setTimeout(function () {
                    startTime();
                }, 500);
            }
            startTime();
        </script>
    </body>
</html>
