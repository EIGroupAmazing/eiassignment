package dao;

import java.util.Properties;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * A class that manages connections to the database. It also has a utility
 * method that close connections, statements and resultsets
 */
public class ConnectionManager {

    private static final String PROPS_FILENAME = "/connection.properties";
    private static String dbUser;
    private static String dbPassword;
    private static String dbURL;

    static {
        if (!readOpenshiftDatabaseProperties()) {
            readLocalDatabaseProperties();
        }
        initDBDriver();
    }

    /**
     * Method call will retrieve database connection properties from 
     * environment variables
     *
     * @return true if the connection is not from local host
     */
    private static boolean readOpenshiftDatabaseProperties() {
        // grab environment variable
        String host = System.getenv("OPENSHIFT_MYSQL_DB_HOST");

        if (host == null) {
            return false;
        }
    // this is production environment
        // obtain database connection properties from environment variables
        String port = System.getenv("OPENSHIFT_MYSQL_DB_PORT");
        String dbName = System.getenv("OPENSHIFT_APP_NAME");
        dbUser = System.getenv("OPENSHIFT_MYSQL_DB_USERNAME");
        dbPassword = System.getenv("OPENSHIFT_MYSQL_DB_PASSWORD");

        dbURL = "jdbc:mysql://" + host + ":" + port + "/" + dbName;
        return true;
    }

    /**
     * Method call will retrieve properties from connection.properties via the CLASSPATH
     */
    private static void readLocalDatabaseProperties() {
        try {
      // Retrieve properties from connection.properties via the CLASSPATH
            // WEB-INF/classes is on the CLASSPATH
            InputStream is = ConnectionManager.class.getResourceAsStream(PROPS_FILENAME);
            Properties props = new Properties();
            props.load(is);

            // load database connection details
            String host = props.getProperty("db.host");
            String port = props.getProperty("db.port");
            String dbName = props.getProperty("db.name");
            dbUser = props.getProperty("db.user");
            dbPassword = props.getProperty("db.password");

            dbURL = "jdbc:mysql://" + host + ":" + port + "/" + dbName;
        } catch (Exception ex) {
            // unable to load properties file
            String message = "Unable to load '" + PROPS_FILENAME + "'.";

            System.out.println(message);
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
            throw new RuntimeException(message, ex);
        }
    }

    /**
     * Method call will initialize database driver
     */
    private static void initDBDriver() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (Exception ex) {
            // unable to load properties file
            String message = "Unable to find JDBC driver for MySQL.";

            System.out.println(message);
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, message, ex);
            throw new RuntimeException(message, ex);
        }
    }

    /**
     * Method call gets a connection to the database
     *
     * @return the connection
     * @throws SQLException if an error occurs when connecting
     */
    public static Connection getConnection() throws SQLException {
        String message = "dbURL: " + dbURL
                + "  , dbUser: " + dbUser
                + "  , dbPassword: " + dbPassword;
        Logger.getLogger(ConnectionManager.class.getName()).log(Level.INFO, message);

        return DriverManager.getConnection(dbURL, dbUser, dbPassword);

    }

    /**
     * close the given connection, statement and resultset
     *
     * @param conn the connection object to be closed
     * @param stmt the statement object to be closed
     * @param rs the resultset object to be closed
     */
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
                    "Unable to close ResultSet", ex);
        }
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
                    "Unable to close Statement", ex);
        }
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.WARNING,
                    "Unable to close Connection", ex);
        }
    }

    /**
     * Method call will close the connection to the database and statement object
     *
     * @param conn the connection object to be closed
     * @param stmt the statement object to be closed
     */
    public static void close(Connection conn, Statement stmt) {
        close(conn, stmt, null);
    }

    /**
     * Method call will close the connection to the database and the resultset
     * object
     *
     * @param conn the connection object to be closed
     * @param rs the resultset object to be closed
     */
    public static void close(Connection conn, ResultSet rs) {
        close(conn, null, rs);
    }

    /**
     * Method call will close the connection to the database
     *
     * @param conn the connection object to be closed
     */
    public static void close(Connection conn) {
        close(conn, null, null);
    }
}
