<%-- 
    Document   : listPackages
    Created on : Mar 27, 2015, 6:00:09 PM
    Author     : Alex
--%>

<%@page import="model.Pkg"%>
<%@page import="model.Restaurant"%>
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
    <%

        if (request.getAttribute("message")!=null){
            ArrayList<Restaurant> restList = (ArrayList<Restaurant>)request.getAttribute("message");
            for(int i=0;i<restList.size();i++){
                Restaurant currentRestaurant = restList.get(i);
                String restName = currentRestaurant.getName();
                ArrayList<Pkg> pkgList = currentRestaurant.getPkgList();
                %>
                <b><%=restName%></b><br>
                <%for(int j=1;j<pkgList.size();j++){
                    Pkg currentPkg = pkgList.get(j);
                    String pkgName = currentPkg.getName();
                    String pkgDetail = currentPkg.getDetail();
                    String pkgPrice = currentPkg.getPrice();
                %>
                    <input type="checkbox" name="package" value="<%=restName%>/<%=pkgName%>"><%=pkgName%><br>
                    Package price : <%=pkgPrice%><br>
                    Package description : <%=pkgDetail%><br>
                <%}%>
                <%
            }
        }
    %>
        
      <input type="submit" value="Submit">
    </form>
    </body>
</html>
