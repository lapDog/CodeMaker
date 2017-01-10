package indi.hjk.codemaker.Utils;

import org.apache.commons.lang3.StringUtils;

/**
 * 封装了一些常用处理方法
 * Created by HJK on 2017/1/3.
 */
public class StringStuffUtil {

    /**
     * 将数据库类型转为java类型
     * @param dataType 数据库中数据类型
     * @param precision 精度
     * @param scale 比例
     * @return
     */
    public static String transDbtypeToJavatype(String dataType, String precision, String scale) {
        dataType = dataType.toLowerCase();
        if (dataType.contains("char"))
            dataType = "java.lang.String";
        else if (dataType.contains("int"))
            dataType = "java.lang.Integer";
        else if (dataType.contains("float"))
            dataType = "java.lang.Float";
        else if (dataType.contains("double"))
            dataType = "java.lang.Double";
        else if (dataType.contains("number")) {
            if ((StringUtils.isNotBlank(scale))
                    && (Integer.parseInt(scale) > 0))
                dataType = "java.math.BigDecimal";
            else if ((StringUtils.isNotBlank(precision))
                    && (Integer.parseInt(precision) > 6))
                dataType = "java.lang.Long";
            else
                dataType = "java.lang.Double";
        } else if (dataType.contains("decimal"))
            dataType = "BigDecimal";
        else if (dataType.contains("date"))
            dataType = "java.util.Date";
        else if (dataType.contains("time"))
            dataType = "java.sql.Timestamp";
        else if (dataType.contains("clob"))
            dataType = "java.sql.Clob";
        else if (dataType.contains("blob"))
            dataType = "java.sql.Blob";
        else if (dataType.contains("varchar"))
            dataType = "java.lang.String";
        else if (dataType.contains("integer"))
            dataType = "java.lang.Integer";
        else {
            dataType = "java.lang.Object";
        }
        return dataType;
    }

    /**
     * 判断字段是否可为空
     * @param nullable
     * @return
     */
    public static String getNullAble(String nullable)
    {
        if (("YES".equals(nullable)) || ("yes".equals(nullable)) || ("y".equals(nullable)) || ("Y".equals(nullable))) {
            return "Y";
        }
        if (("NO".equals(nullable)) || ("N".equals(nullable)) || ("no".equals(nullable)) || ("n".equals(nullable))) {
            return "N";
        }
        return null;
    }



}
