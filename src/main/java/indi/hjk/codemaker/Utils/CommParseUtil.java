package indi.hjk.codemaker.Utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 通用FreeMarker替换模板方法
 * @author HJK
 *
 */
public class CommParseUtil {
	
	/**
	 * 替换并创建文档
	 * @param data 填充数据集合
	 * @param templateName 模板名称
	 * @param destFilePath 文件生成路径
	 */
	public static void ParseContent(Map data,String templateName,String destFilePath){
        try {
	        //创建配置实例 
	        Configuration configuration = new Configuration();
	        //设置编码
            configuration.setDefaultEncoding("UTF-8");
            //加载模板
            configuration.setClassForTemplateLoading(CommParseUtil.class,SystemConfig.getProperty("BasePath_TemplatePath"));
            //获取模板 
            Template template = configuration.getTemplate(templateName);
            //输出文件
            File outFile = new File(destFilePath);
            //如果输出目标文件夹不存在，则创建
            if (!outFile.getParentFile().exists()){
                outFile.getParentFile().mkdirs();
            }
            //将模板和数据模型合并生成文件 
            Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile),"UTF-8"));
            //生成文件
            template.process(data, out);	
            //关闭流
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
}
