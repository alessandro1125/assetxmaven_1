<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.sql.*" %>
<html>
    <head>
        <title>Get Advertisment</title>
    </head>
    <body>

        <%

            //Reindirizzo al login
            //String redirectURL = "login.jsp?action=0";
            //response.sendRedirect(redirectURL);
            %><p><%= createTable()%></p><%

        %>

        <%!


            private static String createTable(){
                String result;
                Statement stmt = null;
                Connection connection;

                String query = "CREATE TABLE users (" +
                                    "ID int NOT NULL," +
                                    "email VARCHAR(255)," +
                                    "password VARCHAR(255), " +
                                    "nome VARCHAR(255)," +
                                    "cognome VARCHAR(255)," +
                                    "anno VARCHAR(255)," +
                                    "mese VARCHAR(255)," +
                                    "giorno VARCHAR(255)," +
                                    "passkey VARCHAR(255)," +
                                    "devices_uid VARCHAR(255)," +
                                    "PRIMARY KEY (ID));";

                try {
                    connection = getConnection();
                    stmt = connection.createStatement();
                    stmt.executeQuery(query);
                    result = "Succesfully done";
                    connection.close();
                    stmt.close();

                } catch (URISyntaxException e) {
                    e.printStackTrace();
                    result = e.toString();
                } catch (SQLException e) {
                    e.printStackTrace();
                    result = e.toString();
                }

                return result;
            }

            private static String select(){

                String result;
                Statement stmt = null;
                Connection connection;

                String query = "SELECT `email`FROM `Users` WHERE 1";

                try {
                    connection = getConnection();
                    stmt = connection.createStatement();
                    stmt.executeQuery(query);
                    result = "Succesfully done";
                    connection.close();
                    stmt.close();

                } catch (URISyntaxException e) {
                    e.printStackTrace();
                    result = e.toString();
                } catch (SQLException e) {
                    e.printStackTrace();
                    result = e.toString();
                }

                return result;

            }

            private static String delete(){
                String result;
                Statement stmt = null;
                Connection connection;

                String query = "DELETE FROM `Users` WHERE 1";

                try {
                    connection = getConnection();
                    stmt = connection.createStatement();
                    stmt.executeQuery(query);
                    result = "Succesfully done";
                    connection.close();
                    stmt.close();

                } catch (URISyntaxException e) {
                    e.printStackTrace();
                    result = e.toString();
                } catch (SQLException e) {
                    e.printStackTrace();
                    result = e.toString();
                }

                return result;
            }

            private static Connection getConnection() throws URISyntaxException, SQLException {

                URI dbUri = new URI(System.getenv("DATABASE_URL"));

                String username = dbUri.getUserInfo().split(":")[0];
                String password = dbUri.getUserInfo().split(":")[1];
                String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

                return DriverManager.getConnection(dbUrl, username, password);
            }


        %>

        Index jsp 2 <br>

    </body>
</html>
