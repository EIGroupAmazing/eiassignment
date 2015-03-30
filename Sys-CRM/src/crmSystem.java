import java.util.*;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.jms.*;
public class crmSystem implements ExceptionListener {
    /*-----------------------------------------------------------------------
     * Parameters
     *----------------------------------------------------------------------*/

    String serverUrl = null;
    String userName = null;
    String password = null;
    String name = "topic.sample";
    boolean useTopic = true;

    /*-----------------------------------------------------------------------
    * Variables
    *----------------------------------------------------------------------*/
    javax.jms.Connection connection = null;
    Session session = null;
    MessageConsumer msgConsumer = null;
    Destination destination = null;

    public crmSystem(String[] args) {
        parseArgs(args);

        try {
            tibjmsUtilities.initSSLParams(serverUrl, args);
        }
        catch (JMSSecurityException e) {
            System.err.println("JMSSecurityException: " + e.getMessage() + ", provider=" + e.getErrorCode());
            e.printStackTrace();
            System.exit(0);
        }

        /* print parameters */
        System.err.println("\n------------------------------------------------------------------------");
        System.err.println("Customer Relationship Management System");
        System.err.println("------------------------------------------------------------------------");
        System.err.println("Server....................... " + ((serverUrl != null) ? serverUrl : "localhost"));
        System.err.println("User......................... " + ((userName != null) ? userName : "(null)"));
        System.err.println("Destination.................. " + name);
        System.err.println("------------------------------------------------------------------------\n");

        try {
            run();
        } catch (JMSException e) {
            e.printStackTrace();
        }
    }


    /*-----------------------------------------------------------------------
     * usage
     *----------------------------------------------------------------------*/
    void usage() {
        System.err.println("\nUsage: tibjmsMsgConsumer [options] [ssl options]");
        System.err.println("");
        System.err.println("   where options are:");
        System.err.println("");
        System.err.println(" -server   <server URL> - EMS server URL, default is local server");
        System.err.println(" -user     <user name>  - user name, default is null");
        System.err.println(" -password <password>   - password, default is null");
        System.err.println(" -topic    <topic-name> - topic name, default is \"topic.sample\"");
        System.err.println(" -queue    <queue-name> - queue name, no default");
        System.err.println(" -help-ssl              - help on ssl parameters\n");
        System.exit(0);
    }

    /*-----------------------------------------------------------------------
     * parseArgs
     *----------------------------------------------------------------------*/
    void parseArgs(String[] args) {
        int i = 0;

        while (i < args.length) {
            if (args[i].compareTo("-server") == 0) {
                if ((i + 1) >= args.length) usage();
                serverUrl = args[i + 1];
                i += 2;
            } else if (args[i].compareTo("-topic") == 0) {
                if ((i + 1) >= args.length) usage();
                name = args[i + 1];
                i += 2;
            } else if (args[i].compareTo("-queue") == 0) {
                if ((i + 1) >= args.length) usage();
                name = args[i + 1];
                i += 2;
                useTopic = false;
            } else if (args[i].compareTo("-user") == 0) {
                if ((i + 1) >= args.length) usage();
                userName = args[i + 1];
                i += 2;
            } else if (args[i].compareTo("-password") == 0) {
                if ((i + 1) >= args.length) usage();
                password = args[i + 1];
                i += 2;
            } else if (args[i].compareTo("-help") == 0) {
                usage();
            } else if (args[i].compareTo("-help-ssl") == 0) {
                tibjmsUtilities.sslUsage();
            } else if (args[i].startsWith("-ssl")) {
                i += 2;
            } else {
                System.err.println("Unrecognized parameter: " + args[i]);
                usage();
            }
        }
    }


    /*---------------------------------------------------------------------
     * onException
     *---------------------------------------------------------------------*/
    public void onException(
            JMSException e) {
        /* print the connection exception status */
        System.err.println("CONNECTION EXCEPTION: " + e.getMessage());
    }

