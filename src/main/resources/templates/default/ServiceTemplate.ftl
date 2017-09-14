package ${teamPackagePath}.services.${projectName};
import java.util.List;

import ${teamPackagePath}.${projectName}.${entityPackagePath}.${entityName};

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
	List<${entityName}> query${entityName}ListByCondition(${entityName} ${entityLowerName});

	/**
	  * 根据实体类条件查询数据(无分页)
	  * Querying data based on entity class conditions.(no pagination)
	  * @param ${entityLowerName}
	  * @return Data mapping entity list
	  */
	List<${entityName}> query${entityName}ListByConditionNoPage(${entityName} ${entityLowerName});

	/**
	  * 根据实体类条件查询数据总条数
	  * Querying data count based on entity class conditions.
	  * @param ${entityLowerName}
	  * @return Total Data
	  */
	Integer query${entityName}NumByCondition(${entityName} ${entityLowerName});

	/**
      * 根据实体类属性进行数据添加
	  * Add data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	public void add${entityName}(${entityName} ${entityLowerName});

	/**
	  * 根据主键删除数据
	  * Delete data according to the primary key.
	  * @param id  PrimaryKey
	  */
	public void delete${entityName}(String id);

	/**
	  * 根据主键获取数据实体
	  * Querying Data entity based on primary key.
	  * @param id  PrimaryKey
	  * @return Data mapping entity
	  */
	public ${entityName} get${entityName}(String id);

	/**
	  * 根据实体类属性修改数据
	  * Modify data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	public void edit${entityName}(${entityName} ${entityLowerName});

	/**
	  * 查询所有数据
	  * Querying all data.
	  * @return Data mapping entity list
	  */
	List<${entityName}> queryAll${entityName}();
}
