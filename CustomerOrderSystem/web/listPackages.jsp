<%-- 
    Document   : listPackages
    Created on : Mar 27, 2015, 6:00:09 PM
    Author     : Alex
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <ol style="list-style-type:disc">
<form action="demo_form.asp" method="get">
  <input type="checkbox" name="vehicle" value="Bike"> I have a bike<br>
  <input type="checkbox" name="vehicle" value="Car" checked> I have a car<br>
  <input type="submit" value="Submit">
</form>
    <%

        if (request.getAttribute("message")!=null){
            ArrayList<String[]> packages = (ArrayList)request.getAttribute("message");
            for(int i=0;i<packages.size();i++){
                String[] currentRestaurant = packages.get(i);
                %>
    <li>
                <%
                out.println(currentRestaurant[0]);
                %>
    <ol>
    
                <%
                for(int j=1;j<currentRestaurant.length;j++){
                    out.println("<li>"+currentRestaurant[j]+"</li>");
                }
                %>
                
    </ol></li>
                <%
            }
        }
    %>
    
        </ol>
    </body>
</html>
