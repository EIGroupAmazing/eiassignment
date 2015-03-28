/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utility.EMSMessageSender;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.xml.sax.*;
import org.w3c.dom.*;

/**
 *
 * @author ky
 */

@WebServlet(urlPatterns = {"/restaurants"})
public class RestaurantInfoController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try{
            out.println("Retriving available packages...");
            String username = request.getParameter("username");
            String postalCodeStr = request.getParameter("postalCode");
            int postalCode = Integer.parseInt(postalCodeStr);
            String xml = "<search_creteria>"+"<customer_id>"+username
                    +"</customer_id><postal_code>"+postalCode+"</postal_code></search_creteria>";
            
            //Throw XML to EMS sender
            EMSMessageSender msgSender = new EMSMessageSender("q.request.restaurantlist");
            String jmsOutput = msgSender.sendMessage(xml);
            
            //TODO: parse returned XMl to object list
            
            
            HttpSession session = request.getSession();
            session.setAttribute("customerid", "");
            session.setAttribute("email", "");
            session.setAttribute("phone","");
            //session.setAttribute("restaurants",);
            
            ArrayList<String[]> pkgList = new ArrayList();//The returned arraylist message will be stored here
            request.setAttribute("message",pkgList );
            RequestDispatcher dispatcher = request.getRequestDispatcher("/restaurantInfoForm.jsp");
            dispatcher.forward(request,response);

        }catch(NumberFormatException e){
            request.setAttribute("message","Wrong Input" );
            RequestDispatcher dispatcher = request.getRequestDispatcher("/restaurantInfoForm.jsp");
            dispatcher.forward(request,response);
        }
        
    }
    public boolean readXML(String xml){
        ArrayList<String> rolev;
        rolev = new ArrayList<String>();
        Document dom;
        // Make an  instance of the DocumentBuilderFactory
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        try {
            // use the factory to take an instance of the document builder
            DocumentBuilder db = dbf.newDocumentBuilder();
            // parse using the builder to get the DOM mapping of the    
            // XML file
            dom = db.parse(xml);

            Element doc = dom.getDocumentElement();

            role1 = getTextValue(doc, "role1");
            if (role1 != null) {
                if (!role1.isEmpty())
                    rolev.add(role1);
            }

            return true;

        } catch (ParserConfigurationException pce) {
            System.out.println(pce.getMessage());
        } catch (SAXException se) {
            System.out.println(se.getMessage());
        } catch (IOException ioe) {
            System.err.println(ioe.getMessage());
        }
        return true;
    }
    private String getTextValue(Element doc, String tag) {
        String value = null;
        NodeList nl;
        nl = doc.getElementsByTagName(tag);
        if (nl.getLength() > 0 && nl.item(0).hasChildNodes()) {
            value = nl.item(0).getFirstChild().getNodeValue();
        }
        return value;
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
