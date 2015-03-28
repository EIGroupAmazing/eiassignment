import model.Customer;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
public class TestXMLParser extends DefaultHandler {
    String tmpValue;
    String xmlStr;
    String ns = "ns:";
    Customer cust;
    ArrayList<Customer> custList;
    public TestXMLParser(String xmlStr) {
        this.xmlStr = xmlStr;
        custList = new ArrayList<Customer>();
        parseDocument();
        printDatas();
        
    }
    private void parseDocument() {
        // parse
        SAXParserFactory factory = SAXParserFactory.newInstance();
        try {
            SAXParser parser = factory.newSAXParser();
            parser.parse(new ByteArrayInputStream(xmlStr.getBytes(StandardCharsets.UTF_8)), this);
        } catch (ParserConfigurationException e) {
            System.out.println("ParserConfig error");
        } catch (SAXException e) {
            System.out.println("SAXException : xml not well formed");
        } catch (IOException e) {
            System.out.println("IO error");
        }
    }

    @Override
    public void startElement(String s, String s1, String elementName, Attributes attributes) throws SAXException {
        // if current element is book , create new book
        // clear tmpValue on start of element
 
        if (elementName.equalsIgnoreCase(ns+"customer")) {
            cust = new Customer();
        }

    }
    @Override
    public void endElement(String s, String s1, String element) throws SAXException {
        // if end of book element add to list
        if (element.equals(ns+"customer")) {
            custList.add(cust);
        }
        // if current element is publisher
        if (element.equalsIgnoreCase(ns+"email")) {
            cust.setEmail(tmpValue);
        }
        if (element.equalsIgnoreCase(ns+"phone")) {
            cust.setPhone(tmpValue);
        }
        if (element.equalsIgnoreCase(ns+"id")) {
            cust.setId(tmpValue);
        }
    }
    @Override
    public void characters(char[] ac, int i, int j) throws SAXException {
        tmpValue = new String(ac, i, j);
    }

}
