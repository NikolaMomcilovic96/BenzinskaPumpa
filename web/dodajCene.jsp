<%-- 
    Document   : dodajCene
    Created on : Aug 27, 2020, 1:40:54 PM
    Author     : nikol
--%>

<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dodavanje cena</title>
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
                padding: 30px;
                width: 600px;
            }

            table{
                margin: 40px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="container" align="center">
            <div class="sredina bg-secondary rounded">
                <form action="dodajCene" method="post">
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pumpa", "root", "");
                        Statement stmt = con.createStatement();

                        String upit = "SELECT * FROM pumpa WHERE idPumpe = '" + korisnik.getIdPumpe() + "'";

                        ResultSet rs = stmt.executeQuery(upit);

                        if (rs.next()) {
                    %>
                    <h1>Dodajte cene za pumpu <%=rs.getString("naziv")%></h1>
                    <%}%>
                    <table>
                        <tr>
                            <td>Cena za BMB 95: </td>
                            <td><input type="text" name="cena95" required></td>
                        </tr>
                        <tr>
                            <td>Cena za BMB 98: </td>
                            <td><input type="text" name="cena98" required></td>
                        </tr>
                        <tr>
                            <td>Cena za Dizel: </td>
                            <td><input type="text" name="cenaDizel" required></td>
                        </tr>
                        <tr>
                            <td>Cena za plin: </td>
                            <td><input type="text" name="cenaPlin" required></td>
                        </tr>
                    </table>
                    <input type="hidden" name="pumpa" value="<%=korisnik.getIdPumpe()%>">
                    <input type="submit" class="btn btn-success btn-lg" value="Dodaj cene">
                </form>
            </div>
        </div>
    </body>
</html>
