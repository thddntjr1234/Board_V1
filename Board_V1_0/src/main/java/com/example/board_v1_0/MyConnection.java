package com.example.board_v1_0;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnection {

    // 싱글턴 방식, 이렇게 미리 인스턴스를 만들어야 경합 과정에서 인스턴스가 두개 이상 생기는 것을 방지할 수 있음
    private static MyConnection myConnection = new MyConnection();

    private MyConnection() {}

    public static MyConnection getInstance() {
        return myConnection;
    }

    public Connection getConnection() throws SQLException, ClassNotFoundException {
        String url = "jdbc:mariadb://localhost:3306/board_v1";
        String userName = "root";
        String password = "0927";
        Connection conn = null;

        Class.forName("org.mariadb.jdbc.Driver");
        System.out.println("mariadb 드라이버 로딩 성공");
        conn = DriverManager.getConnection(url, userName, password);
        System.out.println("mariadb 연결 설공, connection 반환");
        return conn;
    }
}
