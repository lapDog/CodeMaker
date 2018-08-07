package ${teamPackagePath}.web.${projectName};

import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import ${teamPackagePath}.${projectName}.entity.common.PageBean;

/**
  * ${entityName} Controller
  * Created by CoderMaker on ${createdTime}.
  */
@RestController
@RequestMapping("/${entityLowerName}")
public class ${entityName}Controller extends BaseController{
	
	private final static Logger logger= LoggerFactory.getLogger(${entityName}Controller.class);
	
	@Autowired
	private ${entityName}Service ${entityLowerName}Service; 

	//region CURD Restful API
	/**
      * 执行添加操作
      * do add operation
      * @param ${entityLowerName}
	  * @return
 	  */
	@PostMapping("")
	public Result doAdd(@RequestBody ${entityExtendName} ${entityLowerName}) {
		logger.info("add ${entityName} started!");
		try{
			${entityLowerName}Service.add${entityName}SkipEmpty(${entityLowerName});
		}catch (Exception e){
			e.printStackTrace();
			return ResultUtil.fail();
		}
		logger.info("add ${entityName} done!");
		return ResultUtil.success();
	}

	/**
	 * 根据主键获取实体信息
	 * get entity by primary key
	 * @param id
	 * @return
	 */
	@GetMapping("/{id}")
	public Result get(@PathVariable Integer id){
		logger.info("get ${entityName} started!");
		${entityExtendName} ${entityLowerName} = ${entityLowerName}Service.get${entityName}(id);
		if(${entityLowerName}==null){
			return ResultUtil.fail("No Data");
		}
		logger.info("add ${entityName} done!");
		return ResultUtil.success("success",${entityLowerName});
	}

	/**
      * 更新操作(跳过空字段)
      * do update operation Skip empty
	  * @param ${entityLowerName}
	  * @return
 	  */
	@PatchMapping("/{id}")
	public Result doEdit(@RequestBody ${entityExtendName} ${entityLowerName}) {
		logger.info("edit ${entityName} started!");
		try{
			${entityLowerName}Service.edit${entityName}(${entityLowerName});
		}catch (Exception e){
			e.printStackTrace();
			return ResultUtil.fail();
		}
		logger.info("edit ${entityName} done!");
		return ResultUtil.success();
	}

	/**
      * 更新操作(全量更新)
      * do update operation
	  * @param ${entityLowerName}
	  * @return
 	  */
	@PutMapping("/{id}")
	public Result doUpdate(@RequestBody ${entityExtendName} ${entityLowerName}) {
		logger.info("update ${entityName} started!");
		try{
			${entityLowerName}Service.edit${entityName}(${entityLowerName});
		}catch (Exception e){
			e.printStackTrace();
			return ResultUtil.fail();
		}
		logger.info("update ${entityName} done!");
		return ResultUtil.success();
	}

	/**
	 * 根据主键删除数据
	 * @param id
	 * @return
	 */
	@DeleteMapping("/{id}")
	public Result delete(@PathVariable Integer id){
		logger.info("delete ${entityName} statred!");
		try{
			${entityLowerName}Service.delete${entityName}(id);
		}catch (Exception e){
			e.printStackTrace();
			return ResultUtil.fail();
		}
		logger.info("delete ${entityName} done!");
		return ResultUtil.success();
	}
	//endregion

	//region 分页查询数据
	/**
      * 分页查询数据
	  * Query Data by pagination
	  * @param ${entityLowerName} 实体类
	  * @param flag
	  * @param pageIndex 分页当前页，默认1
	  * @param pageSize 分页每页数量，默认10
	  * @param total 分页总数，默认0
	  * @return
	  * @throws Exception
	  */
	@RequestMapping(value="/loadList", method={RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
	public PageBean loadList(HttpServletRequest request,${entityExtendName} ${entityLowerName},
			@RequestParam (required=false)String flag,
			@RequestParam(value = "page", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "rows", defaultValue = "10") Integer pageSize,
			@RequestParam(value = "total", defaultValue = "0") Integer total,
			@RequestParam (required=false)String id, Model model) throws Exception{

		logger.info("查询${entityName}列表开始");
		if(null == total || total <= 0){
			total = ${entityLowerName}Service.query${entityName}NumByCondition(${entityLowerName});
		}
		//设置分页对象
		PageBean<${entityExtendName}> page = new PageBean<${entityExtendName}>();
		page.setTotal(total);
		page.setPageIndex(pageIndex);
		page.setPageSize(pageSize);
		Integer totalPage = 0;
	     if (total % pageSize == 0)
	       totalPage = total / pageSize;
	     else {
	       totalPage = total / pageSize + 1;
	     }
		page.setTotalPage(totalPage);
		//压入查询参数:开始位置与查询多少条数
		${entityLowerName}.setStartIndex(((pageIndex == 0 ? 1 : pageIndex) - 1) * pageSize);
		${entityLowerName}.setEndIndex(pageIndex * pageSize);
		
		//查询集合		
		List<${entityExtendName}> ${entityLowerName}List = ${entityLowerName}Service.query${entityName}ListByCondition(${entityLowerName});
		page.setRows(${entityLowerName}List);
		logger.info("查询${entityName}列表结束");
		return page;
	}
	//endregion

}
