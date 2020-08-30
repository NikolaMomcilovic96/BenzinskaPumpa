<%-- 
    Document   : racuni
    Created on : Jun 24, 2020, 8:33:54 PM
    Author     : nikola
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@page import="java.util.ArrayList" %>
        <%@page import="binovi.Racun" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Računi</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .sredina{
                margin-top: 120px;
                color: white;
                margin-left: 250px;
                margin-right: 250px;
                padding-top: 20px; 
                padding-bottom: 20px;
                margin-bottom: 40px;
            }

            .row{
                width: 100%;

            }

            .racun{
                background-color: darkslategray;
                margin: 20px;
                padding: 20px;
                margin-left: 40px;
                width: 270px;
            }

            #naslov{
                margin: 20px;
            }

            #poruka{
                margin-left: 300px;
                margin-top: 50px;
                margin-bottom: 40px;
            }

            #porukaA{
                margin-left: 300px;
            }

            #porukaP{
                margin-left: 300px;
                margin-top: 50px;
                margin-bottom: 30px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="sredina bg-secondary rounded" align="center">
            <h1 id="naslov">Lista računa</h1>


            <div class="row" align="center">
                <%
                    if (korisnik.getTipKorisnika().equals("Administrator")) {

                        ArrayList<Racun> listaR = (ArrayList<Racun>) request.getAttribute("listaR");

                        if (listaR.isEmpty()) {%>
                <h3 id="porukaA">Još uvek nema računa</h3>
                <%}

                    for (Racun r : listaR) {
                %>
                <div class="racun rounded">
                    <table>
                        <tr>
                            <td>Šifra računa: </td>
                            <td><%=r.getIdRacuna()%></td>
                        </tr>
                        <tr>
                            <td>Šifra pumpe: </td>
                            <td><%=r.getIdPumpe()%></td>
                        </tr>
                        <tr>
                            <td>Šifra prodavca: </td>
                            <td><%=r.getIdProdavca()%></td>
                        </tr>
                        <tr>
                            <td>Šifra korisnika: </td>
                            <td><%=r.getIdKorisnika()%></td>
                        </tr>
                        <tr>
                            <td>Šifra narudžbenice: </td>
                            <td><%=r.getIdNarudzbenice()%></td>
                        </tr>
                        <tr>
                            <td>Sipana količina: </td>
                            <td><%=r.getKolicina()%></td>
                        </tr>
                        <tr>
                            <td>Vrsta goriva: </td>
                            <td><%=r.getGorivo()%></td>
                        </tr>
                        <tr>
                            <td>Ukupna cena: </td>
                            <td><%=r.getCena()%></td>
                        </tr>
                        <tr>
                            <td>Datum: </td>
                            <td><%=r.getDatum()%></td>
                        </tr>
                        <tr>
                            <td>Vreme: </td>
                            <td><%=r.getVreme()%></td>
                        </tr>
                    </table>
                </div>
                <% }
                } else if (korisnik.getTipKorisnika().equals("Menadzer")) {

                    ArrayList<Racun> listaP = (ArrayList<Racun>) request.getAttribute("listaPumpe");

                    if (listaP.isEmpty()) {%>
                <h3 id="poruka">Još uvek nema računa na vašoj pumpi</h3>
                <%}

                    for (Racun l : listaP) {
                %>
                <div class="racun rounded">
                    <table>
                        <tr>
                            <td>Šifra računa: </td>
                            <td><%=l.getIdRacuna()%></td>
                        </tr>
                        <tr>
                            <td>Šifra pumpe: </td>
                            <td><%=l.getIdPumpe()%></td>
                        </tr>
                        <tr>
                            <td>Šifra prodavca: </td>
                            <td><%=l.getIdProdavca()%></td>
                        </tr>
                        <tr>
                            <td>Šifra korisnika: </td>
                            <td><%=l.getIdKorisnika()%></td>
                        </tr>
                        <tr>
                            <td>Šifra narudžbenice: </td>
                            <td><%=l.getIdNarudzbenice()%></td>
                        </tr>
                        <tr>
                            <td>Sipana količina: </td>
                            <td><%=l.getKolicina()%></td>
                        </tr>
                        <tr>
                            <td>Vrsta goriva: </td>
                            <td><%=l.getGorivo()%></td>
                        </tr>
                        <tr>
                            <td>Ukupna cena: </td>
                            <td><%=l.getCena()%></td>
                        </tr>
                        <tr>
                            <td>Datum: </td>
                            <td><%=l.getDatum()%></td>
                        </tr>
                        <tr>
                            <td>Vreme: </td>
                            <td><%=l.getVreme()%></td>
                        </tr>
                    </table>
                </div>
                <% }
                } else if (korisnik.getTipKorisnika().equals("Prodavac")) {

                    ArrayList<Racun> lista = (ArrayList<Racun>) request.getAttribute("listaP");

                    if (lista.isEmpty()) {
                %>
                <h3 id="porukaP">Još uvek niste naplatili ni jedan račun</h3>
                <%}
                    for (Racun r : lista) {
                %>
                <div class="racun rounded">
                    <table>
                        <tr>
                            <td>Šifra računa: </td>
                            <td><%=r.getIdRacuna()%></td>
                        </tr>
                        <tr>
                            <td>Šifra pumpe: </td>
                            <td><%=r.getIdPumpe()%></td>
                        </tr>
                        <tr>
                            <td>Šifra prodavca: </td>
                            <td><%=r.getIdProdavca()%></td>
                        </tr>
                        <tr>
                            <td>Šifra korisnika: </td>
                            <td><%=r.getIdKorisnika()%></td>
                        </tr>
                        <tr>
                            <td>Šifra narudžbenice: </td>
                            <td><%=r.getIdNarudzbenice()%></td>
                        </tr>
                        <tr>
                            <td>Količina: </td>
                            <td><%=r.getKolicina()%></td>
                        </tr>
                        <tr>
                            <td>Vrsta goriva: </td>
                            <td><%=r.getGorivo()%></td>
                        </tr>
                        <tr>
                            <td>Ukupna cena: </td>
                            <td><%=r.getCena()%></td>
                        </tr>
                        <tr>
                            <td>Datum: </td>
                            <td><%=r.getDatum()%></td>
                        </tr>
                        <tr>
                            <td>Vreme: </td>
                            <td><%=r.getVreme()%></td>
                        </tr>
                    </table>
                </div>

                <% }
                    }%>

            </div>
        </div>
    </body>
</html>
