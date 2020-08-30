<%-- 
    Document   : prijava
    Created on : Jun 17, 2020, 7:45:04 PM
    Author     : nikola
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Prijava</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .row{
                width: 100%;
            }

            .sredina{
                margin-top: 200px;
                width: 450px;
                height: 350px;
                padding-top: 30px;
            }

            .firma{
                margin-top: 200px;
                width: 450px;
                height: 350px;
                padding-top: 30px;
            }

            #polje{
                width: 200px;
            }

            #tekst{
                margin-bottom: 20px;
                color: white;
            }

            #link{
                color: black;
            }

            table{
                margin-bottom: 10px;
            }

            #nemateNalog {
                margin-left: 100px;
            }

            #dugme{
                margin-top: 10px;
            }
        </style>

    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="container" align="center">
            <div class="sredina bg-secondary rounded" >
                <form action="logovanje">
                    <h2 id="tekst">Prijavite se</h2>
                    <br>
                    <table>
                        <tr>
                            <td><b style="color: white;">Korisničko ime: </b></td>
                            <td><input oninvalid="this.setCustomValidity('Morate uneti korisničko ime')" oninput="this.setCustomValidity('')" required type="text" name="korisnickoIme" id="polje"></td>
                        </tr>
                        <tr>
                            <td><b style="color: white;">Lozinka: </b></td>
                            <td><input oninvalid="this.setCustomValidity('Morate uneti lozinku')" oninput="this.setCustomValidity('')" required type="password" name="lozinka" id="polje"></td>
                        </tr>
                    </table>
                    <%
                        String msg = (String) request.getAttribute("msg");
                        if (msg != null) {
                    %>
                    <%= msg%>
                    <%
                        }
                    %>
                    <h6 id="nemateNalog" style="color: white;">Nemate nalog? <a id="link" href="registracija.jsp">Registrujte se</a></h6>
                    <br><br>
                    <input type="submit" class="btn btn-success btn-lg" value="Prijavite se">
                </form>
            </div>
        </div>
    </body>
</html>
