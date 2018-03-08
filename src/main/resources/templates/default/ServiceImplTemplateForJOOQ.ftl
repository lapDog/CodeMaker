package ${teamPackagePath}.service.${projectName};

import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
  * ${entityName}
  * Created by CoderMaker on ${createdTime}.
  */
@Service
public class ${entityName}ServiceImpl implements ${entityName}Service {

	private final static Logger log= Logger.getLogger(${entityName}Service.class);
	
	@Autowired
	${entityName}Repository ${entityLowerName}Mapper;

	/**
	  * 根据实体类条件查询数据(分页)
	  * Querying data based on entity class conditions.(pagination)
	  * @param ${entityLowerName}
	  * @return Data mapping entity list
	  */
	public List<${entityExtendName}> query${entityName}ListByCondition(${entityExtendName} ${entityLowerName}) {
		return ${entityLowerName}Mapper.query${entityName}ListByCondition(${entityLowerName});
	}

	/**
	  * 根据实体类条件查询数据(无分页)
	  * Querying data based on entity class conditions.(no pagination)
      * @param ${entityLowerName}
	  * @return Data mapping entity list
	  */
	public List<${entityExtendName}> query${entityName}ListByConditionNoPage(${entityExtendName} ${entityLowerName}){
		return ${entityLowerName}Mapper.query${entityName}ListByConditionNoPage(${entityLowerName});
	}

	/**
	  * 根据实体类条件查询数据总条数
      * Querying data count based on entity class conditions.
	  * @param ${entityLowerName}
	  * @return Total Data
	  */
	public Integer query${entityName}NumByCondition(${entityExtendName} ${entityLowerName}) {
		return ${entityLowerName}Mapper.query${entityName}NumByCondition(${entityLowerName});
	}

	/**
	  * 根据实体类属性进行数据添加
	  * Add data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	@Transactional
	public void add${entityName}(${entityExtendName} ${entityLowerName}) {
		${entityLowerName}Mapper.add${entityName}(${entityLowerName});
	}

	/**
	  * 根据主键删除数据
	  * Delete data according to the primary key.
	  * @param id  PrimaryKey
	  */
	@Transactional
	public void delete${entityName}(Integer id) {
		${entityLowerName}Mapper.delete${entityName}(id);
	}

	/**
	  * 根据主键获取数据实体
	  * Querying Data entity based on primary key.
	  * @param id  PrimaryKey
	  * @return Data mapping entity
	  */
	public ${entityExtendName} get${entityName}(Integer id) {
		return ${entityLowerName}Mapper.get${entityName}(id);
	}

	/**
	  * 根据实体类属性修改数据
	  * Modify data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	@Transactional
	public void edit${entityName}(${entityExtendName} ${entityLowerName}) {
		${entityLowerName}Mapper.edit${entityName}(${entityLowerName});
	}

	/**
	  * 查询所有数据
	  * Querying all data.
	  * @return Data mapping entity list
	  */
	public List<${entityExtendName}> queryAll${entityName}(){
		return ${entityLowerName}Mapper.queryAll${entityName}();
	}

}
