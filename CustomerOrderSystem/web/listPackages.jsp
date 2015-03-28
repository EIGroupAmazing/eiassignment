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
        <form action="/take-order" method="post">

  Bike
  <input type="checkbox" name="package" value="Car"> I have a car<br>
  <input type="submit" value="Submit">
</form>
    <%

        if (request.getAttribute("message")!=null){
            ArrayList<String[]> packages = (ArrayList)request.getAttribute("message");
            for(int i=0;i<packages.size();i++){
                String[] currentRestaurant = packages.get(i);
                %>
                <b><%=currentRestaurant[0]%></b><br>
                <input type="checkbox" name="package" value="<%=currentRestaurant[0]%>/<%=currentRestaurant[j]%>"><%=currentRestaurant[j]%><br>
    
                <%
                for(int j=1;j<currentRestaurant.length;j++){
                    out.println("<li>"+currentRestaurant[j]+"</li>");
                }
                %>
                <%
            }
        }
    %>
    </form>
    </body>
</html>
