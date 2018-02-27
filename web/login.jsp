<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
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
            String message;
            if(request.getParameter("message") != null){
                try{
                    message = request.getParameter("message");
                    //Stampo il message
                    %>
                        <div class="form-style-8"><%= message %></div>
                    <%
                }catch (NullPointerException e){
                    e.printStackTrace();
                }
            }
            if(request.getParameter("action") != null){
                try{
                    action = Integer.parseInt(request.getParameter("action"));
                }catch (NullPointerException e){
                    e.printStackTrace();
                }
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
                    <input type="submit" value="Create Account">
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

                    Connection connection = getConnection();

                    //Faccio il login
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
                    map.put("devices_uid", "0");

                    //addSql(connection , map, "users");

                    String[] res = selectSql(connection, "attivo", "users");
                    for (String stringa : res){
                        %><p><%= stringa%><br></p><%
                    }

                break;
            }



        %>


        <%!


            /**
             * Select from SQL database
             * @param name
             * @param table
             * @return
             */
            private static String[] selectSql(Connection connection, String name, String table){

                String result[];
                ArrayList<String> recordsArr = new ArrayList();
                Statement stmt;

                String query = "SELECT "+ name + " FROM "+table;//TODO più names

                try {
                    stmt = connection.createStatement();

                    ResultSet rs = stmt.executeQuery(query);
                    while (rs.next()) {
                        String lastName = rs.getString("email");
                        recordsArr.add(lastName);
                    }
                    if (recordsArr.size() == 0)
                        return null;

                    result = new String[recordsArr.size()];
                    for (int i = 0; i < recordsArr.size(); i++)
                        result[i] = recordsArr.get(i);

                    stmt.close();

                } catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println(e.toString());
                    return null;
                }

                return result;
            }

            /**
             * Add SQL records to SQL database
             * @return
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
             * @return
             */
            private static Connection getConnection(){
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



        %>
    </body>
</html>
