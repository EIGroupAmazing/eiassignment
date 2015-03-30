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
        <title>Select our premium meal packages</title>
    </head>
    <body>
        <%
            if (request.getAttribute("error")!=null){
                out.println( (String)request.getAttribute("error"));
            }
            %>
        <form action="take-order" method="post">
            
    <%

        if (request.getAttribute("message")!=null){
            ArrayList<Restaurant> restList = (ArrayList<Restaurant>)request.getAttribute("message");
            for(int i=0;i<restList.size();i++){
                Restaurant currentRestaurant = restList.get(i);
                String restName = currentRestaurant.getName();
                ArrayList<Pkg> pkgList = currentRestaurant.getPkgList();
                %>
                <b>Restaurant name: <%=restName%></b><br>
                <%for(int j=0;j<pkgList.size();j++){
                    Pkg currentPkg = pkgList.get(j);
                    String pkgName = currentPkg.getName();
                    String pkgDetail = currentPkg.getDetail().replaceAll("\n", "<br>");
                    String pkgPrice = currentPkg.getPrice();
                %>
                    <input type="checkbox" name="package" value="<%=restName+"\t"%><%=pkgName%>"><%=pkgName%><br>
                    - Package price : <span><%=pkgPrice%></span><br>
                    - Package description : <%=pkgDetail%><br>
                <%}%>
                <br>
                <%
            }
        }
    %>
        
      <input type="submit" value="Submit">
    </form>
    </body>
</html>
