<%-- 
    Document   : restaurantInfoForm
    Created on : Mar 27, 2015, 2:38:34 PM
    Author     : ky
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Restaurant Info</title>
    </head>
    <body>
        <form method="post" action="/restaurant/info">
            Postal Code: <input type="text" name="postalCode">
            <input type="submit" value="Search!">
        </form>
    </body>
</html>
