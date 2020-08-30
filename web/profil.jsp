<%-- 
    Document   : profil
    Created on : Jun 18, 2020, 7:53:36 PM
    Author     : nikola
--%>


<%@page import="java.sql.*" %>
<%@page import="binovi.Korisnik" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profil</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .container{
                margin-top: 120px;
                color: white;
            }

            .karta{
                width: 700px;
                padding-top: 30px;
                padding-bottom: 20px;
            }

            #tekst{
                color: white;
            }

            #slika{
                width: 150px;
                height: 200px;
            }

            .slika{
                margin: 50px;
                margin-left: 100px;
            }

            .profil{
                margin: 50px;
                margin-top: 80px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="container" align="center">

            <%
                Korisnik p = (Korisnik) request.getAttribute("profil");

                if (korisnik.getTipKorisnika().equals("Korisnik")) {
            %>
            <div class="karta bg-secondary rounded">
                <h1>Profil korisnika</h1>
                <div class="row">
                    <div class="slika">
                        <img id="slika" src="Slike/woman.png">
                    </div>
                    <div class="profil">
                        <table>
                            <tr>
                                <td><h4>Ime: </h4></td>
                                <td><h4><%= p.getIme()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Prezime: </h4></td>
                                <td><h4><%=p.getPrezime()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Broj poena: </h4></td>
                                <td><h4><%=p.getPoeni()%></h4></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <% } else if (korisnik.getTipKorisnika().equals("Rukovodilac")) {%>
            <div class="karta bg-secondary rounded">
                <h1>Profil rukovodioca</h1>
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                    Statement stmt = con.createStatement();

                    String upit = "SELECT * FROM firma WHERE idRukovodioca = '" + p.getIdKorisnika() + "'";

                    ResultSet rs = stmt.executeQuery(upit);

                    if (rs.next()) {
                %>
                <div class="row">
                    <div class="slika">
                        <img id="slika" src="Slike/businessman.png">
                    </div>
                    <div class="profil">

                        <table>
                            <tr>
                                <td><h4>Ime: </h4></td>
                                <td><h4><%=p.getIme()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Prezime: </h4></td>
                                <td><h4><%=p.getPrezime()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Šifra: </h4></td>
                                <td><h4><%=p.getIdKorisnika()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Naziv firme: </h4></td>
                                <td><h4><%=rs.getString("nazivFirme")%></h4></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <% }
            } else if (korisnik.getTipKorisnika().equals("Administrator")) {%>

            <div class="karta bg-secondary rounded">

                <h1>Profil administratora</h1>
                <div class="row">
                    <div class="slika">
                        <img id="slika" src="Slike/man.png">
                    </div>
                    <div class="profil">
                        <table>
                            <tr>
                                <td><h4>Uloga: </h4></td>
                                <td><h4><%=p.getTipKorisnika()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Ime: </h4></td>
                                <td><h4><%=p.getIme()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Prezime: </h4></td>
                                <td><h4><%=p.getPrezime()%></h4></td>
                            </tr>
                        </table>
                    </div>
                </div>

            </div>

            <% } else if (korisnik.getTipKorisnika().equals("Menadzer")) {%>
            <div class="karta bg-secondary rounded">
                <h1>Profil menadžera</h1>
                <div class="row">
                    <div class="slika">
                        <img id="slika" src="Slike/businessman.png">
                    </div>
                    <div class="profil">
                        <table>
                            <tr>
                                <td><h4>Uloga: </h4></td>
                                <td><h4><%=p.getTipKorisnika()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Ime: </h4></td>
                                <td><h4><%=p.getIme()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Prezime: </h4></td>
                                <td><h4><%=p.getPrezime()%></h4></td>
                            </tr>
                            <tr>
                                <td><h4>Šifra: </h4></td>
                                <td><h4><%=p.getIdKorisnika()%></h4></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <% }%>
        </div>
    </body>
</html>
