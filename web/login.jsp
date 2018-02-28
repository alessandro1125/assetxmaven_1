<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html lang="it" dir="ltr">
    <head>
        <title>AssetCopier</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="formstyle.css" rel="stylesheet" type="text/css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3mobile.css">
    </head>
    <body class="form-style-8">

        <%
            //Controllo l'action
            int action = 0;
            String message, base64Message;

            try {
                if(request.getParameter("message") != null){
                    try{
                        base64Message = request.getParameter("message");
                        message = new String(Base64.getDecoder().decode(base64Message));
                        //Stampo il message
                        %>
                        <p class="form-style-8"><%= message %></p>
                        <%
                    }catch (NullPointerException e){
                        e.printStackTrace();
                    }
                }
            }catch (Exception e){
                e.printStackTrace();
            }

            try{
                if(request.getParameter("action") != null){
                    try{
                        action = Integer.parseInt(request.getParameter("action"));
                    }catch (NullPointerException e){
                        e.printStackTrace();
                    }
                }
            }catch (Exception e){
                action = 0;
            }


            switch (action){
                case 0:
                    //Mostro il form per il login
                    %>


        <br>
        <div dir="ltr" style="text-align: center;background-color:white;font-family:sans-serif;font-weight:lighter;color:#595959;">
            <div class="form-style-8">
                <h2>Login</h2>
                <form action="login.jsp?action=1" method="post">
                    <input type="email" name="email" placeholder="Your email..."/>
                    <input type="password" name="password" placeholder="Your password..."/>
                    <input type="submit" value="Login">
                </form>
                <form action="create_account.jsp" method="get">
                    <input type="submit" value="Sign In">
                </form>
                </form>
                <form action="reset_password.jsp" method="get">
                    <input type="submit"value="Reset Password">
                </form>
            </div>
        </div>
        <div class = "form-style-8" style="bottom:0px;left:20%;">
            Contacts:<blockquote> urimkuci.assetx@gmail.com<br>alessandrogiordano.assetx@gmail.com</blockquote>
        </div>

                    <%
                    break;
                case 1:

                    //FACCIO IL LOGIN

                    String email = null;
                    String password = null;

                    try{
                        email = request.getParameter("email");
                        password = request.getParameter("password");
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                    //Mi connetto al db
                    Connection connection;
                    connection = getConnectionHeroku();

                    if(connection != null){
                        if(email != null  && password != null){

                            //Cerco la corrispondenza nella tabella users

                            switch (authenticateUser(connection, email, password)){
                                case 0:
                                    //Login succesfully done
                                    //redirect nella area personale
                                    RequestDispatcher dispatcher;
                                    dispatcher = request.getRequestDispatcher("uids_dashboard.jsp?email=" + email +
                                            "&password=" + password);
                                    dispatcher.forward(request, response);
                                    break;

                                case 1:
                                    //Email Wrong
                                    System.out.println("User email not found");
                                    //Invio un messaggio all'utente
                                    errorOccurred(response, "User doesn't exist");
                                    break;

                                case 2:
                                    //Password wrong
                                    System.out.println("User password not correct");
                                    //Invio un messaggio all'utente
                                    errorOccurred(response, "Password wrong");
                                    break;
                                default:

                            }


                            /*
                            HashMap<String, Object> map = new HashMap();
                            map.put("email", "user1@gmail.com");
                            map.put("password", "password11252220");
                            map.put("nome", "user1@gmail.com");
                            map.put("cognome", "user1@gmail.com");
                            map.put("anno", "user1@gmail.com");
                            map.put("mese", "user1@gmail.com");
                            map.put("giorno", "user1@gmail.com");
                            map.put("attivo", "1");
                            map.put("passkey", "0");
                            map.put("devices_uid", "0");*/

                            //addSql(connection , map, "users");

                            //String[] res = selectSql(connection, "attivo", "users");

                            %><p><%= connection.toString()%><br></p><%

                        }else {
                            //Se uno e entrambi i cambi sono nulli
                            System.out.println("Parameters are not valid");
                            //Invio un messaggio all'utente
                            errorOccurred(response, "Enter valids parameters");
                        }

                        try {
                            connection.close();
                        }catch (SQLException e){
                            e.printStackTrace();
                        }

                    }else {
                        //Se fallisce la connessione al database
                        System.out.println("Unable to connect to database");
                        //Invio un messaggio all'utente
                        errorOccurred(response, "An error has occurred");
                    }

                break;
            }



        %>


        <%!
            /**
             *
             * @param httpSerletResponse HttpServletResponse
             * @param message String
             */
            private static void errorOccurred(HttpServletResponse httpSerletResponse, String message){
                byte[] messageBy = Base64.getEncoder().encode(message.getBytes());
                String redirectURL = "login.jsp?action=0&message=" + new String(messageBy);
                try {
                    httpSerletResponse.sendRedirect(redirectURL);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            /**
             *
             * @param connection Connection
             * @param email String
             * @param password String
             * @return int
             */
            private static int authenticateUser(Connection connection, String email, String password){

                Statement statement;
                String query;

                query = "SELECT email,password FROM users";

                try{
                    statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(query);

                    boolean emailFounded = false;
                    boolean passwordFounded = false;
                    while (resultSet.next()){
                        //Controllo corrispondenze
                        if (resultSet.getString("email").equals(email))
                            emailFounded = true;
                        if (emailFounded && resultSet.getString("password").equals(password))
                            passwordFounded = true;
                    }
                    //Genero output
                    if (!emailFounded)
                        return 1;
                    if (!passwordFounded)
                        return 2;
                    return 0;


                }catch (SQLException sqle){
                    sqle.printStackTrace();
                    return -1;
                }

            }

            /**
             * Select from SQL database
             * @param names ArrayList<String>
             * @param table String
             * @return ArrayList<Hashmap<String, String>>
             */
            private static ArrayList<HashMap<String, String>> selectSql(Connection connection, ArrayList<String> names, String table){

                Statement stmt;
                ArrayList<HashMap<String, String>> result = new ArrayList();
                String queryNames;
                StringBuilder namesBuilder = new StringBuilder();
                for (int i = 0; i < names.size(); i++){
                    if(i < names.size()-1)
                        namesBuilder.append(names.get(i)).append(", ");
                    namesBuilder.append(names.get(i));
                }
                queryNames = namesBuilder.toString();

                String query = "SELECT "+ queryNames + " FROM " + table;//TODO più names

                try {
                    stmt = connection.createStatement();

                    ResultSet rs = stmt.executeQuery(query);
                    while (rs.next()) {
                        HashMap<String, String> tmpRes = new HashMap();
                        for (String key : names){
                            tmpRes.put(key, rs.getString(key));
                        }
                        result.add(tmpRes);
                    }
                    if (result.size() == 0)
                        return null;

                    stmt.close();

                } catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println(e.toString());
                    return null;
                }

                return result;
            }

            /**
             *
             * @param connection Connection
             * @param record HashMap<String, Object>
             * @param table String
             */
            private void addSql(Connection connection, HashMap<String, Object> record, String table){

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
                    stmt.executeQuery(query);
                    stmt.close();

                }catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println(e.toString());
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

        %>
    </body>
</html>
