<%-- 
    Document   : ceneGoriva
    Created on : Jun 20, 2020, 12:48:02 PM
    Author     : nikola
--%>

<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="binovi.Pumpa" %>
<%@page import="binovi.Gorivo" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Informacije</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .okvir{
                margin-top: 120px;
                color: white;
                width: 800px;
                padding-top: 5px;
                padding-bottom: 30px;
            }

            .row{
                width: 700px;
            }

            #naslov{
                margin: 20px;
            }

            #dugme{
                margin-top: 30px;
            }

            #goriva{
                height: 200px;
                width: 300px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp"%>

        <%
            Gorivo g = (Gorivo) request.getSession().getAttribute("goriva");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
            Statement stmt = con.createStatement();

            String upit = "SELECT * FROM pumpa WHERE idPumpe = '" + g.getIdPumpe() + "'";

            ResultSet rs = stmt.executeQuery(upit);

            if (rs.next()) {
        %>
        <div class="container" align="center">
            <div class="okvir bg-secondary rounded" align="center">

                <h2 id="naslov">Cene goriva na pumpi <%=rs.getString("naziv")%> </h2>
                <div class="row">
                    <div class="col-md-6">
                        <img id="goriva" src="https://www.dnevno.rs/wp-content/uploads/2018/05/39355-gorivo.jpg" alt="goriva">
                    </div>
                    <div class="col-md-6">
                        <br>
                        <font size="5">
                        <table>
                            <tr>
                                <td><b>BMB 95: </b></td>
                                <td><%=g.getCena95()%> dinara</td>
                            </tr>
                            <tr>
                                <td><b>BMB 98: </b></td>
                                <td><%=g.getCena98()%> dinara</td>
                            </tr>
                            <tr>
                                <td><b>Dizel: </b></td>
                                <td><%=g.getCenaDizel()%> dinara</td>
                            </tr>
                            <tr>
                                <td><b>Plin: </b></td>
                                <td><%=g.getCenaPlin()%> dinara</td>
                            </tr>
                        </table>
                        </font>
                    </div>
                </div>
                <% if (korisnik == null) {%>
                <%} else if (korisnik.getTipKorisnika().equals("Menadzer")) {%>
                <form action="izmeniCene" method="post">
                    <input type="hidden" name="sifra" value="<%=g.getIdCena()%>">
                    <input type="submit" id="dugme" class="btn btn-warning btn-lg" value="Izmeni cene">
                </form>
                <%}%>
            </div>
        </div>
        <%}%>
    </body>
</html>