    /*-----------------------------------------------------------------------
     * run
     *----------------------------------------------------------------------*/
    void run()
            throws JMSException {
        Message msg = null;
        String msgType = "UNKNOWN";

        System.err.println("Subscribing to destination: " + name + "\n");

        ConnectionFactory factory = new com.tibco.tibjms.TibjmsConnectionFactory(serverUrl);

        /* create the connection */
        connection = factory.createConnection(userName, password);

        /* create the session */
        session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        /* set the exception listener */
        connection.setExceptionListener(this);

        /* create the destination */
        if (useTopic)
            destination = session.createTopic(name);
        else
            destination = session.createQueue(name);

        /* create the consumer */
        msgConsumer = session.createConsumer(destination);

        /* start the connection */
        connection.start();

        while (true) {
            /* receive the message */
            msg = msgConsumer.receive();

            if (msg == null)
                break;
            onMessage(msg);     //karway
            //System.err.println("Received message: " + msg);
        }

        /* close the connection */
        connection.close();
    }

    /*-----------------------------------------------------------------------
     * main
     *----------------------------------------------------------------------*/
    public static void main(String[] args) {
        new crmSystem(args);
    }

    // Handle the message when received.
    public void onMessage(Message message) {
        try {
            if ((message instanceof TextMessage) ) {
                TextMessage requestMessage = (TextMessage) message;

                
                //System.out.println("\tTime:       " + System.currentTimeMillis() + " ms");
                System.out.println("\tMessage ID: " + requestMessage.getJMSMessageID());
                System.out.println("\tCorrel. ID: " + requestMessage.getJMSCorrelationID());
                System.out.println("\tReply to:   " + requestMessage.getJMSReplyTo());
                //System.out.println("\tContents:   " + requestMessage.getText());
                
                
                
                
              
                
                 String receivedMsg = requestMessage.getText();
                    String sortedList = null;
                if(!receivedMsg.contains("<")){
                    System.out.println("\nReceived Updating request!");
                    String cid = receivedMsg.substring(0,receivedMsg.indexOf(','));
                    String rest =receivedMsg.substring(receivedMsg.indexOf(',')+1);
                    System.out.println("----------------------------------------------------------------------");
                    System.out.println("Customer id:"+ cid);
                    System.out.println("Restaurant:"+ rest);
                    System.out.println("----------------------------------------------------------------------");
                    insertNew( cid,  rest);
                    System.out.println("UPDATED!");
                
                }else{
                    String cid = receivedMsg.substring(0, receivedMsg.indexOf('<'));
                    String unsortedList = receivedMsg.substring(receivedMsg.indexOf('<'));
                    System.out.println("\nReceived Ranking request from Restaurant Management System!");
                    System.out.println("----------------------------------------------------------------------");
                    System.out.println("Customer id:"+ cid);
                    System.out.println("----------------------------------------------------------------------");
                    System.out.println("Retrieving Preference........");
                   sortedList = sortRestaurants(unsortedList,cid);
                }

                // Prepare reply message and send reply message
                Destination replyDestination = message.getJMSReplyTo();
                MessageProducer replyProducer = session.createProducer(replyDestination);
                TextMessage replyMessage = session.createTextMessage();
                // Hardcoded the replyMessage to for this example.
                replyMessage.setText(sortedList);
                replyMessage.setJMSCorrelationID(requestMessage.getJMSMessageID());
                // sending reply message.
                if(sortedList!= null){
                replyProducer.send(replyMessage);
                }

                System.out.println("Sent Sorted list to Customer Order System..");
                //System.out.println("\tTime:       " + System.currentTimeMillis() + " ms");
                System.out.println("\tMessage ID: " + replyMessage.getJMSMessageID());
                System.out.println("\tCorrel. ID: " + replyMessage.getJMSCorrelationID());
                System.out.println("\tReply to:   " + replyMessage.getJMSReplyTo());
                //System.out.println("\tContents:   " + replyMessage.getText());
                System.out.println("\tDestination:" + replyMessage.getJMSDestination());
            } else {
                System.out.println("Invalid message detected");
                System.out.println("\tType:       " + message.getClass().getName());
                System.out.println("\tTime:       " + System.currentTimeMillis() + " ms");
                System.out.println("\tMessage ID: " + message.getJMSMessageID());
                System.out.println("\tCorrel. ID: " + message.getJMSCorrelationID());
                System.out.println("\tReply to:   " + message.getJMSReplyTo());

                message.setJMSCorrelationID(message.getJMSMessageID());
            }
            
            
        } catch (JMSException e) {
            e.printStackTrace();
        }
    
    }
    
    
    
