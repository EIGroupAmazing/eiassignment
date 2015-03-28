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
import model.Customer;
import model.Restaurant;
import utility.EMSMessageSender;
import utility.XMLParser;

/**
 *
 * @author Alex
 */
@WebServlet(name = "RestaurantRetrievalController", urlPatterns = {"/restaurants"})
public class RestaurantRetrievalController extends HttpServlet {

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
        try {
            out.println("I'm in here");
            String username = request.getParameter("username");
            String postalCodeStr = request.getParameter("postalCode");
            int postalCode = Integer.parseInt(postalCodeStr);
            String xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><search_creteria>"+"<customer_id>"+username
                    +"</customer_id><postal_code>"+postalCode+"</postal_code></search_creteria>";
            
            //Throw XML to EMS sender
            EMSMessageSender msgSender = new EMSMessageSender("q.request.restaurantlist");
            //String jmsOutput = msgSender.sendMessage(xml);
            String jmsOutput = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
"<!-- Created with Liquid XML 2014 Developer Bundle Edition (Education) 12.2.8.5459 (http://www.liquid-technologies.com) -->\n" +
"<ns:result xmlns:ns=\"http://xmlns.example.com/unique/default/namespace/1134438639123\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://xmlns.example.com/unique/default/namespace/1134438639123 file:///C:/Users/Alex/Downloads/Telegram%20Desktop/restaurant_list.xsd\">\n" +
"    <ns:customer>\n" +
"        <ns:id>string</ns:id>\n" +
"        <ns:email>string</ns:email>\n" +
"        <ns:phone>string</ns:phone>\n" +
"    </ns:customer>\n" +
"    <ns:restaurant>\n" +
"        <ns:packages>\n" +
"            <ns:package_name>string</ns:package_name>\n" +
"            <ns:package_detail>string</ns:package_detail>\n" +
"            <ns:package_price>-5094.7250941961</ns:package_price>\n" +
"        </ns:packages>\n" +
"        <ns:name>string</ns:name>\n" +
"    </ns:restaurant>\n" +
"    <ns:restaurant>\n" +
"        <ns:packages>\n" +
"            <ns:package_name>string</ns:package_name>\n" +
"            <ns:package_detail>string</ns:package_detail>\n" +
"            <ns:package_price>2252.0949058039</ns:package_price>\n" +
"        </ns:packages>\n" +
"        <ns:packages>\n" +
"            <ns:package_name>string</ns:package_name>\n" +
"            <ns:package_detail>string</ns:package_detail>\n" +
"            <ns:package_price>-3621.1650941961</ns:package_price>\n" +
"        </ns:packages>\n" +
"        <ns:packages>\n" +
"            <ns:package_name>string</ns:package_name>\n" +
"            <ns:package_detail>string</ns:package_detail>\n" +
"            <ns:package_price>2317.7749058039</ns:package_price>\n" +
"        </ns:packages>\n" +
"        <ns:packages>\n" +
"            <ns:package_name>string</ns:package_name>\n" +
"            <ns:package_detail>string</ns:package_detail>\n" +
"            <ns:package_price>1929.7949058039</ns:package_price>\n" +
"        </ns:packages>\n" +
"        <ns:name>string</ns:name>\n" +
"    </ns:restaurant>\n" +
"    <ns:restaurant>\n" +
"        <ns:name>string</ns:name>\n" +
"    </ns:restaurant>\n" +
"    <ns:restaurant>\n" +
"        <ns:packages>\n" +
"            <ns:package_name>string</ns:package_name>\n" +
"            <ns:package_detail>string</ns:package_detail>\n" +
"            <ns:package_price>9752.7349058039</ns:package_price>\n" +
"        </ns:packages>\n" +
"        <ns:packages>\n" +
"            <ns:package_name>string</ns:package_name>\n" +
"            <ns:package_detail>string</ns:package_detail>\n" +
"            <ns:package_price>27.4949058039</ns:package_price>\n" +
"        </ns:packages>\n" +
"        <ns:name>string</ns:name>\n" +
"    </ns:restaurant>\n" +
"    <ns:restaurant>\n" +
"        <ns:packages>\n" +
"            <ns:package_name>string</ns:package_name>\n" +
"            <ns:package_detail>string</ns:package_detail>\n" +
"            <ns:package_price>2280.2749058039</ns:package_price>\n" +
"        </ns:packages>\n" +
"        <ns:name>string</ns:name>\n" +
"    </ns:restaurant>\n" +
"</ns:result>";
            //TODO: parse returned XMl to object list
            XMLParser xp = new XMLParser(jmsOutput);
            Object[] objectOutput = xp.getParsingResult();
            Customer cust = (Customer)objectOutput[0];
            ArrayList<Restaurant> restList = (ArrayList<Restaurant>)objectOutput[1];
            
            HttpSession session = request.getSession();
            session.setAttribute("customerid", cust.getId());
            session.setAttribute("email", cust.getEmail());
            session.setAttribute("phone",cust.getPhone());
            session.setAttribute("restList",restList);
            
            //ArrayList<String[]> pkgList = new ArrayList();//The returned arraylist message will be stored here
            request.setAttribute("message",restList );
            RequestDispatcher dispatcher = request.getRequestDispatcher("/restaurantInfoForm.jsp");
            dispatcher.forward(request,response);

        }catch(NumberFormatException e){
            request.setAttribute("message","Wrong Input" );
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request,response);
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