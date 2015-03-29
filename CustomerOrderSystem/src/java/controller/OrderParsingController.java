/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.methods.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Pkg;
import model.Restaurant;
import utility.EMSMessageSender;


@WebServlet(name = "OrderParingController", urlPatterns = {"/take-order"})
public class OrderParsingController extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println("Processing request...");
            String[] chosen = request.getParameterValues("package");
            if(chosen==null||chosen.length!=0){
                
            }
            HttpSession session = request.getSession();
            String customerId = (String)session.getAttribute("customerid");
            String email = (String)session.getAttribute("email");
            String phone = (String)session.getAttribute("phone");
            String postcode = (String)session.getAttribute("postcode");
            ArrayList<Restaurant> restList = (ArrayList<Restaurant>) session.getAttribute("restList");
            System.out.println(customerId+email+phone);
            ArrayList<Pkg> selected = new ArrayList<Pkg>();
            double totalPrice = 0;
            String chosenRestName = null;
            boolean validInput = true;
            for(String chosenPkgName: chosen){
                String[] split = chosenPkgName.split("\t");
                String splitp = split[1];
                String splitr = split[0];
                if(chosenRestName==null&&splitp!=null&&!splitp.isEmpty()){
                    chosenRestName = splitr;
                }
                if(chosenRestName!=null&&!chosenRestName.equals(splitr)){
                    validInput = false;
                    break;
                }
                for(Restaurant r: restList){
                    ArrayList<Pkg> pkgInRest = r.getPkgList();
                    String restName = r.getName();
                    if(restName.equals(chosenRestName)){
                        for(Pkg p: pkgInRest){
                            if (p.getName().equals(splitp)){
                                totalPrice += Double.parseDouble(p.getPrice());
                                selected.add(p);
                            }
                        }
                        break;
                    }
                }
            }
            if(chosenRestName==null){
                validInput=false;
            }
            if (!validInput){
                System.out.println("redirecting to listPackages.jsp");
                request.setAttribute("error","Please select pakages from one and only one restaurant!" );
                request.setAttribute("message",restList );
                RequestDispatcher dispatcher = request.getRequestDispatcher("/listPackages.jsp");
                dispatcher.forward(request,response);
                
            }else{
                String fullQuery = "item="+chosenRestName+"&amount="+totalPrice;

                
                response.sendRedirect("http://ezname.heroku.com/payments?"+fullQuery);
                
                String orderXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
                orderXML += "<Order><customerId>"+customerId+"</customerId>";
                orderXML += "<email>"+email+"</email>";
                orderXML += "<phoneNumber>"+phone+"</phoneNumber>";
                orderXML += "<postcode>"+postcode+"</postcode>";
                //Iterator mapIter = pkgMap.entrySet().iterator();
                orderXML += "<restaurant>";
                orderXML += "<restaurantName>"+chosenRestName+"</restaurantName>";
                for (Pkg p:selected){
                    orderXML += "<packages>";
                    orderXML += "<package_name>"+p.getName()+"</package_name>";
                    orderXML += "<package_detail>"+p.getDetail()+"</package_detail>";
                    orderXML += "<package_price>"+p.getPrice()+"</package_price>";
                    orderXML += "</packages>";
                }
                orderXML += "</restaurant>";
                orderXML += "<totalPrice>"+totalPrice+"</totalPrice></Order>";
                session.setAttribute("xml", orderXML);
                /*
                    Specifying queue name
                */
                PrintWriter writer = new PrintWriter("order.xml", "UTF-8");
                writer.println(orderXML);
                writer.close();
                EMSMessageSender emsSender = new EMSMessageSender("q.request.placeorder","192.168.137.254");
                //emsSender.sendMessage(orderXML,false);

                //request.setAttribute("message","Your order is being processed. We will "
                 //       + "send you an SMS message and email for delivery time." );
                //RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                //dispatcher.forward(request,response);
            }
            
        
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
