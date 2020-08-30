<%-- 
    Document   : dodajPumpu
    Created on : Aug 12, 2020, 4:29:37 PM
    Author     : nikol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dodavanje nove pumpe</title>
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
                width: 500px;
            }
            
            #naslov{
                margin-bottom: 40px;
            }
            
            table{
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="container" align="center">
            <div class="sredina bg-secondary rounded" align="center">
                <h1 id="naslov">Unesite podatke nove pumpe</h1>
                <form action="dodajPumpu" method="post">
                    <table>
                        <tr>
                            <td>Naziv pumpe: </td>
                            <td><input type="text" required name="naziv" oninvalid="this.setCustomValidity('Morate uneti naziv pumpe')" oninput="this.setCustomValidity('')"></td>
                        </tr>
                        <tr>
                            <td>Adresa: </td>
                            <td><input type="text" required name="adresa" oninvalid="this.setCustomValidity('Morate uneti adresu pumpe')" oninput="this.setCustomValidity('')"></td>
                        </tr>
                    </table>
                    <input type="submit" class="btn btn-success btn-lg" value="Dodaj pumpu">
                </form>
            </div>
        </div>
    </body>
</html>
