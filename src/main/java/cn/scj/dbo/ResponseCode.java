package cn.scj.dbo;

import lombok.Data;

@Data
public class ResponseCode {

    //运行成功
    public static final int SUCCESS =2000;

    //运行失败
    public static final int FAIL =4000;

    private Integer code;

    private String msg;

    private String detail;
}
