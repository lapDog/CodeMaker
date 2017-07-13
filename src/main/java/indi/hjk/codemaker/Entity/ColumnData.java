package indi.hjk.codemaker.Entity;



/**
 * 表结构
 * Created by HJK on 2017/1/3.
 */
public class ColumnData {
    private String colname; //列名
    private String jdbctype; //数据库字段类型
    private String javatype; //对应java类型
    private String mappertype; //mapper文件字段对应类型
    private String colcomment; //列名注释
    private String maxLength; //最大长度
    private String nullable;  //是否为空

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

    public String getMappertype() {
        return mappertype;
    }

    public void setMappertype(String mappertype) {
        this.mappertype = mappertype;
    }
}
