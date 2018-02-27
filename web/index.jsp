<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.sql.*" %>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>

        <%

            //Reindirizzo al login
            //String redirectURL = "login.jsp?action=0";
            //response.sendRedirect(redirectURL);
            %><p><%= executeQuery()%></p><%

        %>

        <%!


            private static String executeQuery(){
                String result = null;

                Statement stmt = null;
                Connection connection;

                String query = "CREATE TABLE orders (" +
                                    "ID int NOT NULL AUTO_INCREMENT," +
                                    "email VARCHAR(255)," +
                                    "password VARCHAR(255), " +
                                    "nome," +
                                    "cognome," +
                                    "anno," +
                                    "mese," +
                                    "giorno," +
                                    "passkey," +
                                    "devices_uid" +
                                    "PRIMARY KEY (ID);";

                try {
                    connection = getConnection();
                    stmt = connection.createStatement();
                    stmt.executeQuery(query);
                    result = "Succesfully done";
                    connection.close();
                } catch (URISyntaxException e) {
                    e.printStackTrace();
                    result = e.toString();
                } catch (SQLException e) {
                    e.printStackTrace();
                    result = e.toString();
                }finally {
                    if (stmt != null) {
                        try {
                            stmt.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
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
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.sql.*" %>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>

        <%

            //Reindirizzo al login
            String redirectURL = "login.jsp";
            response.sendRedirect(redirectURL);




        %>

        <%!


            private static void executeQuery(){
                String result = null;

                Statement stmt = null;
                Connection connection;

                String query = "CREATE TABLE orders (channel VARCHAR(255));";
                for(int i = 0; i<30; i++) {
                    try {
                        connection = getConnection();
                        stmt = connection.createStatement();
                        //stmt.executeQuery(query); TODO execute query
                        result = "Connection succesfuly done";
                        /*
                        while (rs.next()) {
                            String coffeeName = rs.getString("COF_NAME");
                            int supplierID = rs.getInt("SUP_ID");
                            float price = rs.getFloat("PRICE");
                            int sales = rs.getInt("SALES");
                            int total = rs.getInt("TOTAL");
                            System.out.println(coffeeName + "\t" + supplierID +
                                    "\t" + price + "\t" + sales +
                                    "\t" + total);
                        }
                        */



                        connection.close(); //TODO chiuderer sempre connessione per evitare troppe connessioni simultanee
                    } catch (SQLException e) {
                        e.printStackTrace();
                        result = e.toString();
                    } catch (URISyntaxException e) {
                        e.printStackTrace();
                    } finally {
                        if (stmt != null) {
                            try {
                                stmt.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
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
>>>>>>> 76a969e699bd80e1b5dcd610077a4b1e39639dea
