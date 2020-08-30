<%-- 
    Document   : narudzbenice
    Created on : Jun 24, 2020, 7:27:54 PM
    Author     : nikola
--%>

<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="binovi.Narudzbenica" %>
<%@page import="binovi.Firma" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Narudzbenice</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .sredina{
                margin-top: 120px;
                color: white;
                margin-left: 270px;
                margin-right: 270px;
                margin-bottom: 40px;
                padding-bottom: 20px;
                padding-top: 20px;
            }

            .row{
                width: 100%;
                padding-left: 30px;
            }

            .narudzbenicaA{
                background-color: darkslategray;
                margin: 40px;
                padding: 10px;
                width: 250px;
            }

            #naslov{
                margin: 20px;
            }

            #poruka{
                margin-left: 280px;
                margin-bottom: 30px;
                margin-top: 50px;
            }

            .container{
                margin-top: 120px;
                color: white;
                margin-bottom: 40px;
                padding: 30px;
            }

            #adresa{
                margin-top: 20px;
            }

            .lista{
                width: 850px;
                margin-bottom: 30px;
                color: white;
                padding: 30px;
            }

            .narudzbenica{
                background-color: darkslategray;
                width: 200px;
                margin: 20px;
                padding-top: 10px;
                padding-bottom: 10px;
            }

            .narudzbenicaM{
                background-color: darkslategray;
                width: 240px;
                padding: 10px;
                margin: 11px;
            }

            .narudzbenicaA{
                background-color: darkslategray;
                width: 250px;
                margin: 15px;
                padding-bottom: 10px;
                padding-top: 10px;
            }

            table{
                margin-bottom: 20px;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>

        <%@include file="navbar.jsp" %>

        <%
            if (korisnik.getTipKorisnika().equals("Administrator")) {                                                       //ADMINISTRATOR
        %>
        <div class="sredina bg-secondary rounded" align="center">
            <h1 id="naslov">Lista svih narudžbenica</h2>
                <div class="row" align="center">
                    <%
                        ArrayList<Narudzbenica> lista = (ArrayList<Narudzbenica>) request.getAttribute("lista");

                        if (lista.isEmpty()) {%>
                    <h3 id="poruka">Još uvek nema narudžbenica</h3>
                    <%}
                        for (Narudzbenica n : lista) {
                    %>
                    <div class="narudzbenicaA rounded">
                        <table>
                            <tr>
                                <td>Šifra narudzbenice: </td>
                                <td><%=n.getIdNarudzbenice()%></td>
                            </tr>
                            <tr>
                                <td>Naziv goriva: </td>
                                <td><%=n.getNazivGoriva()%></td>
                            </tr>
                            <tr>
                                <td>Količina: </td>
                                <td><%=n.getKolicina()%> litara</td>
                            </tr>
                            <tr>
                                <td>Dostava na pumpu: </td>
                                <td><%=n.getIdPumpe()%></td>
                            </tr>
                            <tr>
                                <td>Datum dostave: </td>
                                <td><%=n.getDatum()%></td>
                            </tr>
                            <tr>
                                <td>Šifra firme: </td>
                                <td><%=n.getIdFirme()%></td>
                            </tr>
                            <tr>
                                <td>Naplaćeno: </td>
                                <td><%=n.getNaplaceno()%></td>
                            </tr>
                        </table>
                    </div>
                    <%}%>
                </div>
        </div>
        <% } else if (korisnik.getTipKorisnika().equals("Rukovodilac")) {                                                     //RUKOVODILAC

            Firma f = (Firma) request.getAttribute("firma");
        %>
        <div class="container" align="center">
            <div class="lista bg-secondary rounded">
                <h1>Narudzbenice firme</h1>
                <div class="row" align="center">
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                        Statement stmt = con.createStatement();

                        String upit = "SELECT * FROM narudzbenica WHERE idFirme = '" + f.getIdFirme() + "'";

                        ResultSet rs = stmt.executeQuery(upit);

                        while (rs.next()) {
                    %>
                    <div class="narudzbenica rounded">
                        <table>
                            <tr>
                                <td>Naziv goriva: </td>
                                <td><%=rs.getString("nazivGoriva")%></td>
                            </tr>
                            <tr>
                                <td>Količina: </td>
                                <td><%=rs.getInt("kolicina")%> litara</td>
                            </tr>
                            <tr>
                                <td>Datum: </td>
                                <td><%=rs.getString("datum")%></td>
                            </tr>
                            <tr>
                                <td>Na pumpu: </td>
                                <td><%=rs.getInt("idPumpe")%></td>
                            </tr>
                            <tr>
                                <td>Šifra firme: </td>
                                <td><%=rs.getInt("idFirme")%></td>
                            </tr>
                            <tr>
                                <td>Naplaćeno: </td>
                                <td><%=rs.getString("naplaceno")%></td>
                            </tr>
                        </table>
                        <%if (rs.getString("naplaceno").equals("ne")) {%>
                        <form action="ponistiNarudzbenicu" method="post">
                            <input type="hidden" name="sifra" value="<%=rs.getInt("idNarudzbenice")%>">
                            <input type="submit" class="btn btn-danger btn-md" value="Poništi">
                        </form>
                        <%} else if (rs.getString("naplaceno").equals("da")) {%>
                        <b>Već je naplaćeno</b>
                        <%}%>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <%} else if (korisnik.getTipKorisnika().equals("Menadzer")) { %>                                                     <!-- MENADZER -->
        <div class="container bg-secondary rounded" align="center">
            <h1 id="naslov">Lista narudžbenica vaše pumpe</h1>
            <div class="row">
                <%ArrayList<Narudzbenica> lista = (ArrayList<Narudzbenica>) request.getAttribute("lista");

                    if (lista.isEmpty()) {%>
                <h3 id="poruka">Trenutno nemate narudžbenice</h3>
                <%
                    }
                    for (Narudzbenica n : lista) {
                %>
                <div class="narudzbenicaM">
                    <table>
                        <tr>
                            <td>Šifra narudžbenice: </td>
                            <td><%=n.getIdNarudzbenice()%></td>
                        </tr>
                        <tr>
                            <td>Vrsta goriva: </td>
                            <td><%=n.getNazivGoriva()%></td>
                        </tr>
                        <tr>
                            <td>Količina goriva: </td>
                            <td><%=n.getKolicina()%></td>
                        </tr>
                        <tr>
                            <td>Datum: </td>
                            <td><%=n.getDatum()%></td>
                        </tr>
                        <tr>
                            <td>Firma: </td>
                            <td><%=n.getIdFirme()%></td>
                        </tr>
                        <tr>
                            <td>Naplaćeno: </td>
                            <td><%=n.getNaplaceno()%></td>
                        </tr>
                    </table>

                </div>
                <%}%>
            </div>
        </div>
        <%} else if (korisnik.getTipKorisnika().equals("Prodavac")) { %>                                <!-- PRODAVAC -->
        <div class="container bg-secondary rounded" align="center">
            <h1 id="naslov">Lista narudžbenica vaše pumpe</h1>
            <div class="row">
                <%ArrayList<Narudzbenica> lista = (ArrayList<Narudzbenica>) request.getAttribute("lista");

                    if (lista.isEmpty()) {%>
                <h3 id="poruka">Trenutno nemate narudžbenice</h3>
                <%
                    }
                    for (Narudzbenica n : lista) {
                %>
                <div class="narudzbenicaM">
                    <form action="ukloniNarudzbenicu" method="post">
                        <table>
                            <tr>
                                <td>Šifra narudžbenice: </td>
                                <td><%=n.getIdNarudzbenice()%></td>
                            </tr>
                            <tr>
                                <td>Vrsta goriva: </td>
                                <td><%=n.getNazivGoriva()%></td>
                            </tr>
                            <tr>
                                <td>Količina goriva: </td>
                                <td><%=n.getKolicina()%></td>
                            </tr>
                            <tr>
                                <td>Datum: </td>
                                <td><%=n.getDatum()%></td>
                            </tr>
                            <tr>
                                <td>Šifra firme: </td>
                                <td><%=n.getIdFirme()%></td>
                            </tr>
                            <tr>
                                <td>Naplaćeno: </td>
                                <td><%=n.getNaplaceno()%></td>
                            </tr>
                        </table>
                        <%if (n.getNaplaceno().equals("ne")) {%>
                        <form action="ponistiNarudzbenicu" method="post">
                            <input type="hidden" name="sifra" value="<%=n.getIdNarudzbenice()%>">
                            <input type="submit" class="btn btn-danger btn-md" value="Poništi">
                        </form>
                        <%} else if (n.getNaplaceno().equals("da")) {%>
                        <b>Već je naplaćeno</b>
                        <%}%>
                    </form>
                </div>
                <%}%>
            </div>
        </div>
        <%}%>
    </body>
</html>