    public String sortRestaurants(String list,String cid) {
        StringBuilder unsortedList = new StringBuilder(list);
        
        String dbURL = "jdbc:mysql://localhost:3306/customer_info";
        String userName = "root";
        String password = "";
        java.sql.Connection dbConn = null;
        ResultSet rs = null;
        LinkedHashMap<String, Integer> rankingReference = new LinkedHashMap<String, Integer>();
        
        
        String sql1 = "SELECT restaurant_name, COUNT( restaurant_name ) FROM `order`  WHERE customer_id = '"+cid +"' GROUP BY restaurant_name ORDER BY COUNT( restaurant_name )";
        
        String sql2 = "SELECT * FROM customer where customer_id ='" + cid + "'";
        
        StringBuilder outputXML = new StringBuilder();
        outputXML.append("<?xml version='1.0' encoding='UTF-8'?>");
        outputXML.append("<result>");
         outputXML.append("<customer>");
		 outputXML.append("<id>" +cid +"</id>");
       
        
        try{
            // Connection to database "international_pets_database" with authentication details in "userName"
            // and "password"
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            dbConn = DriverManager.getConnection(dbURL, userName, password);
            
            Statement statement = dbConn.createStatement();
             if(statement.execute(sql2)){
               
                rs = statement.getResultSet();
            }
              while (rs.next()){
               outputXML.append("<phone>" + rs.getString(2) +"</phone>");
                outputXML.append("<email>" +rs.getString(3) +"</email>");
               } 
               
                
            
             
         
           outputXML.append("</customer>");
            if(statement.execute(sql1)){
                rs = statement.getResultSet();
            }
            
            while (rs.next()){
                String restaurant_name = rs.getString(1);
               
                    rankingReference.put(restaurant_name,Integer.parseInt(rs.getString(2)));
               
                
            }
           List<String> rank = new ArrayList<String>(rankingReference.keySet() );
           System.out.println("--------RESTAURANT[Order Times]------");
           for(int i=rank.size()-1; i>=0; i--){
            System.out.println(rank.get(i)+"[" + rankingReference.get(rank.get(i))+"]");
           
           
           }
           System.out.println("--------------------------------------");
           int index = 0;
           int endIndex =0;
           //StringBuilder test = unsortedList;
           String toPop = "";
           for (int j=rank.size()-1;j>=0;j--){
                index = unsortedList.indexOf(rank.get(j));
                if(index != -1){
                    endIndex = unsortedList.indexOf("</restaurant>",index);
                     toPop = toPop.concat(unsortedList.substring(index-18, endIndex+13));
                    unsortedList =unsortedList.delete(index-18, endIndex+13);
                    
                }
                
           }
           unsortedList = unsortedList.insert(0,toPop);
           outputXML.append(unsortedList);
           outputXML.append("</result>");
           
           
            
        } catch(Exception e){
            e.printStackTrace();
        } finally {
            try {
                if (dbConn != null) {
                    dbConn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        

        return (outputXML.toString());  
    }
    
    
    
    
    
    public void insertNew(String cid, String restaurant) {

        
        String dbURL = "jdbc:mysql://localhost:3306/customer_info";
        String userName = "root";
        String password = "";
        java.sql.Connection dbConn = null;
        ResultSet rs = null;
        ArrayList<String> nameList = new ArrayList<String>();
        
        
        String sql = "INSERT INTO  `order`  VALUES ('" + cid +"', CURRENT_TIMESTAMP ,  '"+restaurant+"')";

        try{
            // Connection to database "international_pets_database" with authentication details in "userName"
            // and "password"
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            dbConn = DriverManager.getConnection(dbURL, userName, password);
            
            Statement statement = dbConn.createStatement();
            statement.executeUpdate(sql);
                
                System.out.println("New order record updated!\n------------------------------------------------------------------------\n");
                System.out.println("Customer:" + cid);
                System.out.println("Restaurant:" + restaurant);
                
            
            
        } catch(Exception e){
            e.printStackTrace();
        } finally {
            try {
                if (dbConn != null) {
                    dbConn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }
    
    
}
