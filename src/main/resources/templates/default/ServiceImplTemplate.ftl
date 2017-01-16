package ${teamPackagePath}.service.${projectName};

import java.util.List;
import org.apache.log4j.Logger;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import ${teamPackagePath}.services.${projectName}.${entityName}Service;
import ${teamPackagePath}.repository.${projectName}.${entityName}Mapper;
import ${teamPackagePath}.entity.${projectName}.${entityName};
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
  * ${entityName}
  * Created by CoderMaker on ${createdTime}.
  */
@Component
@Transactional(readOnly = true)
public class ${entityName}ServiceImpl implements ${entityName}Service {
	private final static Logger log= Logger.getLogger(${entityName}Service.class);
	
	@Autowired
	${entityName}Mapper ${entityLowerName}Mapper;

	/**
	  * 根据实体类条件查询数据(分页)
	  * Querying data based on entity class conditions.(pagination)
	  * @param ${entityLowerName}
	  * @return Data mapping entity list
	  */
	public List<${entityName}> query${entityName}ListByCondition(${entityName} ${entityLowerName}) {
		RowBounds rb = new RowBounds();
		List<${entityName}> ${entityLowerName}List = ${entityLowerName}Mapper.query${entityName}ListByCondition(${entityLowerName}, rb);
		return ${entityLowerName}List;
	}

	/**
	  * 根据实体类条件查询数据(无分页)
	  * Querying data based on entity class conditions.(no pagination)
      * @param ${entityLowerName}
	  * @return Data mapping entity list
	  */
	public List<${entityName}> query${entityName}ListByConditionNoPage(${entityName} ${entityLowerName}){
		return ${entityLowerName}Mapper.query${entityName}ListByConditionNoPage(${entityLowerName});
	}

	/**
	  * 根据实体类条件查询数据总条数
      * Querying data count based on entity class conditions.
	  * @param ${entityLowerName}
	  * @return Total Data
	  */
	public Integer query${entityName}NumByCondition(${entityName} ${entityLowerName}) {
		Integer count = ${entityLowerName}Mapper.query${entityName}NumByCondition(${entityLowerName});
        return count;
	}

	/**
	  * 根据实体类属性进行数据添加
	  * Add data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	public void add${entityName}(${entityName} ${entityLowerName}) {
		${entityLowerName}Mapper.add${entityName}(${entityLowerName});
	}

	/**
	  * 根据主键删除数据
	  * Delete data according to the primary key.
	  * @param id  PrimaryKey
	  */
	public void delete${entityName}(String id) {
		// TODO Auto-generated method stub
		${entityLowerName}Mapper.delete${entityName}(id);
	}

	/**
	  * 根据主键获取数据实体
	  * Querying Data entity based on primary key.
	  * @param id  PrimaryKey
	  * @return Data mapping entity
	  */
	public ${entityName} get${entityName}(String id) {
		// TODO Auto-generated method stub
		return ${entityLowerName}Mapper.get${entityName}(id);
	}

	/**
	  * 根据实体类属性修改数据
	  * Modify data based on entity class attributes.
	  * @param ${entityLowerName}
	  */
	public void edit${entityName}(${entityName} ${entityLowerName}) {
		${entityLowerName}Mapper.edit${entityName}(${entityLowerName});
	}

	/**
	  * 查询所有数据
	  * Querying all data.
	  * @return Data mapping entity list
	  */
	public List<${entityName}> queryAll${entityName}(){
		return ${entityLowerName}Mapper.queryAll${entityName}();
	}

}
