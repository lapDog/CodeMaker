package ${teamPackagePath}.services.${projectName};
import java.util.List;

/**
 * ${entityName} Service Interface
 * Created by CoderMaker on ${createdTime}.
 */
public interface ${entityName}Service {

	/**
	  * 根据实体类条件查询数据(分页)
	  * Querying data based on entity class conditions.(pagination)
	  * @param ${entityLowerName}
	  * @return Data mapping entity list
	  */
	List<${entityExtendName}> query${entityName}ListByCondition(${entityExtendName} ${entityLowerName});

	/**
	  * 根据实体类条件查询数据(无分页)
	  * Querying data based on entity class conditions.(no pagination)
	  * @param ${entityLowerName}
	  * @return Data mapping entity list
	  */
	List<${entityExtendName}> query${entityName}ListByConditionNoPage(${entityExtendName} ${entityLowerName});

	/**
	  * 根据实体类条件查询数据总条数
	  * Querying data count based on entity class conditions.
	  * @param ${entityLowerName}
	  * @return Total Data
	  */
	Integer query${entityName}NumByCondition(${entityExtendName} ${entityLowerName});

	/**
      * 根据实体类属性进行数据添加
	  * Add data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	void add${entityName}(${entityExtendName} ${entityLowerName});

	/**
      * 根据实体类属性进行数据添加(跳过空字段)
	  * Add data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	void add${entityName}SkipEmpty(${entityExtendName} ${entityLowerName});

	/**
	  * 根据主键删除数据
	  * Delete data according to the primary key.
	  * @param id  PrimaryKey
	  */
	void delete${entityName}(Integer id);

	/**
	  * 根据主键获取数据实体
	  * Querying Data entity based on primary key.
	  * @param id  PrimaryKey
	  * @return Data mapping entity
	  */
	${entityExtendName} get${entityName}(Integer id);

	/**
	  * 根据实体类属性修改数据
	  * Modify data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	void edit${entityName}(${entityExtendName} ${entityLowerName});

	/**
	  * 查询所有数据
	  * Querying all data.
	  * @return Data mapping entity list
	  */
	List<${entityExtendName}> queryAll${entityName}();
}
