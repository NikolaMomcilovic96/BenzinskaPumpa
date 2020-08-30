<%-- 
    Document   : index
    Created on : Jun 14, 2020, 3:33:11 PM
    Author     : nikola
--%>

<%@page import="binovi.Pumpa" %>
<%@page import="binovi.Firma" %>
<%@page import="binovi.Gorivo" %>
<%@page import="binovi.Narudzbenica" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.3.1/css/ol.css" type="text/css">
        <link href="https://openlayers.org/en/v4.6.4/css/ol.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://openlayers.org/en/v4.6.4/build/ol-debug.js"></script>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .col-xl-6{
                margin-left: 120px;
                color: white;
            }
            
            .pogodnosti{
                margin-bottom: 10px;
                padding: 20px;
            }
            
            .pogodnosti a{
                color: black;
            }

            .map {
                height: 450px;
                width: 100%;
            }

            .row{
                width: 100%;
            }

            .adrese{
                margin-left: 80px;
                width: 450px;
                color: white;
                padding-top: 40px;
                padding-bottom: 40px;
                margin-bottom: 30px;
            }

            #pumpa{
                padding-top: 5px;
                width: 300px;
                margin-top: 40px;
                background-color: darkslategrey;
                color: white;
                padding-bottom: 10px;
            }

            #dugme{
                margin-top: 10px;
            }

            .narudzbina{
                margin-left: 100px;
                width: 650px;
                padding-bottom: 30px;
                color: white;
                padding-top: 30px;
            }

            #odabir{
                width: 100px;
                height: 30px;
                background-color: greenyellow;
            }

            table{
                margin-top: 30px;
                margin-bottom: 40px;
            }

            .obavestenje{
                margin-top: 120px;
                color: white;
            }

            .link{
                color: white;
                padding: 30px;
            }

            .link a{
                margin-top: 30px;
            }

            .sredina{
                margin-left: 300px;
                margin-right: 300px;
                color: white;
                padding-top: 20px;
                padding-bottom: 40px;
                margin-bottom: 50px;
            }

            .sredina table{
                margin: 20px;
            }

            .pumpa{
                background-color: darkslategray;
                width: 360px;
                margin-top: 30px;
                margin-left: 60px;
                padding-bottom: 10px;
            }

            .prodavac{
                margin-top: 20px;
                color: white;
            }

            .polje{
                width: 600px;
                margin-top: 20px;
                margin-bottom: 40px;
            }

            .info{
                width: 550px;
                color: white;
                padding: 10px;
                padding-bottom: 30px;
            }

            #polje{
                width: 150px;
            }

            #kolicina, #ukupno {
                width: 100px;
            }

            select{
                width: 100px;
            }

            .kes{
                margin-left: 60px;
            }

            .kartica{
                margin-left: 60px;
            }

            #nar{
                margin: 10px;
            }

            .dodaj{
                margin: 5px;
            }

            .cene{
                margin: 5px;
                margin-left: 40px;
            }

            .ukloni{
                margin: 5px;
            }

            .menadzer{
                margin: 5px;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.3.1/build/ol.js"></script>
        <title>Dobrodošli</title>
    </head>
    <body>

        <%@include file = "navbar.jsp"%>

        <div class="obavestenje" align="center">
            <h3>
                <%
                    String poruka = (String) request.getAttribute("poruka");
                    if (poruka != null) {
                %>
                <%= poruka%>
                <%
                    }
                %>
            </h3>
        </div>


        <% if (korisnik == null || korisnik.getTipKorisnika().equals("Korisnik")) {%>                                          <!-- NEULOGOVANI KORISNIK I KUPAC-->
        <div class="row" style="margin-top: 120px;">
            <div class="col-xl-6">
                <div class="pogodnosti bg-secondary rounded">
                    <i>Ukoliko se registrujete, ostvarujete pogodnost da svakom kupovinom bilo kojeg goriva, dobijate na račun odredjeni broj poena.
                        Za jedan litar BMB 95 dobijate 3 poena, za jedan BMB 98 dobijate 5 poena, za jedan litar Dizela dobijate 4 poena, za jedan litar Plina dobijate 2 poena.
                        Kada skupite veće količine poena, možete ih koristiti da platite gorivo koje ste sipali. <a href="registracija.jsp">Registrujte se</a>.
                    </i>
                </div>
                <div id="map" class="map"></div>
            </div>
            <div class="col-xl-4" align="center">
                <div class="adrese bg-secondary rounded">

                    <h3>Informacije o našim pumpama:</h3>
                    <%                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                        Statement stmt = con.createStatement();

                        ResultSet rs = null;

                        String upit = "SELECT * FROM pumpa";

                        try {
                            rs = stmt.executeQuery(upit);

                            while (rs.next()) {
                    %>
                    <div id="pumpa" class="rounded">
                        <form action="proslediCene" method="post">
                            <h5><b><%=rs.getString("naziv")%></b></h5>
                            <b>Adresa: <%=rs.getString("adresa")%></b><br>
                            <input type="hidden" name="sifra" value="<%=rs.getInt("idPumpe")%>">
                            <input type="submit" class="btn btn-info btn-md" id="dugme" value="Pogledajte cene"> 
                        </form>
                    </div>
                    <%}
                        } catch (Exception e) {
                            request.setAttribute("msg", e.getMessage());
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }

                        rs.close();
                        stmt.close();
                        con.close();
                    %>

                </div>
            </div>
        </div>
        <% } else if (korisnik.getTipKorisnika().equals("Rukovodilac")) {%>                                                 <!-- RUKOVODILAC -->

        <div class="row" style="margin-top: 120px;">
            <div class="col-xl-6">
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                    Statement stmt = con.createStatement();

                    String upit = "SELECT * FROM firma WHERE idRukovodioca = '" + korisnik.getIdKorisnika() + "'";

                    ResultSet rs = stmt.executeQuery(upit);

                    if (rs.next()) {
                %>
                <div class="narudzbina bg-secondary rounded" align="center">
                    <h2>Želite da naručite veću količinu goriva za vašu firmu?</h2>

                    <form action="dodajNarudzbenicu" method="post">

                        <table>
                            <tr>
                                <td><b>Odaberite vrstu goriva: </b></td>
                                <td><select name="gorivo" id="odabir">
                                        <option value="BMB 95">BMB 95</option>
                                        <option value="BMB 98">BMB 98</option>
                                        <option value="Dizel">Dizel</option>
                                        <option value="Plin">Plin</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Unesite količinu goriva koja vam je potrebna: </b></td>
                                <td><input required oninvalid="this.setCustomValidity('Morate uneti količinu goriva')" oninput="this.setCustomValidity('')" type="text" name="kolicina" id="polje"></td>
                            </tr>
                            <tr>
                                <td><b>Unesite datum kada želite da dobijete gorivo: </b></td>
                                <td><input required oninvalid="this.setCustomValidity('Morate uneti datum dostave')" oninput="this.setCustomValidity('')" type="text" name="datum" placeholder="format GGGG-MM-DD" id="polje"></td>
                            </tr>
                            <tr>
                                <td><b>Unesite šifru pumpe na koju želite da dobijete gorivo: </b></td>
                                <td><input required oninvalid="this.setCustomValidity('Morate uneti pumpu na koju će biti dostavljeno gorivo')" oninput="this.setCustomValidity('')" type="text" name="pumpa" id="polje"></td>
                            </tr>
                        </table>
                        <input type="hidden" name="sifra" value="<%=rs.getInt("idFirme")%>">
                        <input type="submit" class="btn btn-success btn-lg" id="dugmeNaruci" value="Naruči">
                    </form>
                </div>
                <% } else {%>
                <div class="link bg-secondary rounded" align="center">
                    <h3>Trenutno nemate registrovanu firmu.
                        <br>
                        <br>Kliknite na dugme Registracija, u delu za firme unesite podatke vaše firme da bi je registrovali.</h3>
                    <a href="registracija.jsp" class="btn btn-info btn-lg">Registracija</a>
                </div>
                <%  }%>
            </div>


            <div class="col-xl-5" align="center">
                <div class="adrese bg-secondary rounded">

                    <h3>Informacije o našim pumpama:</h3>
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection kon = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                        Statement st = kon.createStatement();

                        ResultSet rss = null;

                        String upit2 = "SELECT * FROM pumpa";

                        try {
                            rss = st.executeQuery(upit2);

                            while (rss.next()) {
                    %>
                    <div id="pumpa" class="rounded">
                        <form action="proslediCene" method="post">
                            <h5><b><%=rss.getString("naziv")%></b></h5>
                            <b>Šifra: <%=rss.getInt("idPumpe")%></b><br>
                            <b>Adresa: <%=rss.getString("adresa")%></b><br>
                            <input type="hidden" name="sifra" value="<%=rss.getInt("idPumpe")%>">
                            <input type="submit" class="btn btn-info btn-md" id="dugme" value="Pogledajte cene"> 
                        </form>
                    </div>
                    <%}
                        } catch (Exception e) {
                            request.setAttribute("msg", e.getMessage());
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }

                        rss.close();
                        st.close();
                        kon.close();
                    %>
                </div>
            </div>           
        </div>
        <% } else if (korisnik.getTipKorisnika().equals("Administrator")) {%>                                               <!-- ADMINISTRATOR -->

        <div class="sredina bg-secondary rounded" align="center">
            <h1 id="naslov" style="margin-bottom: 30px;">Lista pumpi</h1>
            <a href="dodajPumpu.jsp" class="btn btn-success btn-lg">Dodaj pumpu</a
            <br><br>
            <b><i>Da bi ste uklonili pumpu morate prvo ukloniti cene, radnike i menadzera.</i></b>
            <div class="row">
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                    Statement stmt = con.createStatement();

                    String upit = "SELECT * FROM pumpa";

                    ResultSet rs = stmt.executeQuery(upit);

                    while (rs.next()) {
                %>
                <div class="pumpa rounded">

                    <table>
                        <tr>
                            <td><b>Naziv pumpe: </b></td>
                            <td><b><%=rs.getString("naziv")%></b></td>
                        </tr>
                        <tr>
                            <td>Šifra pumpe: </td>
                            <td><%=rs.getInt("idPumpe")%></td>
                        </tr>
                        <tr>
                            <td>Adresa: </td>
                            <td><%=rs.getString("adresa")%></td>
                        </tr>
                        <tr>
                            <td>Šifra menadžera: </td>
                            <td><%=rs.getInt("idMenadzera")%></td>
                        </tr>
                    </table>
                    <div class="row" style="margin-left: 10px;">
                        <div class="cene">
                            <form action="proslediCene" method="post">
                                <input type="hidden" name="sifra" value="<%=rs.getInt("idPumpe")%>">
                                <input type="submit" id="dugmePumpa" class="btn btn-info btn-md" value="Cene goriva">
                            </form>
                        </div>
                        <div class="ukloniCene" style="margin: 5px;">
                            <form action="ukloniCene" method="post">
                                <%
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                                    Statement stm = conn.createStatement();

                                    String cene = "SELECT * FROM gorivo WHERE idPumpe = '" + rs.getInt("idPumpe") + "'";

                                    ResultSet r = stm.executeQuery(cene);

                                    if (r.next()) {
                                %>
                                <input type="hidden" name="cene" value="<%=r.getInt("idCena")%>">
                                <input type="submit" class="btn btn-danger btn-md" value="Ukloni cene">
                                <%}%>
                            </form>
                        </div>
                        <div class="menadzer">
                            <form action="menadzerPumpe" method="post">
                                <input type="hidden" name="sifra" value="<%=rs.getInt("idPumpe")%>">
                                <input type="submit" class="btn btn-warning btn-md" value="Promena menadzera">
                            </form>
                        </div>
                        <div class="ukloni">
                            <form action="ukloniPumpu" method="post">
                                <input type="hidden" name="sifra" value="<%=rs.getInt("idPumpe")%>">
                                <input type="submit" class="btn btn-danger btn-md" value="Ukloni pumpu" onclick="potvrdaBrisanja()">
                            </form>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>

        <% } else if (korisnik.getTipKorisnika()
                .equals("Menadzer")) {%>                                                    <!-- MENADZER -->

        <div class="menadzer" align="center">
            <div class="info bg-secondary rounded">
                <img src="Slike/gas-station.png" style="width: 200px; height: 200px;">
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                    Statement stmt = con.createStatement();

                    String upit = "SELECT * FROM pumpa WHERE idMenadzera = '" + korisnik.getIdKorisnika() + "'";

                    ResultSet rs = stmt.executeQuery(upit);

                    if (rs.next()) {
                %>
                <h3 style="margin: 20px;">Naziv pumpe: <%=rs.getString("naziv")%></h3>

                <h5>Adresa: <%=rs.getString("adresa")%></h5>
                <% }%>

                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection kon = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                    Statement st = con.createStatement();

                    String cene = "SELECT * FROM gorivo WHERE idPumpe = '" + korisnik.getIdPumpe() + "'";

                    ResultSet r = stmt.executeQuery(cene);

                    if (r.next()) {
                %>
                <br>
                <form action="proslediCene" method="post">
                    <input type="hidden" name="sifra" value="<%=korisnik.getIdPumpe()%>">
                    <input type="submit" class="btn btn-info btn-lg" value="Cene goriva">
                </form>
                <br>

                <%
                } else {%>
                <br>
                <form action="dodajCene" method="post">
                    Dodavanje cena goriva za novu pumpu? <a href="dodajCene.jsp" class="btn btn-success btn-sm">Dodaj cene</a>
                </form>
                <br>
                <%}%>
            </div>
        </div>

        <% } else if (korisnik.getTipKorisnika()
                .equals("Prodavac")) {                              //PRODAVAC
        %>                                                   

        <div class="prodavac" align="center">

            <a href="naplataNarudzbenica.jsp" style="margin: 10px;" class="btn btn-secondary btn-lg">Narudžbenice</a>
            <form action="proslediKorisnika" method="post">
                <b>Unesite šifru korisnika: </b>
                <input type="text" name="sifra" required style="width:50px;" oninvalid="this.setCustomValidity('Morate uneti šifru korisnika')" oninput="this.setCustomValidity('')">
                <input type="submit" class="btn btn-secondary btn-lg" value="Prijavljeni korisnici">
            </form>

            <div class="polje bg-secondary rounded">
                <h1 style="padding: 20px;">Unesite podatke za naplatu za neregistrovane korisnike</h1>
                <form action="dodajRacun" method="post">
                    <table>
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

                    <input type="hidden" name="kupac" value="">
                    <input type="hidden" name="narudzbenica" value="">
                    <input type="hidden" name="datum" id="date">
                    <input type="hidden" name="vreme" id="time">
                    <input type="hidden" name="pumpa" value="<%=korisnik.getIdPumpe()%>">
                    <input type="hidden" name="prodavac" value="<%=korisnik.getIdKorisnika()%>">

                    <input type="submit" class="btn btn-success btn-lg" style="margin-bottom: 30px;" value="Naplata">
                </form>
                <h3>
                    <%
                        String greska = (String) request.getAttribute("greska");
                        if (greska != null) {
                    %>
                    <%= greska%>
                    <%
                        }
                    %>
                </h3>

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
        </script>
        <% }%>

        <script>
            function potvrdaBrisanja() {
                confirm('Ako ste sigurni da želite da uklonite pumpu, kliknite OK');
            }
        </script>

        <script>
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
        <script type="text/javascript">

            var iconFeature1 = new ol.Feature({
                geometry: new ol.geom.Point(ol.proj.fromLonLat([20.5622359, 44.7616693]), ),
                name: '1'
            });
            var iconFeature2 = new ol.Feature({
                geometry: new ol.geom.Point(ol.proj.fromLonLat([20.4187798, 44.7571848])),
                name: '2'
            });
            var iconFeature3 = new ol.Feature({
                geometry: new ol.geom.Point(ol.proj.fromLonLat([20.402586, 44.809004])),
                name: '3'
            });
            iconFeature2.setStyle(new ol.style.Style({
                image: new ol.style.Icon({
                    anchor: [0.5, 1],
                    src: 'https://img.icons8.com/doodle/48/000000/gas-station.png'
                })
            }));
            const iconLayerSource = new ol.source.Vector({
                features: [iconFeature1, iconFeature2, iconFeature3]
            });
            const iconLayer = new ol.layer.Vector({
                source: iconLayerSource,
                // style for all elements on a layer
                style: new ol.style.Style({
                    image: new ol.style.Icon({
                        anchor: [0.5, 1],
                        src: 'https://img.icons8.com/doodle/48/000000/gas-station.png'
                    })
                })
            });
            var map = new ol.Map({
                target: 'map',
                layers: [
                    new ol.layer.Tile({
                        source: new ol.source.OSM()
                    }),
                    iconLayer
                ],
                view: new ol.View({
                    center: ol.proj.fromLonLat([20.476934, 44.783965]),
                    zoom: 12
                })
            });
        </script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
