
package utility;


import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageConsumer;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
public class EMSMessageSender {


    String serverUrl = null;
    String userName = null;
    String password = null;
    String queueName = "q.request.restaurantlist";


    Connection connection = null;
    Session session = null;
    Session replySession = null;
    MessageConsumer msgConsumer = null;
    Destination destination = null;

    public String sendMessage(String xmlInput){
        
        String msgText = null;
        try{
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
            Destination rplDestination = session.createTemporaryQueue();
            destination = session.createQueue(queueName);

            MessageProducer producer = session.createProducer(destination);
            MessageConsumer rplConsumer = session.createConsumer(rplDestination);

            TextMessage message = replySession.createTextMessage();
            

            message.setText(xmlInput);

            message.setJMSReplyTo(session.createTemporaryQueue());
            producer.send(message);
            
            //-------------receive
            TextMessage replyMsg = (TextMessage)rplConsumer.receive();
            msgText = replyMsg.getText();
        }catch(JMSException exc){
            exc.printStackTrace();
        }
        return msgText;
    }

}
