package com.example.board_v1_0.Comment;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@ToString
public class CommentDTO {
    private Long postId;
    private LocalDateTime createdDate;
    private String comment;
}
