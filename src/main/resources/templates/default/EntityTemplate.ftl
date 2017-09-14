package ${teamPackagePath}.${projectName}.${entityPackagePath};

import java.io.Serializable;

/**
 * ${entityName} 实体类
 * Created by CoderMaker on ${createdTime}.
 */ 
public class ${entityName} implements Serializable {
<#assign DateTypeList = ["DATETIME", "DATE", "TIMESTAMP"]/>
<#list ColumnsList as item>
    private ${item.javatype} ${item.colname}; //  ${item.colcomment}
<#if DateTypeList?seq_contains("${item.jdbctype}")>
    private String ${item.colname}_start; //  ${item.colcomment}_开始时间
    private String ${item.colname}_end; //  ${item.colcomment}_结束时间
</#if>
</#list>

<#list ColumnsList as item>
    <#assign fieldName=item.colname?replace("_*","","r")?cap_first/>
    public ${item.javatype} get${fieldName}() {
        return ${item.colname};
    }

    public void set${fieldName}(${item.javatype} ${fieldName?lower_case}) {
        this.${item.colname} = ${fieldName?lower_case};
    }
<#if DateTypeList?seq_contains("${item.jdbctype}")>

    public String get${fieldName}_start() {
        return ${item.colname}_start;
    }

    public void set${fieldName}_start(String ${item.colname}_start) {
        this.${item.colname}_start = ${item.colname}_start;
    }

    public String get${fieldName}_end() {
        return ${item.colname}_end;
    }

    public void set${fieldName}_end(String ${item.colname}_end) {
        this.${item.colname}_end = ${item.colname}_end;
    }
<#else>

</#if>
</#list>

}

