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
    <title>UID dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="formstyle.css" rel="stylesheet" type="text/css?<%= GregorianCalendar.getInstance().getTime().toString()%>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3mobile.css">
</head>
<body style="min-width: 1000px">
    <div id="toolbar" class="form-style-8" style="min-width: 1000px; max-width: 100%; width: 100%; margin-top: 0; height: 70px; padding: 10px; background: #ff4d4d;">
        <h1>Get Advertisment Devices Dashboard</h1>

        <input type="button" value="Log Out" class="form-style-1" style=
                "border-radius: 2px; width: 100px; position: absolute;
                 right: 20px; color: #808080; display: inline;">
    </div>
</body>
</html>
