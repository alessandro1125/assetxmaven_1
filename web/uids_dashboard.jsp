<%@ page import="java.util.GregorianCalendar" %><%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 28/02/2018
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String time = GregorianCalendar.getInstance().getTime().toString();
    %>
    <title>UID dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="formstyle.css?<%= time %>" rel="stylesheet" type="text/css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3mobile.css">
</head>
<body style="min-width: 1000px">
    <div id="toolbar" class="form-style-8-toolbar">
        <h1>Get Advertisment Devices Dashboard</h1>

        <input type="button" value="Log Out" class="form-style-1" style=
                "border-radius: 2px; width: 100px; position: absolute;
                 right: 20px; color: #e6e6e6; display: inline;">
    </div>
</body>
</html>
