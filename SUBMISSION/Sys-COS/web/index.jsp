<!DOCTYPE html>
<html lang="en">

<head>

    <title>Restaurant Info</title>

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
<p>
            <%
            //retrieve the json from the request parameter, then convert and display
            if (request.getAttribute("message")!=null){
                out.println( (String)request.getAttribute("message"));
            }
            %>
        </p>
  
                    <center><img class="img-responsive" src="img/4.png" height="200" width="200" ></center>



    <!-- Contact Section -->
    <section id="contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h3>Enter your id and postalcode to start!</h3>
                    
                    <hr class="star-primary">
                </div>
            </div>
            <form method="post" action="restaurants">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
                    <!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                               
                                <input type="text" class="form-control" name="username" placeholder="Customer ID"  required >
                               
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="form-group col-xs-12 floating-label-form-group controls">
                               
                                <input type="text" class="form-control"  name="postalCode"placeholder="Postal Code"  required ">
                            </div>
                        </div>
                        <br>

                        <div class="row">
                           
                                <center><button type="submit" class="btn btn-success btn-lg">Send</button></center>
                            
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

   


</body>

</html>
