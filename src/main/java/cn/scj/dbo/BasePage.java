package cn.scj.dbo;

import lombok.Data;

@Data
public class BasePage {

    private Integer pageNum = 1;

    private Integer pageSize = 5;
}
