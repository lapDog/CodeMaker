package ${teamPackagePath}.${projectName}.dao;

import java.util.List;
import java.util.Map;
import java.util.Set;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.jooq.Condition;
import org.jooq.DSLContext;
import org.jooq.Field;
import org.jooq.impl.DSL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import ${teamPackagePath}.${projectName}.${entityPackagePath}.${entityName};

/**
* ${entityName} Repository with JOOQ
* Created by CoderMaker on ${createdTime}.
*/
public class ${entityName}Repository {

	<#noparse>
	@Autowired
    private DSLContext create;
	</#noparse>

	//region 通用CURD方法
	/**
	 * 根据实体类条件查询数据(分页)
     * Querying data based on entity class conditions.(pagination)
	 * @param ${entityLowerName}
     * @return Data mapping entity list
	 */
	public List<${entityName}> query${entityName}ListByCondition(${entityName} ${entityLowerName}){
		return create.select(getBaseColumnList()).from(${tableName?upper_case})
				.where(queryCondition(${entityLowerName}))
				.limit(${entityLowerName}.getRows())
				.offset(${entityLowerName}.getStartIndex())
				.fetchInto(${entityName}.class);
	}

	/**
	 * 根据实体类条件查询数据(无分页)
	 * Querying data based on entity class conditions.(no pagination)
     * @param ${entityLowerName}
     * @return Data mapping entity list
	 */
	public List<${entityName}> query${entityName}ListByConditionNoPage(${entityName} ${entityLowerName}){
		return create.select(getBaseColumnList()).from(${tableName?upper_case})
				.where(queryCondition(${entityLowerName}))
				.fetchInto(${entityName}.class);
	}

	/**
	 * 根据实体类条件查询数据总条数
     * Querying data count based on entity class conditions.
     * @param ${entityLowerName}
     * @return Total Data
	 */
	public Integer query${entityName}NumByCondition(${entityName} ${entityLowerName}){
		return create.fetchCount(${tableName?upper_case},queryCondition(${entityLowerName}));
	}

	/**
	 * 根据实体类属性进行数据添加
	 * Add data based on entity class attributes.
	 * @param ${entityLowerName}
	 */
	public void add${entityName}(${entityName} ${entityLowerName}){
		create.insertInto(${tableName?upper_case}).columns(getBaseColumnList())
                .values(
				<#list ColumnsList as item>
					<#if item.nullable == 'NO'>defaultValue(${tableName?upper_case}.${item.colname?upper_case})<#else>${entityLowerName}.get${item.colname?cap_first}()</#if><#sep>,</#sep>
				</#list>
				).execute();
	}

	/**
	 * 根据主键删除数据
	 * Delete data according to the primary key.
	 * @param id  PrimaryKey
	 */
	public void delete${entityName}(Integer id){
		 create.deleteFrom(${tableName?upper_case}).where(${tableName?upper_case}.ID.eq(id)).execute();
	}

	/**
	 * 根据主键获取数据实体
	 * Querying Data entity based on primary key.
	 * @param id  PrimaryKey
	 * @return Data mapping entity
	 */
	public ${entityName} get${entityName}(Integer id){
		return create.select(getBaseColumnList()).from(${tableName?upper_case})
                .where(${tableName?upper_case}.ID.eq(id)).fetchOneInto(${entityName}.class);
	}

	/**
	 * 根据实体类属性修改数据
	 * Modify data based on entity class attributes.
	 * @param ${entityLowerName}
	 */
	public void edit${entityName}(${entityName} ${entityLowerName}){
		 create.update(${tableName?upper_case}).set(setValueEmptyClause(${entityLowerName})).execute();
	}

	/**
	 * 查询所有数据
	 * Querying all data.
	 * @return Data mapping entity list
	 */
	public List<${entityName}> queryAll${entityName}(){
		return create.select(getBaseColumnList()).from(${tableName?upper_case}).fetchInto(${entityName}.class);
	}
	//endregion

	//region 通用条件/基本字段构造
 	/**
     * 获取所有基本字段
     * @param var1 自定义字段集合
     * @return 基本查询字段+自定义字段集合
     */
    private List<Field<?>> getBaseColumnList(Field<?>...var1){
        List<Field<?>> selectFieldList= Lists.newArrayList(
		<#list ColumnsList as item>
			${tableName?upper_case}.${item.colname?upper_case}<#sep>,</#sep>
		</#list>
		);
        selectFieldList.addAll(Lists.newArrayList(var1));
        return selectFieldList;
    }

	 /**
     * 查询条件构造
     * @param ${entityLowerName}
     * @return
     */
    private Condition queryCondition(${entityName} ${entityLowerName}){
        Condition condition = DSL.trueCondition(); //equals where 1=1
<#list ColumnsList as item>
	<#if item.jdbctype == 'TIMESTAMP'>
		if(!Strings.isNullOrEmpty(${entityLowerName}.get${item.colname?cap_first}_start())){
			condition = condition.and(${tableName?upper_case}.${item.colname?upper_case}.ge(Timestamp.valueOf(${entityLowerName}.get${item.colname?cap_first}_start())));
		}
		if(!Strings.isNullOrEmpty(${entityLowerName}.get${item.colname?cap_first}_end())){
			condition = condition.and(${tableName?upper_case}.${item.colname?upper_case}.le(Timestamp.valueOf(${entityLowerName}.get${item.colname?cap_first}_end())));
		}
	<#elseif item.jdbctype == 'STRING'>
		if(!Strings.isNullOrEmpty(${entityLowerName}.get${item.colname?cap_first}())){
			condition = condition.and(${tableName?upper_case}.${item.colname?upper_case}.containsIgnoreCase(${entityLowerName}.get${item.colname?cap_first}()));
		}
	<#else>
		if(${entityLowerName}.get${item.colname?cap_first}() != null){
			condition = condition.and(${tableName?upper_case}.${item.colname?upper_case}.eq(${entityLowerName}.get${item.colname?cap_first}()));
		}
	</#if>
</#list>
		return condition;
	}

	 /**
     * 更新条件值构造
     * @param ${entityLowerName}
     * @return
     */
    private Map<Field<?>,Object> setValueEmptyClause(${entityName} ${entityLowerName}){
        Map<Field<?>,Object> map= Maps.newHashMap();
<#list ColumnsList as item>
	<#if item.jdbctype == 'STRING'>
		if(!Strings.isNullOrEmpty(${entityLowerName}.get${item.colname?cap_first}())){
			map.put(${tableName?upper_case}.${item.colname?upper_case},${entityLowerName}.get${item.colname?cap_first}());
		}
	<#else>
	 	if(${entityLowerName}.get${item.colname?cap_first}() != null){
			map.put(${tableName?upper_case}.${item.colname?upper_case},${entityLowerName}.get${item.colname?cap_first}());
		}
	</#if>
</#list>
		return map;
	}
	//endregion

	//region 自定义方法写这里

    //endregion

}
