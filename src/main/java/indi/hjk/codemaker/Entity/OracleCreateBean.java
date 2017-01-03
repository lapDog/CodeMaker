package indi.hjk.codemaker.Entity;

/**
 * 用于生成Oracle数据库实体类
 * Created by HJK on 2016/12/30.
 */
public class OracleCreateBean implements BaseCreateBean {
    public void makeCode() {
        System.out.println("Oracle制造代码开始");
        System.out.println("Oracle制造代码完毕");
    }

    public void getTables() {
        System.out.println("Oracle获取数据库表...");
    }

    public void getColumnDatas(String tableName) {
        System.out.println("Oracle获取 "+tableName+" 表字段结构");
    }
}
