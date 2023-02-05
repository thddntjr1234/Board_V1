package com.example.board_v1_0.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Config {
    public static void main(String[] args) throws SQLException {
        String url = "jdbc:mariadb://localhost:3306/";
        String userName = "root";
        String password = "0927";

        Connection connection = DriverManager.getConnection(url, userName, password);


    }
}
