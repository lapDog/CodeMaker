package indi.hjk.codemaker.Entity;

/**
 * 表结构
 * Created by HJK on 2017/1/3.
 */
public class ColumnData {
    private String colname;
    private String jdbctype;
    private String javatype;
    private String colcomment;
    private String maxLength;
    private String nullable;

    public String getJavatype() {
        return javatype;
    }

    public void setJavatype(String javatype) {
        this.javatype = javatype;
    }

    public String getColname() {
        return colname;
    }

    public void setColname(String colname) {
        this.colname = colname;
    }

    public String getJdbctype() {
        return jdbctype;
    }

    public void setJdbctype(String jdbctype) {
        this.jdbctype = jdbctype;
    }

    public String getColcomment() {
        return colcomment;
    }

    public void setColcomment(String colcomment) {
        this.colcomment = colcomment;
    }

    public String getMaxLength() {
        return maxLength;
    }

    public void setMaxLength(String maxLength) {
        this.maxLength = maxLength;
    }

    public String getNullable() {
        return nullable;
    }

    public void setNullable(String nullable) {
        this.nullable = nullable;
    }
}
