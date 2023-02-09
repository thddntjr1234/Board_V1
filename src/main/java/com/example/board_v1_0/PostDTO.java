package com.example.board_v1_0;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Getter @Setter @Builder @ToString
public class PostDTO {
    private Long id;
    private Long hits;
    private LocalDateTime createdDate;
    private LocalDateTime modifiedDate;
    private String title;
    private String content;
    private String author;
    private String category;
    private String passwd;
}
