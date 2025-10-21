package com;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConnection {

    private static HikariDataSource dataSource;

    static {
        try {
            String dbType = System.getenv("DB_TYPE");
            if (dbType == null) dbType = "sqlite"; // default to SQLite

            HikariConfig config = new HikariConfig();

            if ("mysql".equalsIgnoreCase(dbType)) {
                // MySQL config
                String dbUrl = System.getenv("DB_URL"); // e.g., jdbc:mysql://host:3306/userapp
                String dbUser = System.getenv("DB_USER"); 
                String dbPassword = System.getenv("DB_PASSWORD");

                config.setJdbcUrl(dbUrl);
                config.setUsername(dbUser);
                config.setPassword(dbPassword);
                config.setDriverClassName("com.mysql.cj.jdbc.Driver");

                config.setMaximumPoolSize(10);
                config.setMinimumIdle(2);
                config.setIdleTimeout(60000);     // 1 min
                config.setMaxLifetime(1800000);   // 30 min
                config.setConnectionTimeout(30000);

            } else {
                // Default: SQLite
                String dbUrl = "jdbc:sqlite:C:/Users/CP060833/OneDrive - Capitec Bank Ltd/Desktop/WebApp/users.db";
                config.setJdbcUrl(dbUrl);
                config.setDriverClassName("org.sqlite.JDBC");

                config.setMaximumPoolSize(5);
                config.setMinimumIdle(1);
                config.setIdleTimeout(30000);    // 30 sec
                config.setMaxLifetime(600000);   // 10 min
                config.setConnectionTimeout(30000);
            }

            dataSource = new HikariDataSource(config);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Failed to initialize HikariCP: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void closePool() {
        if (dataSource != null) {
            dataSource.close();
        }
    }
}
