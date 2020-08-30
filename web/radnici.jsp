<%-- 
    Document   : radnici
    Created on : Aug 12, 2020, 10:42:56 PM
    Author     : nikol
--%>

<%@page import="java.util.ArrayList" %>
<%@page import="binovi.Korisnik" %>
<%@page import="binovi.Pumpa" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Radnici</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .okvir{
                width: 920px;
                margin-top: 120px;
                color: white;
                padding-top: 30px;
                padding-bottom: 30px;
                margin-bottom: 30px;
            }

            #red{
                padding-left: 70px;
            }

            .radnik{
                background-color: darkslategray;
                width: 250px;
                margin: 10px;
                padding: 10px;
            }

            #dugme{
                margin: 20px;
            }

            #dugmici{
                padding-left: 25px;
                margin: 5px;
                width: 100%
            }

            #forma{
                margin-left: 10px;
            }

            .sredina{
                margin-top: 120px;
                color: white;
            }

            .prodavci{
                width: 900px;
                padding: 30px;
            }

            .row{
                width: 1000px;
                margin: 30px;
            }

            .prodavac{
                width: 250px;
                height: 170px;
                padding: 10px;
                background-color: darkslategray;
                margin: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <%
            if (korisnik.getTipKorisnika().equals("Administrator")) {
        %>
        <div class="container" align="center">
            <div class="okvir bg-secondary rounded" align="center">
                <h1 id="naslov">Spisak svih radnika i menadžera</h1>
                <a href="dodajRadnika.jsp" id="dugme" class="btn btn-success btn-lg">Dodaj novog radnika</a>
                <div class="row" id="red" align="center">
                    <%
                        ArrayList<Korisnik> lista = (ArrayList<Korisnik>) request.getAttribute("lista");

                        for (Korisnik k : lista) {
                    %>
                    <div class="radnik rounded">
                        <table>
                            <tr>
                                <td>Ime: </td>
                                <td><%=k.getIme()%></td>
                            </tr>
                            <tr>
                                <td>Prezime: </td>
                                <td><%=k.getPrezime()%></td>
                            </tr>
                            <tr>
                                <td>Korisničko ime: </td>
                                <td><%=k.getKorinickoIme()%></td>
                            </tr>
                            <tr>
                                <td>Tip radnika: </td>
                                <td><%=k.getTipKorisnika()%></td>
                            </tr>
                            <tr>
                                <td>Šifra pumpe: </td>
                                <td><%=k.getIdPumpe()%></td>
                            </tr>
                        </table>
                        <div class="row" id="dugmici">
                            <form action="proslediRadnika" id="forma" method="post">
                                <input type="hidden" name="sifra" value="<%=k.getIdKorisnika()%>">
                                <input type="submit" class="btn btn-warning btn-md" value="Izmeni">
                            </form>
                            <form action="ukloniRadnika" id="forma" method="post">
                                <input type="hidden" name="sifra" value="<%=k.getIdKorisnika()%>">
                                <input type="submit" class="btn btn-danger btn-md" value="Ukloni">
                            </form>
                        </div>
                    </div>
                    <% }%>
                </div>
            </div>
        </div>
        <% } else if (korisnik.getTipKorisnika().equals("Menadzer")) {%>
        <div class="sredina" align="center">
            <div class="prodavci bg-secondary rounded">
                <h1 id="naslov">Lista prodavaca na pumpi</h1>
                <br>
                <a href="dodajRadnika.jsp" id="dugme" class="btn btn-success btn-lg">Dodaj novog radnika</a>
                <div class="row">
                    <%
                        ArrayList<Korisnik> lista = (ArrayList<Korisnik>) request.getAttribute("lista");

                        for (Korisnik k : lista) {
                    %>
                    <div class="prodavac rounded">
                        <table>
                            <tr>
                                <td>Ime: </td>
                                <td><%=k.getIme()%></td>
                            </tr>
                            <tr>
                                <td>Prezime: </td>
                                <td><%=k.getPrezime()%></td>
                            </tr>
                            <tr>
                                <td>Korisničko ime: </td>
                                <td><%=k.getKorinickoIme()%></td>
                            </tr>
                            <tr>
                                <td>Tip korisnika: </td>
                                <td><%=k.getTipKorisnika()%></td>
                            </tr>
                            <tr>
                                <td>Šifra pumpe: </td>
                                <td><%=k.getIdPumpe()%></td>
                            </tr>
                        </table>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
        <%}%>
    </body>
</html>
