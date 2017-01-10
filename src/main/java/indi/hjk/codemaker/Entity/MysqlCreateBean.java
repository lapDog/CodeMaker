package indi.hjk.codemaker.Entity;

import indi.hjk.codemaker.Utils.*;
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
    private static List<ColumnData> ColumnsList=new ArrayList<ColumnData>();

    //存放模板导出数据
    private static Map<String,String> DataMap=new HashMap<String, String>();

    /**
     * 执行代码生成
     */
    public void makeCode() {
        System.out.println("Mysql制造代码开始");

        //1.初始化配置文件，获取相应变量--SystemConfig


        //2.连接数据库，获取数据库表结构
        getColumnDatas();
        //初始化数据集
        initDataMap();
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
     */
    private void getColumnDatas() {

        ConnectionUtil conn=new ConnectionUtil(CodeResourceUtil.DRIVER_NAME,CodeResourceUtil.DBURL,CodeResourceUtil.USERNAME,CodeResourceUtil.PASSWORD);
        //查询数据库表DESC
        ResultSet rs=conn.executeQuery("select column_name,data_type,column_comment,character_maximum_length,is_nullable nullable " +
                "from information_schema.columns where table_name ='"+CodeResourceUtil.TABLE_NAME+"'and table_schema = '"+CodeResourceUtil.DBNAME+"'");

        try {
            while (rs.next()){
                ColumnData cd=new ColumnData();
                cd.setColname(rs.getString(1).toLowerCase());
                cd.setJdbctype(rs.getString(2));
                cd.setJavatype(StringStuffUtil.transDbtypeToJavatype(rs.getString(2),"0","0"));
                cd.setColcomment(rs.getString(3));
                cd.setMaxLength(rs.getString(4)==null?"":rs.getString(4));
                cd.setNullable(StringStuffUtil.getNullAble(rs.getString(5)));
                ColumnsList.add(cd);

            }
        } catch (SQLException e) {
            logger.debug("Tip->循环结果集出错.");
            e.printStackTrace();
        }finally {
            conn.closeConnection();
        }

    }

    /**
     * 初始化相关变量集
     */
    private void initDataMap(){
        DataMap.put("projectName",CodeResourceUtil.PROJECT_NAME);
        DataMap.put("createdTime",new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
        DataMap.put("teamPackagePath",CodeResourceUtil.TEAM_PACKAGE_PATH);
        DataMap.put("codePackagePath",CodeResourceUtil.CODE_PACKAGE_PATH);
        DataMap.put("entityPackagePath",CodeResourceUtil.ENTITY_PACKAGE_PATH);
        DataMap.put("entityName",CodeResourceUtil.ENTITY_NAME);
        DataMap.put("entityContents",getBeanFeilds());//实体类内容填充

        //文件写出路径(代码生成路径以后的路径)
        DataMap.put("CP_bean","entity\\" + CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME+".java");


    }

    /**
     * 拼接Bean字段及GetterAndSetter
     * @return
     */
    private String getBeanFeilds(){
        StringBuffer fields = new StringBuffer();//存放字段
        StringBuffer getset = new StringBuffer();//存放getter and setter

        for (ColumnData d : ColumnsList) {

            //日期类型加上日期起始时间
            if ("DATE".equals(d.getJdbctype().toUpperCase())||"DATETIME".equals(d.getJdbctype().toUpperCase())||"TIMESTAMP".equals(d.getJdbctype().toUpperCase())) {
                String sname = d.getColname() + "_start";
                String stype = "java.lang.String";
                String scomment = d.getColcomment() + "_开始时间";
                String ename = d.getColname() + "_end";
                String etype = "java.lang.String";
                String ecomment = d.getColcomment() + "_结束时间";
                // starttime getter and setter
                fields.append("\r\t").append("private ").append(stype + " ").append(sname).append(";//   ").append(scomment);
                String smethod = CamelCaseUtil.toCapitalizeCamelCase(sname);
                getset.append("\r\t").append("public ").append(stype + " ").append("get" + smethod + "() {\r\t");
                getset.append("    return this.").append(sname).append(";\r\t}");
                getset.append("\r\t").append("public void ").append("set" + smethod + "(" + stype + " " + sname + ") {\r\t");
                getset.append("    this." + sname + "=").append(sname).append(";\r\t}");
                // endtime getter and setter
                fields.append("\r\t").append("private ").append(etype + " ").append(ename).append(";//   ").append(ecomment);
                String emethod = CamelCaseUtil.toCapitalizeCamelCase(ename);
                getset.append("\r\t").append("public ").append(etype + " ").append("get" + emethod + "() {\r\t");
                getset.append("    return this.").append(ename).append(";\r\t}");
                getset.append("\r\t").append("public void ").append("set" + emethod + "(" + etype + " " + ename + ") {\r\t");
                getset.append("    this." + ename + "=").append(ename).append(";\r\t}");

            }else{
                //fields
                fields.append("\r\t").append("private ").append(d.getJavatype() + " ").append(d.getColname()).append(";//   ").append(d.getColcomment());
                //getter拼接
                String colMethodName=CamelCaseUtil.toCapitalizeCamelCase(d.getColname());
                getset.append("\r\t").append("public ").append(d.getJavatype() + " ").append("get" + colMethodName + "() {\r\t");
                getset.append("    return this.").append(d.getColname()).append(";\r\t}");
                //setter拼接
                getset.append("\r\t").append("public void ").append("set" + colMethodName + "(" + d.getJavatype() + " " + d.getColname() + ") {\r\t");
                getset.append("    this." + d.getColname() + "=").append(d.getColname()).append(";\r\t}");
            }

        }
       return fields.toString()+getset.toString();

    }

}
