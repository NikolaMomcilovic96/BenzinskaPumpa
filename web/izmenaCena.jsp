<%-- 
    Document   : izmenaCena
    Created on : Aug 11, 2020, 1:02:21 PM
    Author     : nikol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="binovi.Gorivo" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Izmena cena goriva</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .container{
                margin-top: 120px;
                color: white;
            }

            .cene{
                width: 500px;
                height: 300px;
                padding: 20px;
            }

            #naslov{
                margin-bottom: 20px;
            }

            table{
                margin-bottom: 20px;
            }

            #polje{
                width: 150px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="container" align="center">
            <div class="cene bg-secondary rounded" align="center">
                <%
                    Gorivo g = (Gorivo) request.getAttribute("gorivo");
                %>

                <h2 id="naslov">Unesite nove cene goriva</h2>
                <form action="promeniCene" method="post">
                    <table>
                        <tr>
                            <td>BMB 95: </td>
                            <td><input id="polje" type="text" value="<%=g.getCena95()%>" name="95"> dinara</td>
                        </tr>
                        <tr>
                            <td>BMB 98: </td>
                            <td><input id="polje" type="text" required name="98" value="<%=g.getCena98()%>"> dinara</td>
                        </tr>
                        <tr>
                            <td>Dizel: </td>
                            <td><input id="polje" type="text" required name="dizel" value="<%=g.getCenaDizel()%>"> dinara</td>
                        </tr>
                        <tr>
                            <td>Plin: </td>
                            <td><input id="polje" type="text" required name="plin" value="<%=g.getCenaPlin()%>"> dinara</td>
                        </tr>
                        <tr>
                            <%--<td>Šifra pumpe: </td>--%>
                            <td><input type="hidden" name="pumpa" value="<%=g.getIdPumpe()%>"></td>
                        </tr>
                    </table>

                    <input type="hidden" name="sifra" value="<%=g.getIdCena()%>">
                    <input type="submit" class="btn btn-success btn-lg" value="Sačuvaj promene">
                </form>
                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                <%= msg%>
                <%
                    }

                %>
            </div>
        </div>
    </body>
</html>
