package indi.hjk.codemaker.Entity;

import indi.hjk.codemaker.Utils.CommParseUtil;
import indi.hjk.codemaker.Utils.ConnectionUtil;
import indi.hjk.codemaker.Utils.StringsUtils;
import indi.hjk.codemaker.Utils.SystemConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 用于生成Mysql数据库的实体类
 * Created by HJK on 2016/12/30.
 */
public class MysqlCreateBean implements BaseCreateBean {

    private final static Logger logger= LoggerFactory.getLogger(MysqlCreateBean.class);

    //用于存放数据库字段
    private static List<Map<String,String>> ColumnsList=new ArrayList<Map<String, String>>();

    //存放模板导出数据
    private static Map<String,String> DataMap=new HashMap<String, String>();

    /**
     * 执行代码生成
     */
    public void makeCode() {
        System.out.println("Mysql制造代码开始");

        //1.初始化配置文件，获取相应变量--SystemConfig


        //2.连接数据库，获取数据库表结构
        getColumnDatas(SystemConfig.getProperty("Table_Name"));
        initPathInfoLoader();
        //3.生成实体类
        CommParseUtil.ParseContent(DataMap,"EntityTemplate.ftl",DataMap.get("CP_bean"));
        //4.生成DAO层(dao接口/mapper文件)

        //5.生成Service层(service接口/实现类)

        //6.生成Controller层

        //7.生成CURD页面


        System.out.println("Mysql制造代码完毕");
    }

    /**
     * 获取表字段/类型/别名/长度 等
     * @param tableName
     */
    private void getColumnDatas(String tableName) {
        //加载数据库配置文件
        Properties prop= SystemConfig.loadPropertiesByPath("/properties/jdbc.properties");

        ConnectionUtil conn=new ConnectionUtil(prop.getProperty("driver"),prop.getProperty("url"),prop.getProperty("username"),prop.getProperty("password"));
        //查询数据库表DESC
        ResultSet rs=conn.executeQuery("select column_name,data_type,column_comment,character_maximum_length,is_nullable nullable " +
                "from information_schema.columns where table_name ='"+SystemConfig.getProperty("Table_Name")+"'and table_schema = '"+SystemConfig.getProperty("DataBase_Name")+"'");

        try {
            while (rs.next()){
                Map<String,String> temp=new HashMap<String, String>();
                temp.put("columnName",rs.getString(1));
                temp.put("dataType",rs.getString(2));
                temp.put("columnComment",rs.getString(3));
                temp.put("charMaxLength",rs.getString(4));
                temp.put("isNullable",rs.getString(5));

                ColumnsList.add(temp);
            }
        } catch (SQLException e) {
            logger.debug("Tip->循环结果集出错.");
            e.printStackTrace();
        }finally {
            conn.closeConnection();
        }

    }

    /**
     * 初始化路径
     */
    private void initPathInfoLoader(){
        String tableName = StringsUtils.getTablesNameToClassName(SystemConfig.getProperty("Table_Name"));
        DataMap.put("CreatedTime",new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
        DataMap.put("tableName",SystemConfig.getProperty("Table_Name"));
        DataMap.put("className",tableName);
        DataMap.put("basePackagePath",SystemConfig.getProperty("BasePath_Package"));
        DataMap.put("bussiPackagePath",SystemConfig.getProperty("BasePath_BussiPackage"));
        DataMap.put("projectName",SystemConfig.getProperty("Project_Name"));
        DataMap.put("primaryKey",SystemConfig.getProperty("Table_Primary"));
        //初始化生成目录CP(CreatedPath)
        DataMap.put("CP_bean",SystemConfig.getProperty("CreatedPath_Default")+"entity\\"+SystemConfig.getProperty("Project_Name")+"\\"+tableName+".java");
        DataMap.put("CP_dao",SystemConfig.getProperty("CreatedPath_Default")+"dao\\"+SystemConfig.getProperty("Project_Name")+"\\"+tableName+"Mapper.java");
        DataMap.put("CP_service",SystemConfig.getProperty("CreatedPath_Default")+"service\\"+SystemConfig.getProperty("Project_Name")+"\\"+tableName+"Service.java");
        DataMap.put("CP_serviceImp",SystemConfig.getProperty("CreatedPath_Default")+"service\\"+SystemConfig.getProperty("Project_Name")+"\\"+tableName+"ServiceImp.java");
        DataMap.put("CP_controller",SystemConfig.getProperty("CreatedPath_Default")+"controller\\"+SystemConfig.getProperty("Project_Name")+"\\"+tableName+"Controller.java");
        DataMap.put("CP_sqlmap",SystemConfig.getProperty("CreatedPath_Default")+"sqlmap\\"+SystemConfig.getProperty("Project_Name")+"\\"+tableName+"Mapper.xml");
        //页面生成路径VP(ViewsPath)
        DataMap.put("VP_add",SystemConfig.getProperty("CreatedPath_Default")+"views\\"+tableName+"\\add.jsp");
        DataMap.put("VP_list",SystemConfig.getProperty("CreatedPath_Default")+"views\\"+tableName+"\\list.jsp");
        DataMap.put("VP_view",SystemConfig.getProperty("CreatedPath_Default")+"views\\"+tableName+"\\view.jsp");
        DataMap.put("VP_edit",SystemConfig.getProperty("CreatedPath_Default")+"views\\"+tableName+"\\edit.jsp");

        DataMap.put("beanFeilds","hello word");

    }

    /**
     * 拼接Bean字段
     * @return
     */
    private String getBeanFeilds(){

        StringBuffer fields=new StringBuffer();
        StringBuffer methods=new StringBuffer();

        return "";
    }

}
