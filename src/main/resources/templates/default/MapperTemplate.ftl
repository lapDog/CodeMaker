<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${teamPackagePath}.${projectName}.dao.${entityName}Mapper" >
<!-- Mapping relation, table field, query condition and Sql block start. -->
	<!-- Result Map-->
	<resultMap id="BaseResultMap" type="${teamPackagePath}.${projectName}.entity.${entityName}" >
	<!-- TODO fix Date or Datetime type transt to Timestamp; need fix int to integer-->
	<#list ColumnsList as item>
		<result column="${item.colname}" property="${item.colname}" jdbcType="${item.jdbctype}"/>
	</#list>
	</resultMap>

	<!-- ${tableName} table all fields -->
	<sql id="Base_Column_List" >
    <#list ColumnsList as item>
		${item.colname}<#sep>,</#sep>
	</#list>
	</sql>

	<!-- Query Criteria -->
	<sql id="Example_Where_Clause">
		where 1=1
		<trim  suffixOverrides=",">
	<#list ColumnsList as item>
		<#assign DateTypeList = ["DATETIME", "DATE", "TIMESTAMP"]/>
		<#assign IntegerTypeList = ["INTEGER", "INT", "Integer"]/>
		<#if DateTypeList?seq_contains("${item.jdbctype}")>
            <if test="${item.colname}_start != null and ${item.colname}_start != ''">
                <![CDATA[ and ${item.colname} >= <#noparse>#{</#noparse>${item.colname}_start}  ]]>
            </if>
			<if test="${item.colname}_end != null and ${item.colname}_end != ''">
            	<![CDATA[ and ${item.colname} <= <#noparse>#{</#noparse>${item.colname}_end}  ]]>
        	</if>
		<#elseif IntegerTypeList?seq_contains("${item.jdbctype}")>
			<if test="${item.colname} != null">
                and ${item.colname} = <#noparse>#{</#noparse>${item.colname}}
            </if>
		<#else>
            <if test="${item.colname} != null and ${item.colname} != ''">
                and ${item.colname} = <#noparse>#{</#noparse>${item.colname}}
            </if>
		</#if>
	</#list>
		</trim>
	</sql>

	<!-- Column Empty Clause -->
    <sql id="Column_Empty_Clause">
        <trim  suffixOverrides=",">
		<#list ColumnsList as item>
			<if test="${item.colname} != null">
				${item.colname},
			</if>
		</#list>
		</trim>
	</sql>

	<!-- Column Value Empty Clause -->
	<sql id="Column_Value_Empty_Clause">
        <trim  suffixOverrides=",">
		<#list ColumnsList as item>
			<if test="${item.colname} != null">
				<#noparse>#{</#noparse>${item.colname}},
			</if>
		</#list>
		</trim>
	</sql>

	<!-- Setter Column Value Empty Clause -->
	<sql id="Setter_Value_Empty_Clause">
        <trim  suffixOverrides=",">
		<#list ColumnsList as item>
            <if test="${item.colname} != null">
				${item.colname}<#noparse>=#{</#noparse>${item.colname}},
            </if>
		</#list>
		</trim>
	</sql>

<!-- Mapping relation, table field, query condition and Sql block end. -->

<!-- General CURD operation statement starts. -->
    <!-- Insert Data -->
	<insert id="add${entityName}" parameterType="Object">
		<#if "1"==primaryKeyType>
        <selectKey resultType="java.lang.Integer" order="AFTER" keyProperty="id">
            SELECT LAST_INSERT_ID()
        </selectKey>
		</#if>
        insert into ${tableName}(
			<include refid="Column_Empty_Clause"></include>
		)values(
			<include refid="Column_Value_Empty_Clause"></include>
		)
	</insert>

	<!-- Update Data By PrimaryKey -->
	 <update id="update" parameterType="Object" >
		 update ${tableName} set
		 <#list ColumnsList as item>
			${item.colname}<#noparse>=#{</#noparse>${item.colname}}<#sep>,</#sep>
		 </#list>
		 where ${primaryKey}<#noparse>=#{</#noparse> ${primaryKey}}
	 </update>

	 <!-- Modify Data, modify only empty fields. -->
	<update id="edit${entityName}" parameterType="Object" >
		update ${tableName} set
		<include refid="Setter_Value_Empty_Clause"></include>
		where ${primaryKey}<#noparse>=#{</#noparse>${primaryKey}}
	</update>

	<!-- Delete Data by PrimaryKey -->
	<delete id="delete${entityName}" parameterType="Object">
		delete from ${tableName} where ${primaryKey}<#noparse>=#{</#noparse>${primaryKey}}
	</delete>

	<!-- Query Data by PrimaryKey -->
	<select id="get${entityName}"  resultMap="BaseResultMap" parameterType="Object">
		select
		<include refid="Base_Column_List"></include>
		from ${tableName} where ${primaryKey}<#noparse>=#{</#noparse>${primaryKey}}
	</select>

	<!-- Query Data Count Number By Condition -->
	<select id="query${entityName}NumByCondition" resultType="java.lang.Integer"  parameterType="Object">
		select count(1) from ${tableName}
		<include refid="Example_Where_Clause"></include>
	</select>

	<!-- Query Data List By Condition (Pagination) -->
	<select id="query${entityName}ListByCondition" resultMap="BaseResultMap"  parameterType="Object">
		select
		<include refid="Base_Column_List"></include>
		from ${tableName}
		<include refid="Example_Where_Clause"></include>
        <#noparse><if test="sidx != null and sidx != ''">
            order by ${sidx} ${sord}
        </if>
        limit #{startIndex},#{rows}</#noparse>
	</select>

	<!-- Query Data List By Condition (NoPagination) -->
	<select id="query${entityName}ListByConditionNoPage" resultMap="BaseResultMap"  parameterType="Object">
		select
		<include refid="Base_Column_List"></include>
		from ${tableName}
		<include refid="Example_Where_Clause"></include>
	</select>

	<!-- Query All Data (Cautiously Use) -->
	<select id="queryAll${entityName}" resultMap="BaseResultMap"  parameterType="Object">
		select
		<include refid="Base_Column_List"></include>
		from ${tableName}
	</select>

<!-- General CURD operation statement end. -->

<!-- Custom Sql statement start. -->
	<!-- Write here. -->
<!-- Custom Sql statement start. -->
</mapper>
