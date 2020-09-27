package com.imcode.common.exception;

/**
 * 自定义业务异常
 */
public class BizException extends RuntimeException {

    public BizException(String message) {
        super(message);
    }
}
