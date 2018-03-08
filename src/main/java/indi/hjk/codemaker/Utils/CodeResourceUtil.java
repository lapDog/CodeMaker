package indi.hjk.codemaker.Utils;


import java.io.UnsupportedEncodingException;
import java.util.ResourceBundle;

/**
 * 用于读取配置
 * Created by HJK on 2017/1/9.
 */
public class CodeResourceUtil {

    private CodeResourceUtil() {
    }

    /**
     * 整体配置
     */
    private static final ResourceBundle confbundle = ResourceBundle.getBundle("properties/conf");
    /**
     * 数据库连接配置
     */
    private static final ResourceBundle dbbundle = ResourceBundle.getBundle("properties/jdbc");

    /*统一配置变量*/
    //项目名
    public static String PROJECT_NAME;
    //项目组包路径
    public static String TEAM_PACKAGE_PATH="indi.hjk";
    //项目组包路径(替换.)
    public static String TEAM_PACKAGE_REPATH="indi/hjk";
    //代码包路径
    public static String CODE_PACKAGE_PATH="src.main.java";
    //代码包路径(替换.)
    public static String CODE_PACKAGE_REPATH="src/main/java";
    //实体类包路径
    public static String ENTITY_PACKAGE_PATH="entity";
    //模板路径
    public static String TEMPLATES_PATH="templates/default/";
    //页面模板路径
    public static String VIEWTEMPLATES_PATH="viewtemplates/hplus/";
    //统一编码格式
    public static String SYSTEM_ENCODING="utf-8";
    //web根路径名
    public static String WEBROOT_PATH="WebRoot";

    /*生成路径配置变量*/
    //项目生成路径
    public static String CODE_OUTPUT_PATH="d:\\CodeMakerResult\\";
    //jsp生成路径
    public static String JSP_PATH="pages";

    /*数据库配置变量*/
    //驱动类
    public static String DRIVER_NAME="com.mysql.jdbc.Driver";
    //连接地址
    public static String DBURL="jdbc:mysql://localhost:3306/eag?useUnicode=true&characterEncoding=UTF-8";
    //数据库用户名
    public static String USERNAME="mysql";
    //数据库密码
    public static String PASSWORD="password";
    //数据库名
    public static String DBNAME="eag";
    //数据库类型
    public static String DBTYPE="";

    /*表相关配置*/
    //待生成表名
    public static String TABLE_NAME="eag_devices_proxy";
    //待生成表名中文注释
    public static String TABLE_NICKNAME="设备信息表";
    //主键
    public static String PRIMARYKEY="id";
    //主键类型(1自增长;2UUID)
    public static String PRIMARYKEY_TYPE="1";
    //生成实体类名称
    public static String ENTITY_NAME="DeviceInfo";
    //实体类继承表单类
    public static String ENTITY_EXTEND_NAME="DeviceInfoForm";
    //生成实体类名称
    public static String ENTITY_NICKNAME="设备信息";

    /*初始化变量*/
    static {
        DRIVER_NAME=getDriverName();
        DBURL=getDBURL();
        USERNAME=getUSERNAME();
        PASSWORD=getPASSWORD();
        DBNAME=getDBNAME();
        DBTYPE=getDBTYPE();
        PROJECT_NAME=getProjectName();
        TEAM_PACKAGE_PATH=getTeamPackagePath();
        CODE_PACKAGE_PATH=getCodePackagePath();
        ENTITY_PACKAGE_PATH=getEntityPackagePath();
        TEMPLATES_PATH=getTemplatesPath();
        VIEWTEMPLATES_PATH=getViewtemplatesPath();
        SYSTEM_ENCODING=getSystemEncoding();
        WEBROOT_PATH=getWebrootPath();
        CODE_OUTPUT_PATH=getCodeOutputPath();
        JSP_PATH=getJspPath();
        TABLE_NAME=getTableName();
        TABLE_NICKNAME=getTableNickname();
        PRIMARYKEY=getPRIMARYKEY();
        PRIMARYKEY_TYPE=getPrimarykeyType();
        ENTITY_NAME=getEntityName();
        ENTITY_EXTEND_NAME=getEntityExtendName();
        ENTITY_NICKNAME=getEntityNickname();
        TEAM_PACKAGE_REPATH=TEAM_PACKAGE_PATH.replace(".","/");
        CODE_PACKAGE_REPATH=CODE_PACKAGE_PATH.replace(".","/");

    }

   //getter
    public static String getProjectName() {
        return confbundle.getString("PROJECT_NAME");
    }

    public static String getTeamPackagePath() {
        return confbundle.getString("TEAM_PACKAGE_PATH");
    }

    public static String getTeamPackageRepath() {
        return TEAM_PACKAGE_REPATH;
    }

    public static String getCodePackagePath() {
        return confbundle.getString("CODE_PACKAGE_PATH");
    }

    public static String getCodePackageRepath() {
        return CODE_PACKAGE_REPATH;
    }

    public static String getTemplatesPath() {
        return confbundle.getString("TEMPLATES_PATH");
    }

    public static String getEntityPackagePath() {
        return confbundle.getString("ENTITY_PACKAGE_PATH");
    }

    public static String getSystemEncoding() {
        return confbundle.getString("SYSTEM_ENCODING");
    }

    public static String getWebrootPath() {
        return confbundle.getString("WEBROOT_PATH");
    }

    public static String getCodeOutputPath() {
        return confbundle.getString("CODE_OUTPUT_PATH");
    }

    public static String getJspPath() {
        return confbundle.getString("JSP_PATH");
    }

    public static String getDriverName() {
        return dbbundle.getString("driver");
    }

    public static String getDBURL() {
        return dbbundle.getString("url");
    }

    public static String getUSERNAME() {
        return dbbundle.getString("username");
    }

    public static String getPASSWORD() {
        return dbbundle.getString("password");
    }

    public static String getDBNAME() {
        return confbundle.getString("DBNAME");
    }

    public static String getDBTYPE() {
        return confbundle.getString("DBTYPE");
    }

    public static String getTableName() {
        return confbundle.getString("TABLE_NAME");
    }

    public static String getTableNickname() {
        return confbundle.getString("TABLE_NICKNAME");
    }

    public static String getPRIMARYKEY() {
        return confbundle.getString("PRIMARYKEY");
    }

    public static String getPrimarykeyType() {
        return confbundle.getString("PRIMARYKEY_TYPE");
    }

    public static String getEntityName() {
        return confbundle.getString("ENTITY_NAME");
    }

    public static String getEntityExtendName() {
        return confbundle.getString("ENTITY_EXTEND_NAME");
    }

    public static String getViewtemplatesPath() {
        return confbundle.getString("VIEWTEMPLATES_PATH");
    }

    public static String getEntityNickname() {
        return confbundle.getString("ENTITY_NICKNAME");
    }
}
