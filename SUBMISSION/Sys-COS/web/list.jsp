m<%-- 
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
         <!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/freelancer.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    </head>
    <body id="page-top" class="index" background ="img/3.png">
     <center><img class="img-responsive" src="img/4.png" height="150" width="150" ></center>
    <center><h3>Choose your Meal of Today!<h3></center>
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
                <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                <center><h3>Restaurant name: <%=restName%></h3></center><br>
                <%for(int j=0;j<pkgList.size();j++){
                    Pkg currentPkg = pkgList.get(j);
                    String pkgName = currentPkg.getName();
                    String pkgDetail = currentPkg.getDetail();
                    String pkgPrice = currentPkg.getPrice();
                %>
                <center><b><big><input type="checkbox" name="package" value="<%=restName+"\t"%><%=pkgName%>"><%="  "+pkgName%></big></b></center><br>
                    
                    <center><font color="white"><h5> - PACKAGE PRICE -<h5> <span></font></span></center>
                    <center><font color="white"><%=pkgPrice%></font></center><
                    <center><h5><font color="white">-PACKAGE DESCRIPTION- <h5></font></center>
                    <center><font color="white"><%=pkgDetail%></font></center><br>
                <%}%>
                  </div>
                        </div>
                <br>
                <%
            }
        }
    %>
        
     <center><button type="submit" class="btn btn-success">Submit</button></center>
    </form>
    </body>
</html>
