package com.example.board_v1_0;


import lombok.Getter;
import lombok.Setter;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;

@Getter
public class PostDAO {

    // 싱글톤으로 PostDAO 사용
    private static final PostDAO postDAO = new PostDAO();
    private MyConnection myConnection = MyConnection.getInstance();

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private StringBuffer query;
    private List<PostDTO> posts = new LinkedList<>();
    private PostDAO() {}

    public static PostDAO getInstance() {
        return postDAO;
    }

//    public Long getPostCounts() throws SQLException, ClassNotFoundException {
//        conn = myConnection.getConnection();
//        pstmt = conn.prepareStatement("SELECT COUNT(id) AS Count from posts");
//        rs = pstmt.executeQuery();
//
//        Long Count = 0L;
//        while (rs.next()) {
//            Count = rs.getLong("Count");
//        }
//        return Count;
//    }

    public List<PostDTO> getPostLists() throws SQLException, ClassNotFoundException {
        conn = myConnection.getConnection();
        pstmt = conn.prepareStatement("SELECT id, category, title, author, created_date, modified_date, hits FROM posts");
        rs = pstmt.executeQuery();
        posts.clear();

        while (rs.next()) {
            Long id = rs.getLong("id");
            String category = rs.getString("category");
            String title = rs.getString("title");
            String author = rs.getString("author");
            LocalDateTime createdDate = rs.getTimestamp("created_date").toLocalDateTime();
            LocalDateTime modifiedDate = null;
            if (rs.getTimestamp("modified_date") != null) {
                modifiedDate = rs.getTimestamp("modified_date").toLocalDateTime();
            }
            Long hits = rs.getLong("hits");

            PostDTO postDto = PostDTO.builder()
                    .id(id)
                    .category(category)
                    .title(title)
                    .author(author)
                    .createdDate(createdDate)
                    .modifiedDate(modifiedDate)
                    .hits(hits).build();
            posts.add(postDto);
        }
        rs.close();
        pstmt.close();
        conn.close();

        return posts;
    }

    public List<PostDTO> getCategoryList() throws SQLException, ClassNotFoundException {
        conn = myConnection.getConnection();
        pstmt = conn.prepareStatement("select * from category");
        rs = pstmt.executeQuery();
        posts.clear();

        while (rs.next()) {
            String category = rs.getString("category");

            PostDTO postDto = PostDTO.builder()
                    .category(category).build();

            posts.add(postDto);
        }
        rs.close();
        pstmt.close();
        conn.close();

        return posts;
    }

    String castLocalTimeToTimestmp(LocalDateTime ldt) {
        String timeStamp = ldt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        return timeStamp;
    }
}
