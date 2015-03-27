/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.*;
/**
 *
 * @author Alex
 */


public class RestaurantInfoRequester {


    /*-----------------------------------------------------------------------
     * Parameters
     *----------------------------------------------------------------------*/

    String serverUrl = null;
    String userName = null;
    String password = null;
    String queueName = "q.request.restaurantlist";



    /*-----------------------------------------------------------------------
    * Variables
    *----------------------------------------------------------------------*/
    Connection connection = null;
    Session session = null;
    Session replySession = null;
    MessageConsumer msgConsumer = null;
    Destination destination = null;


    /*-----------------------------------------------------------------------
     * run
     *----------------------------------------------------------------------*/
    void run()
            throws JMSException {
        Message msg = null;

        ConnectionFactory factory = new com.tibco.tibjms.TibjmsConnectionFactory(serverUrl);

        /* create the connection */
        connection = factory.createConnection(userName, password);
        session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);


        /* create the destination */
        destination = session.createQueue(queueName);

        /* create the consumer */
        msgConsumer = session.createConsumer(destination);
        /* start the connection */
        connection.start();

    }




    private void sendMessage(String[] transaction){
        try{

            Destination destination = session.createQueue(replyQueueName);

            MessageProducer producer = session.createProducer(replyDestination);

            TextMessage replyMessage = replySession.createTextMessage();
            //TODO: continue

            replyMessage.setText("\tSubscriber:\t"+ transaction[0]+ "\tPromotionID:\t"
                    +transaction[1]+"\tAmount due:\t"+ transaction[2]);
            replyMessage.setJMSCorrelationID(transaction[3]);
            replyMessage.setJMSReplyTo(session.createTemporaryQueue());
            replyProducer.send(replyMessage);

            replySession.close();
        }catch(JMSException exc){
            exc.printStackTrace();
        }
    }


}
