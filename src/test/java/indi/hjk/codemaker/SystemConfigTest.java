package indi.hjk.codemaker;

import indi.hjk.codemaker.Utils.SystemConfig;

/**
 * 配置文件加载工具类测试
 * Created by HJK on 2017/1/3.
 */
public class SystemConfigTest {
    public static void main(String[] arg){
        System.out.println(SystemConfig.getProperty("test"));
        System.out.println(SystemConfig.loadPropertiesByPath("/properties/jdbc.properties").getProperty("url"));
    }
}
