package com.example.board_v1_0;


import lombok.Getter;
import lombok.Setter;

import java.sql.*;
import java.time.Instant;
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

    private PostDAO() {}

    public static PostDAO getInstance() {
        return postDAO;
    }

    public List<PostDTO> getPostLists() throws SQLException, ClassNotFoundException {
        conn = myConnection.getConnection();
        pstmt = conn.prepareStatement("SELECT id, category, title, author, created_date, modified_date, hits FROM posts ORDER BY id DESC");
        rs = pstmt.executeQuery();
        List<PostDTO> posts = new LinkedList<>();

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

    public void getPost(Long posId) throws SQLException, ClassNotFoundException {
    }

    public Long savePost(PostDTO postDTO) throws SQLException, ClassNotFoundException {
        Long id = 0L;
        conn = myConnection.getConnection();

        pstmt = conn.prepareStatement("INSERT INTO posts(category, author, passwd, title, content, created_date) VALUES (?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, postDTO.getCategory());
        pstmt.setString(2, postDTO.getAuthor());
        pstmt.setString(3, postDTO.getPasswd());
        pstmt.setString(4, postDTO.getTitle());
        pstmt.setString(5, postDTO.getContent());
        pstmt.setTimestamp(6, Timestamp.from(Instant.now()));

        // 반영된 레코드 건수를 반환
        int result = pstmt.executeUpdate();
        System.out.println("result: " + result);

        rs = pstmt.getGeneratedKeys();
        if (rs.next()) {
            id = rs.getLong(1);
        }
        return id;
    }

    public void updatePost(PostDTO postDTO) {

    }

    public void deletePost(PostDTO postDTO) {

    }
    public List<PostDTO> getCategoryList() throws SQLException, ClassNotFoundException {
        conn = myConnection.getConnection();
        pstmt = conn.prepareStatement("select * from category");
        rs = pstmt.executeQuery();
        List<PostDTO> posts = new LinkedList<>();

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
        String timeStamp = ldt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

        return timeStamp;
    }
}
