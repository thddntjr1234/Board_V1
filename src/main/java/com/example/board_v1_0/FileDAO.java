package com.example.board_v1_0;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class FileDAO {
    private static FileDAO fileDAO = new FileDAO();

    MyConnection myConnection = MyConnection.getInstance();

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private FileDAO() {}

    public static FileDAO getInstance() { return fileDAO; }

    public void saveFiles(Long postId, List<FileDTO> fileLists) throws SQLException, ClassNotFoundException {
        conn = myConnection.getConnection();
        for (FileDTO fileDTO : fileLists) {
            pstmt = conn.prepareStatement("INSERT INTO files VALUES (?, ?, ?)");
            pstmt.setLong(1, postId);
            pstmt.setString(2, fileDTO.getFileName());
            pstmt.setString(3, fileDTO.getFileRealName());
            pstmt.executeUpdate();
        }
    }
}
