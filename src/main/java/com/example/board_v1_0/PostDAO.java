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

    private static final PostDAO postDAO = new PostDAO();
    private MyConnection myConnection = MyConnection.getInstance();

    private Connection conn;
    private ResultSet rs;

    private PostDAO() {
    }

    public static PostDAO getInstance() {
        return postDAO;
    }

    public List<PostDTO> getPostList(int pageNumber) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt;

        List<PostDTO> posts = new LinkedList<>();
        conn = myConnection.getConnection();
        pstmt = conn.prepareStatement("SELECT * FROM posts ORDER BY id DESC LIMIT ?, 10");
        pstmt.setInt(1, (pageNumber - 1) * 10);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            System.out.println("쿼리 실행후 값 가져오기");
            Long id = rs.getLong("id");
            String category = rs.getString("category");
            String title = rs.getString("title");
            String author = rs.getString("author");
            LocalDateTime createdDate = rs.getTimestamp("created_date").toLocalDateTime();
            Boolean isHaveFile = rs.getBoolean("file_flag");
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
                    .isHaveFile(isHaveFile)
                    .hits(hits).build();
            posts.add(postDto);
        }


        return posts;
    }

    public int getPostCount() throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt;
        conn = myConnection.getConnection();
        pstmt = conn.prepareStatement("SELECT COUNT(id) AS Count FROM posts");
        rs = pstmt.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt("Count");
        }
        return count;
    }

    // view.jsp
    public PostDTO getPost(Long postId) throws SQLException, ClassNotFoundException {
        conn = myConnection.getConnection();
        PreparedStatement pstmt;
        pstmt = conn.prepareStatement("SELECT * FROM posts WHERE id = ?");
        pstmt.setLong(1, postId);
        rs = pstmt.executeQuery();

        PostDTO postDTO = PostDTO.builder().build();
        if (rs.next()) {
            LocalDateTime modifiedDate = null;
            if (rs.getTimestamp("modified_date") != null) {
                modifiedDate = rs.getTimestamp("modified_date").toLocalDateTime();
            }
            postDTO = PostDTO.builder()
                    .id(rs.getLong("id"))
                    .category(rs.getString("category"))
                    .author(rs.getString("author"))
                    .title(rs.getString("title"))
                    .content(rs.getString("content"))
                    .passwd(rs.getString("passwd"))
                    .hits(rs.getLong("hits"))
                    .isHaveFile(rs.getBoolean("file_flag"))
                    .createdDate(rs.getTimestamp("created_date").toLocalDateTime())
                    .modifiedDate(modifiedDate)
                    .build();
        }

        return postDTO;
    }

    // write.jsp, writeAction.jsp
    public Long savePost(PostDTO postDTO) throws SQLException, ClassNotFoundException {
        Long id = 0L;
        conn = myConnection.getConnection();
        PreparedStatement pstmt;

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

    // list.jsp
    public List<PostDTO> getCategoryList() throws SQLException, ClassNotFoundException {
        conn = myConnection.getConnection();
        PreparedStatement pstmt;

        pstmt = conn.prepareStatement("select * from category");
        rs = pstmt.executeQuery();
        List<PostDTO> posts = new LinkedList<>();

        while (rs.next()) {
            String category = rs.getString("category");

            PostDTO postDto = PostDTO.builder()
                    .category(category).build();

            posts.add(postDto);
        }
        return posts;
    }
}
