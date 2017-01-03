package indi.hjk.codemaker.Utils;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

/**
 * 加载系统整体配置文件
 */
public class SystemConfig {

	private final static Logger logger= LoggerFactory.getLogger(SystemConfig.class);

	private static Properties prop = null;

	//静态load配置文件
	static{
		logger.info("SystemConfigTip->开始加载资源文件.");
		Resource res = new ClassPathResource("/properties/conf.properties");
		prop = new Properties();
		try {
			prop.load(res.getInputStream());
			logger.info("SystemConfigTip->加载配置文件成功.");
		} catch (Exception e) {
			logger.info("SystemConfigTip->加载配置文件失败.");
			e.printStackTrace();
		}
	}

	/**
	 * 重新加载配置文件
	 */
	public static void reLoadProperties(){
		logger.info("SystemConfigTip->开始重新加载配置文件.");
		Resource res = new ClassPathResource("/properties/conf.properties");
		prop = new Properties();
		try {
			prop.load(res.getInputStream());
			logger.info("SystemConfigTip->重新加载配置成功.");
		} catch (Exception e) {
			logger.info("SystemConfigTip->重新加载配置失败.");
			e.printStackTrace();
		}
	}

	/**
	 * 新增属性
	 * @param key
	 * @param value
	 */
	public static void putProperty(String key, String value) {
		prop.put(key, value);
	}

	/**
	 * 获取属性
	 * @param key
	 * @return
	 */
	public static String getProperty(String key) {
		return prop.getProperty(key);
	}

	/**
	 * 根据配置文件路径加载配置文件
	 * @param path
	 * @return
	 */
	public static Properties loadPropertiesByPath(String path){
		try{
			Properties ps=new Properties();
			Resource resource = new ClassPathResource(path);
			ps.load(resource.getInputStream());
			logger.info("SystemConfigTip->加载指定配置文件成功.");
			return ps;
		}catch (Exception e){
			logger.info("SystemConfigTip->加载指定配置文件失败.");
			e.printStackTrace();
		}
		return prop;//若失败返回conf
	}

}
