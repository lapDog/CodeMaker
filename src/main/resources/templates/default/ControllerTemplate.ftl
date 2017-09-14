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
import ${teamPackagePath}.${projectName}.controller.BaseController;
import ${teamPackagePath}.${projectName}.entity.${entityName};
import ${teamPackagePath}.${projectName}.service.${entityName}Service;
import ${teamPackagePath}.${projectName}.entity.common.PageBean;
import ${teamPackagePath}.${projectName}.utils.JsonUtil;

/**
  * ${entityName} Controller
  * Created by CoderMaker on ${createdTime}.
  */
@Controller
@RequestMapping("/${entityLowerName}")
public class ${entityName}Controller extends BaseController{
	
	private final static Logger logger= LoggerFactory.getLogger(${entityName}Controller.class);
	
	@Autowired
	private ${entityName}Service ${entityLowerName}Service; 
	
	/**
	 * 跳转至查询页面
     * Jump to query page
	 * @param ${entityLowerName} 实体类
	 * @param flag
     * @param pageIndex 分页当前页，默认1
     * @param pageSize 分页每页数量，默认10
     * @param total 分页总数，默认0
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String  list(HttpServletRequest request,${entityName} ${entityLowerName},
			@RequestParam (required=false)String flag,
			@RequestParam(value = "page", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "rows", defaultValue = "10") Integer pageSize,
			@RequestParam(value = "total", defaultValue = "0") Integer total,
			@RequestParam (required=false)String id, Model model) throws Exception{

		return "${entityLowerName}/list";
	}

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
	public String loadList(HttpServletRequest request,${entityName} ${entityLowerName},
			@RequestParam (required=false)String flag,
			@RequestParam(value = "page", defaultValue = "1") Integer pageIndex,
			@RequestParam(value = "rows", defaultValue = "10") Integer pageSize,
			@RequestParam(value = "total", defaultValue = "0") Integer total,
			@RequestParam (required=false)String id, Model model) throws Exception{

		logger.info("查询${entityName}列表开始");
		if(null==total||total.intValue()<=0){
			total= Integer.parseInt(${entityLowerName}Service.query${entityName}NumByCondition(${entityLowerName}).toString());
		}
		//设置分页对象
		PageBean<${entityName}> page = new PageBean<${entityName}>();
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
		${entityLowerName}.setStartIndex(((pageIndex == 0 ? 1 : pageIndex) - 1) * pageSize * 1l);
		${entityLowerName}.setEndIndex((pageIndex) * pageSize * 1l);
		
		//查询集合		
		List<${entityName}> ${entityLowerName}List = ${entityLowerName}Service.query${entityName}ListByCondition(${entityLowerName});
		page.setRows(${entityLowerName}List);
		logger.info("查询${entityName}列表结束");
		return JsonUtil.toJSONString(page);
	}
	
	/**
      * 跳转添加页面
      * jump to add page
      */
	@RequestMapping("/add")
	public String add(HttpServletRequest request,@RequestParam (required=false)String flag,Model model) {
		model.addAttribute("flag", flag);
		return "${entityLowerName}/add";
	}

	/**
      * 执行添加操作
      * do add operation
 	  */
	@RequestMapping(value = "/doAdd", method = RequestMethod.POST)
	@ResponseBody
	public String doAdd(HttpServletRequest request,${entityName} ${entityLowerName}) {
		try {
			logger.info("${entityName}添加处理开始");
			${entityLowerName}Service.add${entityName}(${entityLowerName});
			logger.info("${entityName}添加处理结束");
		} catch (Exception e) {
			return JsonUtil.toJSONString(new Result(false,"add operation fail.",""));
		}
		return JsonUtil.toJSONString(new Result(true,"",""));
	}

	/**
	  * 跳转至编辑页面
	  * jump to edit page
	  */
	@RequestMapping(value="/edit/{id}", method=RequestMethod.GET)
	public String edit(@PathVariable String id,@RequestParam (required=false)String flag, Map<String, Object> map) {
		${entityName} ${entityLowerName} = ${entityLowerName}Service.get${entityName}(id);
		map.put("${entityLowerName}", ${entityLowerName});
		map.put("flag", flag);
		return "${entityLowerName}/edit";
	}

	/**
	  * 执行编辑操作
	  * do edit operation
	  */
	@RequestMapping(value="/doEdit", method=RequestMethod.POST)
	@ResponseBody
	public String doEdit(HttpServletRequest request,${entityName} ${entityLowerName}) {
		try{
			logger.info("${entityName}修改处理开始");
			${entityLowerName}Service.edit${entityName}(${entityLowerName});
			logger.info("${entityName}修改处理结束");
		}catch (Exception e) {
			e.printStackTrace();
			return JsonUtil.toJSONString(new Result(false,"edit operation fail.",""));
		}
		return JsonUtil.toJSONString(new Result(true,"",""));
	}

	/**
	  * 跳转至详情页面
	  * jump to detail page
	  */
	@RequestMapping(value="/view/{id}", method=RequestMethod.GET)
	public String view(HttpServletRequest request,@PathVariable String id, Map<String, Object> map) {
		${entityName} ${entityLowerName} = ${entityLowerName}Service.get${entityName}(id);
		map.put("${entityLowerName}", ${entityLowerName});
		return "${entityLowerName}/view";
	}
	
	/**
	 * 执行删除操作
     * do delete operation
	 */
	@RequestMapping(value="/delete/{id}", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String delete(HttpServletRequest request,@PathVariable String id) {
		try{
			logger.info("${entityName}删除处理开始");
			${entityLowerName}Service.delete${entityName}(id);
			logger.info("${entityName}删除处理结束");
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtil.toJSONString(new Result(false,"delete operation fail.",""));
		}
		return JsonUtil.toJSONString(new Result(true,"",""));
	}
	
}
