package ${teamPackagePath}.${projectName}.${entityPackagePath};

/**
 * ${entityName} 实体表单类
 * Created by CoderMaker on ${createdTime}.
 */
@Data
public class ${entityExtendName} extends ${entityName} {
<#assign DateTypeList = ["DATETIME", "DATE", "TIMESTAMP"]/>
<#list ColumnsList as item>
<#if DateTypeList?seq_contains("${item.jdbctype}")>
    private String ${item.colname}_start; //  ${item.colcomment}_开始时间
    private String ${item.colname}_end; //  ${item.colcomment}_结束时间
</#if>
</#list>
}

