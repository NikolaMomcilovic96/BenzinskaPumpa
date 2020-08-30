<%-- 
    Document   : pumpe
    Created on : Jun 24, 2020, 9:20:23 PM
    Author     : nikola
--%>

<%@page import="java.util.ArrayList" %>
<%@page import="binovi.Pumpa" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pumpe</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .sredina{
                margin-top: 120px;
                color: white;
                margin-left: 300px;
                margin-right: 300px;
            }

            .row{
                width: 100%;
            }

            .pumpa{
                background-color: darkslategray;
                width: 150px;
                height: 220px;
                margin: 40px;
                margin-left: 60px;
                padding: 20px;
            }

            #naslov{
                margin: 20px;
            }

            #dugme{
                margin: 30px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="sredina" align="center">
            <h1 id="naslov">Lista pumpi</h1>

            <div class="row bg-secondary rounded">
                <%
                    ArrayList<Pumpa> lista = (ArrayList<Pumpa>) request.getAttribute("lista");

                    for (Pumpa p : lista) {
                %>
                <div class="pumpa rounded">
                    <form action="ceneGoriva" method="post">
                        <table>
                            <tr>
                                <td>Naziv pumpe: </td>
                                <td><%=p.getNaziv()%></td>
                            </tr>
                            <tr>
                                <td>Šifra pumpe: </td>
                                <td><%=p.getIdPumpe()%></td>
                            </tr>
                            <tr>
                                <td>Adresa: </td>
                                <td><%=p.getAdresa()%></td>
                            </tr>
                            <tr>
                                <td>Šifra menadžera: </td>
                                <td><%=p.getIdMenadzera()%></td>
                            </tr>
                        </table>
                        <input type="submit" id="dugme" class="btn btn-info btn-md" value="Cene goriva">
                    </form>
                </div>
                <% }%>
            </div>
        </div>
    </body>
</html>
