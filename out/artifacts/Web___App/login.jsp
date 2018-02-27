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
    <body>

        <%
            //Controllo l'action
            int action = 0;
            String message = null;
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
                    //Faccio il login



            }



        %>
    </body>
</html>
