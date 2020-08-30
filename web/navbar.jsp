<%-- 
    Document   : navbar
    Created on : Jun 14, 2020, 4:55:20 PM
    Author     : nikola
--%>

<%@page import="binovi.Korisnik" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" >
        <style>

            nav{
                background-color: #020045;
            }

            #naziv{
                color: white;
                margin-right: 20px;
            }

            #logo{
                margin-left: 110px;
                height: 38px;
                width: 40px;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg fixed-top">
            <ul class="navbar-nav mr-auto mt-lg-0">
                <li class="nav-item">
                    <a href="index.jsp">
                        <img src="Slike/logo.png" id="logo" alt="logo">
                    </a>
                </li>
                <li>
                    <a href="index.jsp">
                        <h3 id="naziv">PunGas</h3>
                    </a>
                </li>
                <%
                    Korisnik korisnik = (Korisnik) request.getSession().getAttribute("k");

                    if (korisnik == null) {
                %>
                <li class="nav-item">
                    <a href="prijava.jsp" class="btn btn-secondary btn-md ml-3">Prijava</a>
                </li>
                <li>
                    <a href="registracija.jsp" class="btn btn-secondary btn-md ml-3">Registracija</a>
                </li>
                <% } else if (korisnik.getTipKorisnika().equals("Korisnik")) {%>                                   <!-- KUPAC -->
                <li>
                    <form action="proslediProfil" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdKorisnika()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Profil">
                    </form>
                </li>
                <li>
                    <a href="odjava" class="btn btn-danger btn-md ml-3">Odjava</a>
                </li>
                <% } else if (korisnik.getTipKorisnika().equals("Menadzer")) {%>                                <!-- MENADZER -->
                <li>
                    <form action="proslediProfil" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdKorisnika()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Profil">
                    </form>
                </li>
                <li>
                    <form action="prodavciPumpe" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdPumpe()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Prodavci">
                    </form>
                </li>
                <li>
                    <form action="racuniPumpe" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdPumpe()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Računi">
                    </form>
                </li>
                <li>
                    <form action="narudzbenicePumpe" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdPumpe()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Narudžbenice">
                    </form>
                </li>
                <li>
                    <a href="odjava" class="btn btn-danger btn-md ml-3">Odjava</a>
                </li>
                <% } else if (korisnik.getTipKorisnika().equals("Administrator")) {%>                           <!-- ADMINISTRATOR -->
                <li>
                    <form action="proslediProfil" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdKorisnika()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Profil">
                    </form>
                </li>
                <li>
                    <form action="proslediRadnike" method="post">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Radnici">
                    </form>
                </li>
                <li>
                    <form action="listaRacuna" method="post">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Računi">
                    </form>
                </li>
                <li>
                    <form action="listaNarudzbenica" method="post">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Narudžbenice">
                    </form>
                </li>
                <li>
                    <a href="odjava" class="btn btn-danger btn-md ml-3">Odjava</a>
                </li>
                <% } else if (korisnik.getTipKorisnika().equals("Rukovodilac")) {%>                             <!-- RUKOVODILAC -->
                <li>
                    <form action="proslediProfil" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdKorisnika()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Profil">
                    </form>
                </li>
                <li>
                    <form action="proslediFirmu" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdKorisnika()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Narudžbenice">
                    </form>
                </li>
                <li>
                    <a href="odjava" class="btn btn-danger btn-md ml-3">Odjava</a>
                </li>
                <% } else if (korisnik.getTipKorisnika().equals("Prodavac")) {%>                                <!-- PRODAVAC -->
                <li>
                    <form action="racuniProdavca" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdKorisnika()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Računi">
                    </form>
                </li>
                <li>
                    <form action="narudzbenicePumpe" method="post">
                        <input type="hidden" name="sifra" value="<%=korisnik.getIdPumpe()%>">
                        <input type="submit" class="btn btn-secondary btn-md ml-3" value="Narudžbenice">
                    </form>
                </li>
                <li>
                    <a href="odjava" class="btn btn-danger btn-md ml-3">Odjava</a>
                </li>
                <% }%>
            </ul>
        </nav>
    </body>
</html>
