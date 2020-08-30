<%-- 
    Document   : dodajRadnika
    Created on : Aug 13, 2020, 11:31:45 AM
    Author     : nikol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dodavanje novog radnika</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .container{
                margin-top: 120px;
                color: white;
            }

            .sredina{
                margin-bottom: 30px;
                padding: 30px;
                width: 700px;
            }

            table{
                margin: 30px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="container" align="center">
            <div class="sredina bg-secondary rounded" align="center">
                <h1 id="naslov">Unesite podatke o novom radniku</h1>
                <form action="dodajRadnika" method="post">
                    <table>
                        <tr>
                            <td>Ime: </td>
                            <td><input type="" required name="ime"></td>
                        </tr>
                        <tr>
                            <td>Prezime: </td>
                            <td><input type="" required name="prezime"></td>
                        </tr>
                        <tr>
                            <td>Email adresa: </td>
                            <td><input type="" required name="email"></td>
                        </tr>
                        <tr>
                            <td>Korisničko ime: </td>
                            <td><input type="" required name="korisnickoIme"></td>
                        </tr>
                        <tr>
                            <td>Lozinka: </td>
                            <td><input type="" required name="lozinka"></td>
                        </tr>
                        <tr>
                            <td>Broj telefona: </td>
                            <td><input type="" required name="telefon"></td>
                        </tr>
                        <%
                            if (korisnik.getTipKorisnika().equals("Administrator")) {
                        %>
                        <tr>
                            <td>Šifra pumpe: </td>
                            <td><input type="text" required name="pumpa"></td>
                        </tr>
                        <%}%>
                    </table>
                    <%
                        if (korisnik.getTipKorisnika().equals("Menadzer")) {
                    %>
                    <input type="hidden" name="pumpa" value="<%=korisnik.getIdPumpe()%>">
                    <%}%>
                    <input type="submit" class="btn btn-success btn-lg" value="Dodaj radnika">
                </form>
            </div>
        </div>
    </body>
</html>
