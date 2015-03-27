import java.util.*;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class RetrieveRestaurants{

    public String retrievePetDetails (String region) {

        
        String dbURL = "jdbc:mysql://localhost:3306/restaurant_info";
        String userName = "root";
        String password = "";
        java.sql.Connection dbConn = null;
        ResultSet rs = null;
        ArrayList<String> nameList = new ArrayList<String>();
        
        Calendar cal = Calendar.getInstance();
        cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        String time = sdf.format(cal.getTime()) ;
        
        String sql1 = "SELECT * FROM deliveryscope d, restaurant r WHERE d.restaurantName = r.restaurantName AND openTime <=  '"+time+"' AND closeTime >=  '"+time+"' AND d.region =  '"+region+"'";
        StringBuffer outputXML = new StringBuffer();
        //outputXML.append("<?xml version='1.0' encoding='UTF-8'?>");
		outputXML.append("<restaurant_list>");
        try{
            // Connection to database "international_pets_database" with authentication details in "userName"
            // and "password"
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            dbConn = DriverManager.getConnection(dbURL, userName, password);
            
            Statement statement = dbConn.createStatement();
            if(statement.execute(sql1)){
                rs = statement.getResultSet();
            }
            
            while (rs.next()){
                String restaurant_name = rs.getString(1);
                nameList.add(restaurant_name);
                
            }
            
            for(String rName: nameList){
                String sql2 = "select * from package where restaurantName = ";
                sql2 += rName;
                outputXML.append("<restaurant>");
                outputXML.append("<restaurantName>" + rName + "</restaurantName>");
                if(statement.execute(sql2)){
                    rs = statement.getResultSet();
                }
                while(rs.next()){
                    outputXML.append("<package_name>" + rs.getString(0) + "</package_name>");
                    outputXML.append("<package_detail>" + rs.getString(3) + "</package_detail>");
                    outputXML.append("<package_price>" + rs.getString(1) + "</package_price>");
                }
                outputXML.append("</restaurant>");
            }
            outputXML.append("</restaurant_list>");
            
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
}
