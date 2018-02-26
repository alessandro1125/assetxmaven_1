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
            Connection connection = getConnection();

            String result = null;

            Statement stmt = null;
            String query = "CREATE TABLE orders (channel VARCHAR(255));";
            for(int i = 0; i<30; i++) {
                try {
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

                } catch (SQLException e) {
                    e.printStackTrace();
                    result = e.toString();
                } finally {
                    if (stmt != null) {
                        stmt.close();
                    }
                }
                %>
                <%= result %><br>
                <%
            }
        %>

        <%!


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
