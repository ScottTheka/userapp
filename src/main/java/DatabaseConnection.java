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

            if ("postgresql".equalsIgnoreCase(dbType)) {
                // PostgreSQL (not used here)
                String dbUrl = System.getenv("DB_URL");
                String dbUser = System.getenv("DB_USER");
                String dbPassword = System.getenv("DB_PASSWORD");

                config.setJdbcUrl(dbUrl);
                config.setUsername(dbUser);
                config.setPassword(dbPassword);
                config.setDriverClassName("org.postgresql.Driver");

                config.setMaximumPoolSize(10);
                config.setMinimumIdle(2);
                config.setIdleTimeout(60000);
                config.setMaxLifetime(1800000);
                config.setConnectionTimeout(30000);

            } else {
                // SQLite for Render
                // We'll store the DB in a folder mounted for persistence
                String dbUrl = "jdbc:sqlite:/data/users.db"; 
                config.setJdbcUrl(dbUrl);
                config.setDriverClassName("org.sqlite.JDBC");

                config.setMaximumPoolSize(5);
                config.setMinimumIdle(1);
                config.setIdleTimeout(30000);
                config.setMaxLifetime(600000);
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
