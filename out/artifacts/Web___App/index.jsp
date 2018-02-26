<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.net.URI" %>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>

        <%
            Connection connection = getConnection();
            String result = connection.getCatalog();

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
        <%= result%>
    </body>
</html>
