package com.bank.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.IOException;

public class DBConnection {
	
	private DBConnection() { }

    private static final Properties properties = new Properties();

    // Load database configuration only once
    static {
        try (FileInputStream fis = new FileInputStream("db.properties")) {
            properties.load(fis);
        } 
        catch (IOException e) {
            throw new RuntimeException("Could not load db.properties", e);
        }
    }

    public static Connection getConnection() throws SQLException {

        String url = properties.getProperty("db.url");
        String username = properties.getProperty("db.username");
        String password = properties.getProperty("db.password");

        return DriverManager.getConnection(url, username, password);
    }
}
