# Use the official Tomcat image
FROM tomcat:9.0

# Copy your WAR file to Tomcat's webapps directory
COPY target/shopping-website-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/

# Expose the port that Tomcat listens on
EXPOSE 8080
