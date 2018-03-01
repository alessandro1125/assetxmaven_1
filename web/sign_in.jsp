<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 28/02/2018
  Time: 20:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Sign In</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="formstyle.css" rel="stylesheet" type="text/css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3mobile.css">
    </head>
    <body dir="ltr" dir="ltr" style="text-align: center;background-color:white;font-family:sans-serif;font-weight:lighter;color:#595959;">

        <%

            //Scarico il parametro di azione da svolgere
            int action = 0;
            try {
                if(request.getParameter("action") != null)
                    action = Integer.parseInt(request.getParameter("action"));
            }catch (NullPointerException e){
                e.printStackTrace();
                action = 0;
            }

            switch (action){

                case 0:
                    //Mostro il form per la registrazione
                    %>

        <br>
        <div class="form-style-8">
            <h2>Sign In</h2>
            <p id="reportMessage" style="display: none"></p>
            <form action="sign_in.jsp?action=1" method="post">
                <input type="text" id="nome" name="nome" placeholder="Name...">
                <input type="text" id="cognome" name="cognome" placeholder="Surname..." style="display: none">
                <input type="email" id="email" name="email" placeholder="Email..." style="display: none">
                <input type="password" id="password" name="password" placeholder="Password..." style="display: none">
                <input type="password" id="password_rep" placeholder="Repeat password..." style="display: none">
                <select style="display: none" id="anno" name = "anno">
                    <%
                        int year = Calendar.getInstance().get(Calendar.YEAR);
                        for (int i = 1900; i<= year; i++){


                    %>
                        <option value="<%= Integer.toString(i)%>"><%= Integer.toString(i)%></option>
                    <%
                        }
                    %>
                </select>

                <select style="display: none" id="mese" name="mese">
                    <option value="January">January</option>
                    <option value="February">February</option>
                    <option value="March">March</option>
                    <option value="April">April</option>
                    <option value="May">May</option>
                    <option value="June">June</option>
                    <option value="July">July</option>
                    <option value="August">August</option>
                    <option value="September">September</option>
                    <option value="October">October</option>
                    <option value="November">November</option>
                    <option value="December">December</option>
                </select>

                <select style="display: none" id="giorno" name="giorno">
                    <%
                        for (int i = 1; i<= 31; i++){


                    %>
                    <option value="<%= Integer.toString(i)%>"><%= Integer.toString(i)%></option>
                    <%
                        }
                    %>
                </select>

                <input type="submit" id="submit" style="display: none" value="Sing In">
            </form>
            <input type="submit" id="next" value="Next" onclick="next()">
        </div>

        <div class = "form-style-8" style="bottom:0px;left:20%;">
            Contacts:<blockquote> urimkuci.assetx@gmail.com<br>alessandrogiordano.assetx@gmail.com</blockquote>
        </div>

        <script type="application/javascript">

            var state = 0;

            document.getElementById("submit").type = "text";//Disattivo la funzione del submit

            function next() {
                switch (state){

                    case 0:
                        //Controllo che il campo nome non sia vuoto
                        if (document.getElementById("nome").value.localeCompare("") !== 0){
                            document.getElementById("nome").style.display = "none";
                            document.getElementById("cognome").style.display = "block";
                            document.getElementById("reportMessage").style.display = "none";//Nascodo il messaggio

                            state++;
                        }else {
                            document.getElementById("reportMessage").style.display = "block";
                            document.getElementById("reportMessage").innerHTML = "Enter a valid value for Name";//Mostro il messaggio
                            document.getElementById("nome").value = "";
                        }
                        break;

                    case 1:
                        if (document.getElementById("cognome").value.localeCompare("") !== 0){
                            document.getElementById("cognome").style.display = "none";
                            document.getElementById("email").style.display = "block";
                            document.getElementById("reportMessage").style.display = "none";//Nascodo il messaggio

                            state++;
                        }else {
                            document.getElementById("reportMessage").style.display = "block";
                            document.getElementById("reportMessage").innerHTML = "Enter a valid value for Surname";//Mostro il messaggio
                            document.getElementById("cognome").value = "";
                        }
                        break;

                    case 2:
                        if (document.getElementById("email").value.localeCompare("") !== 0 &&
                                (document.getElementById("email").value.search("@") !== -1)){
                            document.getElementById("email").style.display = "none";
                            document.getElementById("password").style.display = "block";
                            document.getElementById("password_rep").style.display = "block";
                            document.getElementById("reportMessage").style.display = "none";//Nascodo il messaggio

                            state++;
                        }else {
                            document.getElementById("reportMessage").style.display = "block";
                            document.getElementById("reportMessage").innerHTML = "Enter a valid email value";//Mostro il messaggio
                            document.getElementById("email").value = "";
                        }
                        break;

                    case 3:
                        if (document.getElementById("password").value.length >=8){
                            if(document.getElementById("password").value.localeCompare
                                (document.getElementById("password_rep").value) === 0){
                                document.getElementById("password").style.display = "none";
                                document.getElementById("password_rep").style.display = "none";
                                document.getElementById("anno").style.display = "block";
                                document.getElementById("reportMessage").style.display = "none";//Nascodo il messaggio

                                state++;
                            }else {
                                document.getElementById("reportMessage").style.display = "block";
                                document.getElementById("reportMessage").innerHTML = "Passwords must be the same";//Mostro il messaggio
                                document.getElementById("password").value = "";
                                document.getElementById("password_rep").value = "";
                            }
                        }else {
                            document.getElementById("reportMessage").style.display = "block";
                            document.getElementById("reportMessage").innerHTML = "Password minimum size must be 8";//Mostro il messaggio
                            document.getElementById("password").value = "";
                            document.getElementById("password_rep").value = "";
                        }
                        break;

                    case 4:
                        if(document.getElementById("anno").value.localeCompare("") !== 0){
                            document.getElementById("anno").style.display = "none";
                            document.getElementById("mese").style.display = "block";
                            document.getElementById("reportMessage").style.display = "none";//Nascodo il messaggio

                            state++;
                        }else {
                            document.getElementById("reportMessage").style.display = "block";
                            document.getElementById("reportMessage").innerHTML = "Select a valid value";//Mostro il messaggio
                        }

                        break;

                    case 5:
                        if(document.getElementById("mese").value.localeCompare("") !== 0){
                            document.getElementById("mese").style.display = "none";
                            document.getElementById("giorno").style.display = "block";
                            document.getElementById("reportMessage").style.display = "none";//Nascodo il messaggio

                            document.getElementById("next").style.display = "none";
                            document.getElementById("submit").type = "submit";
                            document.getElementById("submit").style.display = "block";

                            state++;
                        }else {
                            document.getElementById("reportMessage").style.display = "block";
                            document.getElementById("reportMessage").innerHTML = "Select a valid value";//Mostro il messaggio
                        }

                        break;

                    default:
                        state = 0;
                        break;
                }
            }


        </script>


                    <%

                    break;
                case 1:
                    //Registro l'account e invio l'email di conferma
                    %>
        <br>
        <div class="form-style-8">
            <h2>Ceck your email box to confirm your account</h2>
                    <%
                    break;
                default:
                    response.sendRedirect("index.jsp?action=0");
                    break;
            }


        %>


    </body>
</html>