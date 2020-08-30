<%-- 
    Document   : registracija
    Created on : Jun 21, 2020, 2:43:37 PM
    Author     : nikola
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registracija</title>
        <style>
            body{
                background: rgb(0,4,40);
                background: linear-gradient(90deg, rgba(0,4,40,1) 10%, rgba(0,78,146,1) 100%);
            }

            .row{
                width: 100%;
                padding-left: 100px;
                margin-top: 150px;
                color: white;
            }

            #levo{
                margin-left: 70px;
                width: 500px;
                height: 520px;
                padding: 20px;
            }

            #desno{
                margin-left: 100px;
                width: 500px;
                height: 520px;
                padding: 20px;
            }

            .vl{
                border: 4px solid black;
                height: 550px;
                margin-left: 90px;
            }

            #naslov{
                margin-bottom: 50px;
            }

            #polje{
                width: 250px;
            }

            input[type=checkbox]{
                -webkit-transform: scale(2);
                transform: scale(2);
                margin: 5px;
            }

            #dugme{
                margin-top: 20px;
            }

            #dugmeDesno{
                margin-top: 45px;
            }

            #poruka{
                color: black;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>


        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <%= msg%>
        <%
            }
        %>

        <div class="row" align="center">
            <%if (korisnik == null) {%>
            <div class="col-xl-5">
                <div class="bg-secondary rounded" id="levo">
                    <h2 id="naslov">Registracija korisnika</h2>
                    <form action="dodavanjeKorisnika" method="post">
                        <table>
                            <tr>
                                <td><b>Ime: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti ime')" oninput="this.setCustomValidity('')" id="polje" name="ime" required type="text" ></td>
                            </tr>
                            <tr>
                                <td><b>Prezime: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti prezime')" oninput="this.setCustomValidity('')" id="polje"  name="prezime" required type="text" ></td>
                            </tr>
                            <tr>
                                <td><b>Broj telefona: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti broj telefona')" oninput="this.setCustomValidity('')"  name="telefon" id="polje" required type="text" ></td>
                            </tr>
                            <tr>
                                <td><b>Email adresa: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti email adresu')" oninput="this.setCustomValidity('')" name="email"  id="polje" required type="text" ></td>
                            </tr>
                            <tr>
                                <td><b>Željeno korisničko ime: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti korisničko ime')" oninput="this.setCustomValidity('')" name="korisnickoIme" id="polje"  required type="text" ></td>
                            </tr>
                            <tr>
                                <td><b>Željena lozinka: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti lozinku')" oninput="this.setCustomValidity('')" name="lozinka"  id="polje" required type="password" ></td>
                            </tr>
                            <tr>
                                <td><b>Ponovite lozinku: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate ponoviti lozinku')" oninput="this.setCustomValidity('')" name="potvrda" id="polje"  required type="password" ></td>
                            </tr>
                        </table>
                        <br>
                        <input type="checkbox" id="pravno" name="tip" value="pravno">
                        <label for="pravno">  Pravno lice? </label>
                        <div id="poruka">
                            <%
                                String poruka = (String) request.getAttribute("poruka");
                                if (poruka != null) {
                            %>
                            <%= poruka%>
                            <%
                                }
                            %>
                        </div>
                        <br>
                        <input type="submit" id="dugme" class="btn btn-success btn-lg" value="Registrujte se">
                    </form>
                </div>
            </div>

            <div class="vl"></div>
            <% }%>
            <div class="col-xl-5">
                <div class="bg-secondary rounded" id="desno">
                    <h2 id="naslov">Registracija firmi</h2>
                    <i>Rukovodilac firme se mora registrovati kao pravno lice da bi registrovao firmu!</i>
                    <br><br>
                    <form action="dodavanjeFirmi" method="post">
                        <table>
                            <tr>
                                <td><b>Naziv firme: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti naziv firme')" oninput="this.setCustomValidity('')" id="polje" name="naziv"  required type="text" ></td>
                            </tr>
                            <tr>
                                <td><b>Adresa: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti adresu firme')" oninput="this.setCustomValidity('')" id="polje" name="adresa"  required type="text" ></td>
                            </tr>
                            <tr>
                                <td><b>PIB: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti PIB')" oninput="this.setCustomValidity('')" id="polje"  name="pib" required type="text" ></td>
                            </tr>
                            <tr>
                                <td><b>Željena lozinka: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti lozinku')" oninput="this.setCustomValidity('')" id="polje"  name="lozinka" required type="password" ></td>
                            </tr>
                            <tr>
                                <td><b>Željena lozinka: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate ponoviti lozinku')" oninput="this.setCustomValidity('')" id="polje" name="potvrda"  required type="password" ></td>
                            </tr>
                            <tr>
                                <td><b>Šifra rukovodioca: </b></td>
                                <td><input oninvalid="this.setCustomValidity('Morate uneti šifru rukovodioca')" oninput="this.setCustomValidity('')" id="polje" name="sifra"  required type="text" ></td>
                            </tr>
                        </table>
                        <i id="savet" style="color: black;">Šifru rukovodioca možete naći na stranici Profil kada se registrujete kao pravno lice</i>
                        <br>
                        <input type="submit" id="dugmeDesno" class="btn btn-success btn-lg" value="Registrujte firmu">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
