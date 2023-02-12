package com.example.board_v1_0.File;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter @Builder
public class FileDTO {
    private Long postid;
    private String fileName;
    private String fileRealName;
}
