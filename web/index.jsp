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
