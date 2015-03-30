package utility;


import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageConsumer;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
public class EMSMessageSender {


    //String serverUrl = "196.108.137.109";
    String serverUrl = "192.168.137.254";
    //String serverUrl = "localhost";
    String userName = null;
    String password = null;
    String queueName = null;


    Connection connection = null;
    Session session = null;
    MessageConsumer msgConsumer = null;
    Destination destination = null;
    MessageConsumer rplConsumer = null;
    public EMSMessageSender(String queueName){
        this.queueName = queueName;
    }
    public EMSMessageSender(String queueName,String server){
        this.queueName = queueName;
        this.serverUrl =server;
    }
    public String sendMessage(String xmlInput, boolean reply){
        
        String msgText = null;
        try{
            System.out.println("Preparing jms sender");
            //set server URL
            ConnectionFactory factory = new com.tibco.tibjms.TibjmsConnectionFactory(serverUrl);

            connection = factory.createConnection(userName, password);
            session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            destination = session.createQueue(queueName);
            msgConsumer = session.createConsumer(destination);
            connection.start();
            destination = session.createQueue(queueName);
            MessageProducer producer = session.createProducer(destination);
            
            //Destination rplDestination = session.createTemporaryQueue();
            
            TextMessage message = session.createTextMessage();
            message.setText(xmlInput);
            if(reply){
                //message.setJMSReplyTo(session.createTemporaryQueue());
                Destination rplDestination = session.createQueue("q.receiveorder");
                rplConsumer = session.createConsumer(rplDestination);
            }
            producer.send(message);
            System.out.println(message.toString());
            
            //-------------receive message
            if (reply){
                System.out.println("Waiting for reply message");
                TextMessage replyMsg = (TextMessage)rplConsumer.receive(20000);
                if (replyMsg==null){
                    throw new Exception("no return");
                }
                System.out.println(replyMsg.toString());
                msgText = replyMsg.getText();
                //System.out.println("*********"+msgText);
            }
            
            session.close();
            connection.close();
        }catch(JMSException exc){
            exc.printStackTrace();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return msgText;
    }
    

}
