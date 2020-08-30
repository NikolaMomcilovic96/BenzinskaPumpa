<%-- 
    Document   : promenaMenadzera
    Created on : Aug 12, 2020, 7:24:04 PM
    Author     : nikol
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="binovi.Pumpa" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Promena menadzera pumpe</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            #okvir {
                margin-top: 100px;
                color: white;
            }

            .row{
                width: 100%;
            }

            .menadzer {
                width: 500px;
                height: 360px;
                padding: 30px;
                margin: 30px;
                margin-left: 170px;
            }

            .radnici{
                width: 600px;
                padding: 30px;
                margin: 30px;
                margin-left: 50px
            }

            .radnik{
                background-color: darkslategray;
                width: 250px;
                padding: 5px;
                margin: 10px;
            }

            table{
                margin: 10px;
            }

            #citanje{
                background-color: #b7b9bd;
            }

            #pisanje{
                width: 80px;
            }

            #naslov{
                margin-bottom: 20px;
            }

            .dugme{
                margin-top: 30px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <%
            Pumpa p = (Pumpa) request.getAttribute("pumpa");
        %>

        <div class="row" id="okvir" align="center">
            <div class="menadzer bg-secondary rounded" align="center">
                <h1 id="naslov">Promenite menadzera pumpe</h1>
                <form action="promenaMenadzera" method="post">
                    <table>
                        <tr>
                            <td>Naziv pumpe: </td>
                            <td><input type="text" id="citanje" readonly name="naziv" value="<%=p.getNaziv()%>"></td>
                        </tr>
                        <tr>
                            <td>Adresa pumpe: </td>
                            <td><input type="text" id="citanje" readonly name="adresa" value="<%=p.getAdresa()%>"></td>
                        </tr>
                        <tr>
                            <td>Šifra menadžera: </td>
                            <td><input type="text" id="pisanje" required name="menadzer" value="<%=p.getIdMenadzera()%>"></td>
                        </tr>
                    </table>
                    <div class="dugme">
                        <input type="hidden" value="<%=p.getIdPumpe()%>" name="sifra">
                        <input type="submit" class="btn btn-success btn-lg" value="Sačuvaj promene">
                    </div>
                </form>
            </div>
            <div class="radnici bg-secondary rounded">
                <h1 id="naslov">Spisak radnika pumpi</h1>
                <div class="row">
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                        Statement stmt = con.createStatement();

                        String upit = "SELECT * FROM korisnik WHERE tipKorisnika = 'Menadzer' OR tipKorisnika = 'Prodavac'";

                        try {

                            ResultSet rs = stmt.executeQuery(upit);

                            while (rs.next()) {
                    %>
                    <div class="radnik rounded">
                        <table>
                            <tr>
                                <td>Šifra radnika: </td>
                                <td><%=rs.getInt("idKorisnika")%></td>
                            </tr>
                            <tr>
                                <td>Ime: </td>
                                <td><%=rs.getString("ime")%></td>
                            </tr>
                            <tr>
                                <td>Prezime: </td>
                                <td><%=rs.getString("prezime")%></td>
                            </tr>
                            <tr>
                                <td>Tip korisnika: </td>
                                <td><%=rs.getString("tipKorisnika")%></td>
                            </tr>
                        </table>
                    </div>
                    <%
                            }
                        } catch (Exception e) {
                            request.setAttribute("msg", e.getMessage());
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
