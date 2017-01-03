package indi.hjk.codemaker;

import freemarker.template.Configuration;
import freemarker.template.Template;
import indi.hjk.codemaker.Utils.CommParseUtil;
import indi.hjk.codemaker.Utils.SystemConfig;

import java.io.IOException;

/**
 * Created by HJK on 2017/1/3.
 */
public class FreeMarkerTest {

    public static void main(String [] arg){
        //创建配置实例
        Configuration configuration = new Configuration();
        //设置编码
        configuration.setDefaultEncoding("UTF-8");
        //加载模板
        configuration.setClassForTemplateLoading(CommParseUtil.class,SystemConfig.getProperty("BasePath_TemplatePath"));
        //获取模板
        try {
            Template template = configuration.getTemplate("EntityTemplate.ftl");
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}
