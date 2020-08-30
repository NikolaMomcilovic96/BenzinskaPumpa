<%-- 
    Document   : izmenaRadnika
    Created on : Aug 13, 2020, 9:06:32 AM
    Author     : nikol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Izmena radnika</title>
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
                width: 600px;
                padding: 30px;
            }
            
            table{
                margin: 30px;
            }

        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="container" align="center">
            <div class="sredina bg-secondary rounded">
                <h1 id="naslov">Izmenite željene podatke radnika</h1>
                <%
                    Korisnik r = (Korisnik) request.getAttribute("radnik");
                %>
                <form action="izmeniRadnika" method="post">
                    <table>
                        <tr>
                            <td>Ime: </td>
                            <td><input type="text" required name="ime" value="<%=r.getIme()%>"></td>
                        </tr>
                        <tr>
                            <td>Prezime: </td>
                            <td><input type="text" required name="prezime" value="<%=r.getPrezime()%>"></td>
                        </tr>
                        <tr>
                            <td>Šifra pumpe: </td>
                            <td><input type="text" required name="pumpa" value="<%=r.getIdPumpe()%>"></td>
                        </tr>
                        <tr>
                            <td>Tip radnika (Prodavac ili Menadzer): </td>
                            <td>
                                <input type="text" required name="tipKorisnika" value="<%=r.getTipKorisnika()%>">
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" readonly name="email" value="<%=r.getEmail()%>">
                    <input type="hidden" readonly name="lozinka" value="<%=r.getLozinka()%>">
                    <input type="hidden" readonly name="idKorisnika" value="<%=r.getIdKorisnika()%>">
                    <input type="hidden" readonly name="korisnickoIme" value="<%=r.getKorinickoIme()%>">
                    <input type="hidden" readonly name="telefon" value="<%=r.getTelefon()%>">
                    <input type="submit" class="btn btn-success btn-lg" value="Sačuvaj promene">
                </form>
            </div>
        </div>
    </body>
</html>
