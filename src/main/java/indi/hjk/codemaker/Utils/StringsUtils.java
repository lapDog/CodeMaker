package indi.hjk.codemaker.Utils;

/**
 * 字符串处理
 * Created by HJK on 2017/1/3.
 */
public class StringsUtils {

    /**
     * 处理表名
     * @param tableName
     * @return
     */
    public static String getTablesNameToClassName(String tableName) {
        String[] split = tableName.split("_");
        if (split.length > 1) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < split.length; i++) {
                String tempTableName = split[i].substring(0, 1).toUpperCase()
                        + split[i].substring(1, split[i].length());
                sb.append(tempTableName);
            }

            return sb.toString();
        }
        String tempTables = split[0].substring(0, 1).toUpperCase()
                + split[0].substring(1, split[0].length());
        return tempTables;
    }
}
