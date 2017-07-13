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
    private static Map<String,Object> DataMap=new HashMap<String, Object>();

    /**
     * 执行代码生成
     */
    public void makeCode() {
        System.out.println("Mysql制造代码开始");

        //2.连接数据库，获取数据库表结构
        getColumnDatas();
        //初始化数据集
        initDataMap();
        //3.生成实体类
        CommParseUtil.ParseContent(0,DataMap,"EntityTemplate.ftl",DataMap.get("CP_bean").toString());
        //4.生成DAO层(dao接口/mapper文件)
        CommParseUtil.ParseContent(0,DataMap,"DaoTemplate.ftl",DataMap.get("CP_dao").toString());
        CommParseUtil.ParseContent(0,DataMap,"MapperTemplate.ftl",DataMap.get("CP_mapper").toString());
        //5.生成Service层(service接口/实现类)
        CommParseUtil.ParseContent(0,DataMap,"ServiceTemplate.ftl",DataMap.get("CP_service").toString());
        CommParseUtil.ParseContent(0,DataMap,"ServiceImplTemplate.ftl",DataMap.get("CP_serviceimpl").toString());
        //6.生成Controller层
        CommParseUtil.ParseContent(0,DataMap,"ControllerTemplate.ftl",DataMap.get("CP_controller").toString());
        //7.生成CURD页面
        CommParseUtil.ParseContent(1,DataMap,"list.ftl",DataMap.get("CP_listview").toString());
        CommParseUtil.ParseContent(1,DataMap,"add.ftl",DataMap.get("CP_addview").toString());
        CommParseUtil.ParseContent(1,DataMap,"edit.ftl",DataMap.get("CP_editview").toString());
        CommParseUtil.ParseContent(1,DataMap,"view.ftl",DataMap.get("CP_view").toString());



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
                cd.setJdbctype(rs.getString(2).toUpperCase());
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
        DataMap.put("entityLowerName",CodeResourceUtil.ENTITY_NAME.toLowerCase());
        DataMap.put("ColumnsList",ColumnsList);
        DataMap.put("tableName",CodeResourceUtil.TABLE_NAME);
        DataMap.put("primaryKey",CodeResourceUtil.PRIMARYKEY);
        DataMap.put("primaryKeyType",CodeResourceUtil.PRIMARYKEY_TYPE);
        DataMap.put("entityNickname",CodeResourceUtil.ENTITY_NICKNAME);
        //文件写出路径(代码生成路径以后的路径)
        DataMap.put("CP_bean","entity\\" + CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME+".java");
        DataMap.put("CP_dao","dao\\" + CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME+"Mapper.java");
        DataMap.put("CP_mapper","mapper\\" + CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME+"Mapper.xml");
        DataMap.put("CP_service","service\\" + CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME+"Service.java");
        DataMap.put("CP_serviceimpl","service\\" + CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME+"ServiceImpl.java");
        DataMap.put("CP_controller","controller\\" + CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME+"Controller.java");
        //页面生成路径
        DataMap.put("CP_listview","views\\"+CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME.toLowerCase()+"\\"+"list.jsp");
        DataMap.put("CP_addview","views\\"+CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME.toLowerCase()+"\\"+"add.jsp");
        DataMap.put("CP_view","views\\"+CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME.toLowerCase()+"\\"+"view.jsp");
        DataMap.put("CP_editview","views\\"+CodeResourceUtil.PROJECT_NAME+"\\"+CodeResourceUtil.ENTITY_NAME.toLowerCase()+"\\"+"edit.jsp");


    }

}
