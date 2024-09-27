package shopping;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

@WebListener
public class AppContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialization code if needed
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Unregister JDBC drivers
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("Deregistering JDBC driver: " + driver);
            } catch (SQLException e) {
                System.err.println("Error deregistering driver: " + e);
            }
        }

        // Stop the Abandoned Connection Cleanup Thread
        com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown(); // Restore the interrupted status
        System.out.println("Stopped Abandoned Connection Cleanup Thread.");
    }
}
