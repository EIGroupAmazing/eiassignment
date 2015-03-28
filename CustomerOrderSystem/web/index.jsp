<%-- 
    Document   : index
    Created on : Mar 27, 2015, 2:34:09 PM
    Author     : Alex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form  action="/retrieve-packages" method="get">
            Enter your postal code: <input type="text" name="postalcode" >
            Enter your Customer ID: <input type="text" name="usernmae">
        </form>
    </body>
    
</html>
