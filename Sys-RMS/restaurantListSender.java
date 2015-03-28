/*
 * =================================================================
 * Copyright (c) 2001-2003 TIBCO Software Inc.
 * All rights reserved.
 * For more information, please contact:
 * TIBCO Software Inc., Palo Alto, California, USA
 *
 * $RCSfile: tibjmsMsgProducer.java,v $
 * $Revision: 1.9 $
 * $Date: 2004/02/06 00:05:02 $
 * =================================================================
 */

/*
 * This is a simple sample of a basic tibjmsMsgProducer.
 *
 * This sample publishes specified message(s) on a specified
 * destination and quits.
 *
 * Notice that the specified destination should exist in your configuration
 * or your topics/queues configuration file should allow
 * creation of the specified topic or queue. Sample configuration supplied with
 * the TIBCO Enterprise Message Service distribution allows creation of any
 * destination.
 *
 * If this sample is used to publish messages into
 * tibjmsMsgConsumer sample, the tibjmsMsgConsumer
 * sample must be started first.
 *
 * If -topic is not specified this sample will use a topic named
 * "topic.sample".
 *
 * Usage:  java tibjmsMsgProducer  [options]
 *                               <message-text1>
 *                               ...
 *                               <message-textN>
 *
 *  where options are:
 *
 *   -server    <server-url>  Server URL.
 *                            If not specified this sample assumes a
 *                            serverUrl of "tcp://localhost:7222"
 *   -user      <user-name>   User name. Default is null.
 *   -password  <password>    User password. Default is null.
 *   -topic     <topic-name>  Topic name. Default value is "topic.sample"
 *   -queue     <queue-name>  Queue name. No default
 *
 */

import java.util.*;
import javax.jms.*;

public class restaurantListSender {
    /*-----------------------------------------------------------------------
     * Parameters
     *----------------------------------------------------------------------*/

    String serverUrl = null;
    String userName = null;
    String password = null;
    String name = "topic.sample";
    Vector data = new Vector();
    boolean useTopic = true;

    /*-----------------------------------------------------------------------
     * Variables
     *----------------------------------------------------------------------*/
    Connection connection = null;
    Session session = null;
    MessageProducer msgProducer = null;
    Destination destination = null;

    Destination replyDestination = null; //for request-reply
    MessageConsumer replyConsumer; //for request-reply

    public restaurantListSender(String[] args) {
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
        System.err.println("tibjmsMsgProducer SAMPLE");
        System.err.println("------------------------------------------------------------------------");
        System.err.println("Server....................... " + ((serverUrl != null) ? serverUrl : "localhost"));
        System.err.println("User......................... " + ((userName != null) ? userName : "(null)"));
        System.err.println("Destination.................. " + name);
        System.err.println("Message Text................. ");
        for (int i = 0; i < data.size(); i++) {
            System.err.println(data.elementAt(i));
        }
        System.err.println("------------------------------------------------------------------------\n");

        try {
            TextMessage msg;
            int i;

            if (data.size() == 0) {
                System.err.println("***Error: must specify at least one message text\n");
                usage();
            }

            System.err.println("Publishing to destination '" + name + "'\n");

            ConnectionFactory factory = new com.tibco.tibjms.TibjmsConnectionFactory(serverUrl);

            connection = factory.createConnection(userName, password);

            /* create the session */
            session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            /* create the destination */
           if (useTopic) {
                destination = session.createTopic(name);
                replyDestination = session.createTopic("new.replyTopic"); //for request-reply
           } else {
                destination = session.createQueue(name);
                replyDestination = session.createQueue("new.replyQueue"); //for request-reply
           }

            /* create the producer */
            msgProducer = session.createProducer(destination); //changed for request-reply
            replyConsumer = session.createConsumer(replyDestination); //for request-reply

            /* start the connection */
            connection.start();

            /* publish messages */
            for (i = 0; i < data.size(); i++) {
                /* create text message */
                msg = session.createTextMessage();

                /* set message text */
                msg.setText((String) data.elementAt(i));
                msg.setJMSReplyTo(replyDestination); //for request-reply

                /* publish message */
                msgProducer.send(msg);   //changed for request-reply

                System.err.println("Published message: " + data.elementAt(i));
                System.out.println("Sent request");
                System.out.println("\tTime:       " + System.currentTimeMillis() + " ms");
                System.out.println("\tMessage ID: " + msg.getJMSMessageID());
                System.out.println("\tCorrel. ID: " + msg.getJMSCorrelationID());
                System.out.println("\tReply to:   " + msg.getJMSReplyTo());
                System.out.println("\tContents:   " + msg.getText());
            }

            // Send a request and wait for a reply. Code also can be added to time-out the wait
            Message reply = replyConsumer.receive();

            // Process the reply.
            printMsg(reply);

            connection.close();

        }
        catch (JMSException e) {
            e.printStackTrace();
            System.exit(-1);
        }
    }

    /*-----------------------------------------------------------------------
    * usage
    *----------------------------------------------------------------------*/
    private void usage() {
        System.err.println("\nUsage: java tibjmsMsgProducer [options] [ssl options]");
        System.err.println("                                <message-text-1>");
        System.err.println("                                [<message-text-2>] ...");
        System.err.println("\n");
        System.err.println("   where options are:");
        System.err.println("");
        System.err.println("   -server   <server URL>  - EMS server URL, default is local server");
        System.err.println("   -user     <user name>   - user name, default is null");
        System.err.println("   -password <password>    - password, default is null");
        System.err.println("   -topic    <topic-name>  - topic name, default is \"topic.sample\"");
        System.err.println("   -queue    <queue-name>  - queue name, no default");
        System.err.println("   -help-ssl                 - help on ssl parameters");
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
                data.addElement(args[i]);
                i++;
            }
        }
    }

    /*-----------------------------------------------------------------------
     * main
     *----------------------------------------------------------------------*/
    public static void main(String[] args) {
        restaurantListSender t = new restaurantListSender(args);
    }

    public void printMsg(Message msg) throws JMSException {
                if (msg instanceof TextMessage) {
            TextMessage replyMessage = (TextMessage) msg;
            System.out.println("Received reply ");
            System.out.println("\tTime:       " + System.currentTimeMillis() + " ms");
            System.out.println("\tMessage ID: " + replyMessage.getJMSMessageID());
            System.out.println("\tCorrel. ID: " + replyMessage.getJMSCorrelationID());
            System.out.println("\tReply to:   " + replyMessage.getJMSReplyTo());
            System.out.println("\tContents:   " + replyMessage.getText());
        } else {
            System.out.println("Invalid message detected");
            System.out.println("\tType:       " + msg.getClass().getName());
            System.out.println("\tTime:       " + System.currentTimeMillis() + " ms");
            System.out.println("\tMessage ID: " + msg.getJMSMessageID());
            System.out.println("\tCorrel. ID: " + msg.getJMSCorrelationID());
            System.out.println("\tReply to:   " + msg.getJMSReplyTo());

            msg.setJMSCorrelationID(msg.getJMSMessageID());

        }
    }
}

