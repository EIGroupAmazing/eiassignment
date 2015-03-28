import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
 
public class TestXMLParser {
 
   public static void main(String argv[]) {
 
    try {
 
	SAXParserFactory factory = SAXParserFactory.newInstance();
	SAXParser saxParser = factory.newSAXParser();
 
	DefaultHandler handler = new DefaultHandler() {
 
	boolean bfname = false;
	boolean blname = false;
	boolean bnname = false;
	boolean bsalary = false;
 
	public void startElement(String uri, String localName,String qName, 
                Attributes attributes) throws SAXException {
 
		System.out.println("Start Element :" + qName);
 
		if (qName.equalsIgnoreCase("customer")) {
			bfname = true;
		}
 
		if (qName.equalsIgnoreCase("result")) {
			blname = true;
		}
 
		if (qName.equalsIgnoreCase("restaurant")) {
			bnname = true;
		}
 
		if (qName.equalsIgnoreCase("SALARY")) {
			bsalary = true;
		}
 
	}
 
	public void endElement(String uri, String localName,
		String qName) throws SAXException {
 
		System.out.println("End Element :" + qName);
 
	}
 
	public void characters(char ch[], int start, int length) throws SAXException {
 
		if (bfname) {
			System.out.println("First Name : " + new String(ch, start, length));
			bfname = false;
		}
 
		if (blname) {
			System.out.println("Last Name : " + new String(ch, start, length));
			blname = false;
		}
 
		if (bnname) {
			System.out.println("Nick Name : " + new String(ch, start, length));
			bnname = false;
		}
 
		if (bsalary) {
			System.out.println("Salary : " + new String(ch, start, length));
			bsalary = false;
		}
 
	}
 
     };
        String xmlStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
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
       saxParser.parse(new ByteArrayInputStream(xmlStr.getBytes(StandardCharsets.UTF_8)), handler);
 
     } catch (Exception e) {
       e.printStackTrace();
     }
 
   }
 
}