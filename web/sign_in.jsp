<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
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

        <%!
            private static final String ERROR_CODE_PAGE = "100";
        %>

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

                    //Scarico i parametri dell'account
                    String email = null;
                    String password = null;
                    String name = null;
                    String surname = null;
                    String anno = null;
                    String mese = null;
                    String giorno = null;
                    try{
                        email = request.getParameter("email");
                        password = request.getParameter("password");
                        name = request.getParameter("nome");
                        surname = request.getParameter("cognome");
                        anno = request.getParameter("anno");
                        mese = request.getParameter("mese");
                        giorno = request.getParameter("giorno");
                    }catch (NullPointerException e){;
                        e.printStackTrace();
                        String redirectURL = "login.jsp?action=0&message=" +
                                new String(Base64.getEncoder().encode(("An error has occurred " +
                                        ERROR_CODE_PAGE + "x01").getBytes()));
                        response.sendRedirect(redirectURL);
                    }

                    double passkeyDoub = (Math.floor(Math.random() * Math.pow(10, 16)) / Math.pow(10, 16));
                    String passkey = Double.toString(passkeyDoub).substring(2,Double.toString(passkeyDoub).length());

                    String passkeyUrlEncoded = URLEncoder.encode(new String(Base64.getEncoder().encode(passkey.getBytes())), "UTF-8");
                    String emailUrlEncoded = URLEncoder.encode(new String(Base64.getEncoder().encode(email.getBytes())), "UTF-8");
                    String text = "To confirm your Get Advertisment Account click to the following link: " +
                            "https://getadvertisment.herokuapp.com/sign_in.jsp?action=2&passkey=" + passkeyUrlEncoded
                            + "&email=" + emailUrlEncoded;
                    if(sendEmail(email, text, "User confirmation")){

                        //Se l'email è stata inviata correttamente salvo l'utente nel database
                        HashMap<String, Object> map = new HashMap();
                        map.put("email", email);
                        map.put("password", password);
                        map.put("nome", name);
                        map.put("cognome", surname);
                        map.put("anno", anno);
                        map.put("mese", mese);
                        map.put("giorno", giorno);
                        map.put("attivo", "0");
                        map.put("passkey", passkey);
                        map.put("devices_uid", "0");

                        Connection connection = null;

                        try {
                            connection = getConnectionHeroku();
                        }catch (Exception e){
                            e.printStackTrace();
                            try {
                                connection.close();
                            } catch (SQLException e1) {
                                e1.printStackTrace();
                            }
                            System.out.println("Errore nella connessione con il batabase " + ERROR_CODE_PAGE + "x02");
                            String redirectURL = "login.jsp?action=0&message=" +
                                    new String(Base64.getEncoder().encode(("An error has occurred " +
                                            ERROR_CODE_PAGE + "x02").getBytes()));
                            response.sendRedirect(redirectURL);
                        }

                        //Controllo se l'utente è già registrato
                        if(!searchUser(connection, email)){

                            if(addSql(connection , map, "users")){

                                //Stampo la risposta
                                %>
                <br>
                <div class="form-style-8">
                    <h2>Ceck your email box to confirm your account</h2>
                </div>
                                <%
                            }else {
                                try {
                                    connection.close();
                                } catch (SQLException e1) {
                                    e1.printStackTrace();
                                }
                                System.out.println("Errore nella scrittura nel database "+ ERROR_CODE_PAGE + "x03");
                                String redirectURL = "login.jsp?action=0&message=" +
                                        new String(Base64.getEncoder().encode(("An error has occurred " +
                                                ERROR_CODE_PAGE + "x03").getBytes()));
                                response.sendRedirect(redirectURL);
                            }
                        }else {
                            System.out.println("L'utente è già registrato");
                                try {
                                    connection.close();
                                } catch (SQLException e1) {
                                    e1.printStackTrace();
                                }
                            String redirectURL = "login.jsp?action=0&message=" +
                                    new String(Base64.getEncoder().encode(("User already registered".getBytes())));
                            response.sendRedirect(redirectURL);
                        }
                        try {
                            connection.close();
                        } catch (SQLException e1) {
                            e1.printStackTrace();
                        }
                    }else {
                        System.out.println("Errore nell'invio dell'email di conferma " + ERROR_CODE_PAGE + "x04");
                        String redirectURL = "login.jsp?action=0&message=" +
                                new String(Base64.getEncoder().encode(("An error has occurred " +
                                        ERROR_CODE_PAGE + "x04").getBytes()));
                        response.sendRedirect(redirectURL);
                    }

                    break;
                case 2:
                    //Eseguo l'attivazione dell'account
                    String passkey2 = null;
                    String email2 = null;
                    try {
                        passkey2 =  new String(Base64.getDecoder().decode(URLDecoder.decode(request.getParameter("passkey"), "UTF-8")));
                        email2 =    new String(Base64.getDecoder().decode(URLDecoder.decode(request.getParameter("email"), "UTF-8")));
                    }catch (NullPointerException e){
                        e.printStackTrace();
                        System.out.println("Errore nella recezione della passkey " + ERROR_CODE_PAGE + "x05");
                        String redirectURL = "login.jsp?action=0&message=" +
                                new String(Base64.getEncoder().encode(("An error has occurred " +
                                        ERROR_CODE_PAGE + "x05").getBytes()));
                        response.sendRedirect(redirectURL);
                    }

                    //Controllo se la passkey è corretta
                    Connection connection = getConnectionHeroku();
                    if (checkPasskey(connection, passkey2, email2)){
                        //Aggiorno lo stato di attivazione e cancello la passkey
                        if(updateActivtion(connection, email2)) {
                            try {
                                connection.close();
                            } catch (SQLException e1) {
                                e1.printStackTrace();
                            }
                            String redirectURL = "login.jsp?action=0&message=" +
                                    new String(Base64.getEncoder().encode("User Correctly activated".getBytes()));
                            response.sendRedirect(redirectURL);
                        }else {
                            try {
                                connection.close();
                            } catch (SQLException e1) {
                                e1.printStackTrace();
                            }
                            System.out.println("Errore nell'aggiornamento del database " + ERROR_CODE_PAGE + "x07");
                            String redirectURL = "login.jsp?action=0&message=" +
                                    new String(Base64.getEncoder().encode(("An error has occurred " +
                                            ERROR_CODE_PAGE + "x07").getBytes()));
                            response.sendRedirect(redirectURL);
                        }
                    }else {
                        try {
                            connection.close();
                        } catch (SQLException e1) {
                            e1.printStackTrace();
                        }
                        System.out.println("Errore nell'attivazione della passkey " + ERROR_CODE_PAGE + "x06");
                        String redirectURL = "login.jsp?action=0&message=" +
                                new String(Base64.getEncoder().encode(("An error has occurred " +
                                        ERROR_CODE_PAGE + "x06").getBytes()));
                        response.sendRedirect(redirectURL);
                    }


                    break;

                case 3:

                    //Richiesta di resettare la password
                    //Mostro il form per l'interimento dell'email

                    %>
        <div class="form-style-8">
            <h2>Reset Password</h2>
            <form class="form-style-8" action="sign_in.jsp?action=4" method="POST">
                <input type="email" name="email" placeholder="Enter your email...">
                <input type="submit" value="Submit">
            </form>
        </div>
                    <%
                    break;

                case 4:
                    String email4 = null;
                    try{
                        email4 = request.getParameter("email");
                    }catch (NullPointerException e){
                        e.printStackTrace();
                        System.out.println("Errore nel parametro " + ERROR_CODE_PAGE + "x08");
                        String redirectURL = "login.jsp?action=0&message=" +
                                new String(Base64.getEncoder().encode(("An error has occurred " +
                                        ERROR_CODE_PAGE + "x08").getBytes()));
                        response.sendRedirect(redirectURL);
                    }

                    //Controllo se l'utente è già stato attivato
                    Connection connectionPass = getConnectionHeroku();
                    if(searchUserAtivated(connectionPass, email4)){
                        //Genero la passkey per la modifica password
                        double passkeyPassDoub = (Math.floor(Math.random() * Math.pow(10, 16)) / Math.pow(10, 16));
                        String passkeyPass = Double.toString(passkeyPassDoub).substring(2,Double.toString(passkeyPassDoub).length());

                        //Invio la passkey per email
                        String textPass = "To change your password please click on this link: " +
                                "https://getadvertisment.herokuapp.com/sign_in.jsp?action=5&email="+
                                URLEncoder.encode(new String(Base64.getEncoder().encode(email4.getBytes())),"UTF-8")
                                + "&passkey=" +URLEncoder.encode(new String(Base64.getEncoder().encode(passkeyPass.getBytes())),"UTF-8");
                        if(sendEmail(email4, textPass, "Reset password")){
                            //Aggiorno il database
                            if (updatePasskey(connectionPass, email4, passkeyPass)){
                                //Stampo la risposta
                                try {
                                    connectionPass.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                                %>
        <br>
        <div class="form-style-8">
            <h2>Ceck your email box to reset your password</h2>
        </div>
                                <%
                            }else {
                                try {
                                    connectionPass.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                                System.out.println("Errore nell'aggiornamento del database" + ERROR_CODE_PAGE + "x10");
                                String redirectURL = "login.jsp?action=0&message=" +
                                        new String(Base64.getEncoder().encode(("An error has occurred " +
                                                ERROR_CODE_PAGE + "x10").getBytes()));
                                response.sendRedirect(redirectURL);
                            }

                        }else {
                            try {
                                connectionPass.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                            System.out.println("Errore nell'invio dell'email" + ERROR_CODE_PAGE + "x09");
                            String redirectURL = "login.jsp?action=0&message=" +
                                    new String(Base64.getEncoder().encode(("Cannot send Email " +
                                            ERROR_CODE_PAGE + "x09").getBytes()));
                            response.sendRedirect(redirectURL);
                        }
                    }else {
                        try {
                            connectionPass.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        String redirectURL = "login.jsp?action=0&message=" +
                                new String(Base64.getEncoder().encode(("User is not activated").getBytes()));
                        response.sendRedirect(redirectURL);
                    }



                    break;

                case 5:
                    //Reimposto la password

                    //Scarico e decodifico i parametri url (BASE64 e URL)
                    String email5 = null;
                    String passkey5 = null;
                    String email5Encoded = null;
                    try{
                        email5Encoded = request.getParameter("email");
                        email5 =    new String(Base64.getDecoder().decode(URLDecoder.decode(email5Encoded, "UTF-8").getBytes()));
                        passkey5 =  new String(Base64.getDecoder().decode(URLDecoder.decode
                                (request.getParameter("passkey"), "UTF-8").getBytes()));
                    }catch (NullPointerException e){
                        e.printStackTrace();
                        System.out.println("Error: " + ERROR_CODE_PAGE + "x11");
                        String redirectURL = "login.jsp?action=0&message=" +
                                new String(Base64.getEncoder().encode(("An error has occurred"  +
                                        ERROR_CODE_PAGE + "x11").getBytes()));
                        response.sendRedirect(redirectURL);
                    }

                    //Controllo nel database se i dati corrispondono
                    Connection connection5 = getConnectionHeroku();
                    if (checkPasskey(connection5, email5, passkey5)){
                        //Mostro il form per la reimpostazione della password
                        %>
        <div class="form-style-8">
            <h2>Set new password</h2>
            <p id="messagesp" style="display: none"></p>
            <form class="form-style-8" action="sign_in.jsp?action=6?email=<%= email5Encoded%>" method="POST">
                <input type="password" id="newpassword" name="password" placeholder="Enter the new password...">
                <input type="password" id="newpasswordconf" name="password_confirm" placeholder="Confirm password...">
                <input type="submit" value="Confirm" id="sendreq" style="display: none">
            </form>
            <input type="submit" value="Submit" id="check" onclick="check_password()">

            <script>
                function check_password() {
                    if (document.getElementById("newpassword").value.length <= 8){
                        if(document.getElementById("newpassword").value.localeCompare(document.getElementById
                            ("newpasswordconf").value) === 0){
                            //Cambio la password
                            document.getElementById("newpassword").style.display = "none";
                            document.getElementById("newpasswordconf").style.display = "none";
                            document.getElementById("messagesp").innerHTML = "Ckick confirm to update your password";
                            document.getElementById("messagesp").style.display = "block";

                            document.getElementById("sendreq").style.display = "block";
                            document.getElementById("check").style.display = "none";

                        }else {
                            document.getElementById("messagesp").innerHTML = "Passwords must be the same";
                            document.getElementById("messagesp").style.display = "block";
                        }
                    }else {
                        document.getElementById("messagesp").innerHTML = "Minimum password size must be 8";
                        document.getElementById("messagesp").style.display = "block";
                    }
                }


            </script>
        </div>
                        <%
                        try {
                            connection5.close();
                        }catch (SQLException e){
                            e.printStackTrace();
                        }
                    }else {
                        //Controllo passkey non riuscito
                        try {
                            connection5.close();
                        }catch (SQLException e){
                            e.printStackTrace();
                        }
                        String redirectURL = "login.jsp?action=0&message=" +
                                new String(Base64.getEncoder().encode(("An error has occurred "+
                                        ERROR_CODE_PAGE + "x12").getBytes()));
                        response.sendRedirect(redirectURL);
                    }



                    break;

                case 6:
                    String email6 = null;
                    String newPassword = null;

                    //Decodifico email e password e inserisco la password nel db


                    break;

                default:
                    response.sendRedirect("index.jsp?action=0");
                    break;
            }


        %>

        <%!

            /**
             *
             * @param connection Connection
             * @param email String
             * @param passkey String
             * @return boolean
             */
            private static boolean updatePasskey(Connection connection, String email, String passkey){

                Statement stmt;
                String query = "UPDATE users SET passkey='" + passkey + "' WHERE email='" + email + "'";

                try {
                    stmt = connection.createStatement();
                    stmt.executeUpdate(query);
                    stmt.close();
                    return true;
                }catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println(e.toString());
                    return false;
                }
            }

            /**
             *
             * @param connection Connection
             * @param record HashMap<String, Object>
             * @param table Stirng
             * @return boolean
             */
            private static boolean addSql(Connection connection, HashMap<String, Object> record, String table) {

                Statement stmt;
                String keys, values;
                StringBuilder keysBuilder, valuesBuilder;
                keysBuilder = new StringBuilder();
                valuesBuilder = new StringBuilder();
                for (String key : record.keySet()){
                    keysBuilder = keysBuilder.append(key).append(" ,");

                    if (record.get(key).getClass() == String.class)
                        valuesBuilder.append("'");
                    valuesBuilder = valuesBuilder.append(record.get(key));
                    if (record.get(key).getClass() == String.class)
                        valuesBuilder.append("'");
                    valuesBuilder = valuesBuilder.append(" ,");
                }
                keys = keysBuilder.toString();
                keys = keys.substring(0, keys.length()-2);

                values = valuesBuilder.toString();
                values = values.substring(0, values.length()-2);

                String query = "INSERT INTO " + table + " (" + keys + ")" +
                        " VALUES (" + values + ")";

                try {
                    stmt = connection.createStatement();
                    stmt.executeUpdate(query);
                    stmt.close();
                    return true;
                }catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println(e.toString());
                    return false;
                }
            }

            /**
             *
             * @param connection Connection
             * @param email String
             * @return boolean
             */
            private static boolean updateActivtion(Connection connection, String email){

                Statement stmt;
                String query = "UPDATE users SET attivo='1', passkey='0' WHERE email='" + email + "'";

                try {
                    stmt = connection.createStatement();
                    stmt.executeUpdate(query);
                    stmt.close();
                    return true;
                }catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println(e.toString());
                    return false;
                }
            }

            /**
             *
             * @param connection Connection
             * @param passKey String
             * @param email String
             * @return boolean
             */
            private static boolean checkPasskey(Connection connection, String passKey, String email){

                //Faccio una chiamata al db
                Statement statement;
                String query;

                query = "SELECT * FROM users";
                try{
                    statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(query);

                    System.out.println("quering1: ");
                    boolean matched = false;
                    if (resultSet != null){
                        System.out.println("quering2");
                        while (resultSet.next()){
                            //Controllo corrispondenze
                            //System.out.println(resultSet.getString("passkey") + "\t );
                            if (resultSet.getString("passkey").equals(passKey)) {
                                System.out.println("Equal");
                                matched = true;
                            }else {
                                System.out.println("Not equal");
                            }
                        }
                        if (matched) {
                            System.out.println("True");
                            return true;
                        }else {
                            System.out.println("False");
                            return false;
                        }
                    }else {
                        System.out.println("Empity resultset");
                    }
                    return false;
                }catch (Exception sqle){
                    System.out.println(sqle.toString());
                    sqle.printStackTrace();
                    return false;
                }
                return true;
            }

            /**
             *
             * @param connection Connection
             * @param email String
             * @return boolean
             */
            private static boolean searchUser(Connection connection, String email){

                //Faccio una chiamata al db
                Statement statement;
                String query;

                query = "SELECT email FROM users";

                try{
                    statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(query);

                    while (resultSet.next()){
                        //Controllo corrispondenze
                        if (resultSet.getString("email").equals(email))
                            return true;
                    }
                    return false;
                }catch (SQLException sqle){
                    sqle.printStackTrace();
                    return false;
                }
            }

            /**
             *
             * @param connection Connection
             * @param email String
             * @return boolean
             */
            private static boolean searchUserAtivated(Connection connection, String email){

                //Faccio una chiamata al db
                Statement statement;
                String query;

                query = "SELECT email,attivo FROM users";

                try{
                    statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(query);

                    while (resultSet.next()){
                        //Controllo corrispondenze
                        if (resultSet.getString("email").equals(email) &&
                                resultSet.getString("attivo").equals("1"))
                            return true;
                    }
                    return false;
                }catch (SQLException sqle){
                    sqle.printStackTrace();
                    return false;
                }
            }

            /**
             * Metodo per la connessione al database locale Heroku
             * @return Connection
             */
            private static Connection getConnectionHeroku(){
                try {
                    URI dbUri = null;
                    dbUri = new URI(System.getenv("DATABASE_URL"));

                    String username = dbUri.getUserInfo().split(":")[0];
                    String password = dbUri.getUserInfo().split(":")[1];
                    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

                    return DriverManager.getConnection(dbUrl, username, password);

                } catch (URISyntaxException e) {
                    e.printStackTrace();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                return null;
            }

            /**
             *
             * @return Connection
             */
            private static Connection getConnection(){

                Connection connection = null;
                try {

                    try {

                        Class.forName("org.postgresql.Driver");

                    } catch (ClassNotFoundException e) {

                        System.out.println("Where is your PostgreSQL JDBC Driver? "
                                + "Include in your library path!");
                        e.printStackTrace();
                        return null;

                    }

                    String url = "jdbc:postgresql://ec2-79-125-110-209.eu-west-1.compute.amazonaws.com:5432/" +
                            "d2qht4msggj59q?" +
                            "sslmode=require&user=sagdjsuxgvztxk&" +
                            "password=8be153a38455d94b7422704cec7de29ab6b0772c07f40a94f71932387641710a";

                    connection = DriverManager.getConnection(url);

                }
                catch (Exception e) {
                    System.err.println("Database connection failed");
                    System.err.println(e.getMessage());
                }

                return connection;

            }

            /**
             *
             * @param email String
             * @param text String
             * @param object String
             * @return boolean
             */
            private static boolean sendEmail(String email, String text, String object){

                // Sender's email ID needs to be mentioned
                String from = "alessandrogiordano.assetx@gmail.com";

                // Assuming you are sending email from localhost
                String host = "smtp.gmail.com";

                // Get system properties
                Properties properties = System.getProperties();

                // Setup mail server
                properties.setProperty("mail.smtp.host", host);

                properties.put("mail.smtp.starttls.enable", "true");
                properties.put("mail.smtp.port", "587");

                // Get the default Session object.
                Session session = Session.getDefaultInstance(properties);

                try {
                    // Create a default MimeMessage object.
                    MimeMessage message = new MimeMessage(session);



                    // Set From: header field of the header.
                    message.setFrom(new InternetAddress(from));

                    // Set To: header field of the header.
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

                    // Set Subject: header field
                    message.setSubject(object);

                    // Now set the actual message
                    message.setText(text);

                    // Send message
                    Transport transport = session.getTransport("smtp");
                    transport.connect("alessandrogiordano.assetx@gmail.com", "assetX1125");
                    transport.sendMessage(message, message.getAllRecipients());
                    return true;
                } catch (MessagingException mex) {
                    mex.printStackTrace();
                    return false;
                }
            }
        %>


    </body>
</html>