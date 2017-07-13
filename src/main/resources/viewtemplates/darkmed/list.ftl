<#noparse>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="acp" value="${pageContext.request.contextPath}"/>
</#noparse>
<html>
<head>
    <title>${entityNickname}管理</title>
</head>
<body>
<div class="content__header">
    <h2>${entityNickname}管理</h2>
</div>
<div class="card">
    <div class="action-header">
        <div class="action-header__label"><span class="hidden-xs">${entityNickname}查询列表,提供相关基础性操作.</span></div>
        <div class="action-header__search" style="display: none;">
            <input id="qiucksearch" type="text" placeholder="输入关键字快速搜索..." class="action-header__input">
            <i onclick="queryDataByCondition();" class="action-header__close zmdi zmdi-long-arrow-left"></i>
        </div>
        <div class="actions action-header__actions">
            <a href="" class="action-header__toggle" title="快速搜索"><i class="zmdi zmdi-search"></i></a>
            <a href="" class="action-header_exsearch" title="精确查询"><i class="zmdi zmdi-keyboard zmdi-hc-fw"></i></a>
            <a href="javascript:showAdd();" title="添加${entityNickname}"><i class="zmdi zmdi-plus-circle zmdi-hc-fw"></i></a>
        </div>
    </div>
    <div class="card__body">
        <form id="form_query" action="" style="display: none;">
            <div class="row">
            <#list ColumnsList as item>
                <#assign DateTypeList = ["DATETIME", "DATE", "TIMESTAMP"]/>
                <#if item_index==6>
                </div>
                <div id="cont_more_condition" class="row">
                </#if>
                <#if DateTypeList?seq_contains("${item.jdbctype}")>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="ibox float-e-margins">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${item.colcomment}</label>
                                    <div class="col-sm-8">
                                        <input class="form-control layer-date" id="${item.colname}_start" name="${item.colname}_start"
                                               style="width:49.5%;float:left;" placeholder="请选择起始时间">
                                        <input class="form-control layer-date" id="${item.colname}_end" name="${item.colname}_end"
                                               style="width: 49.5%;float:right;" placeholder="请选择结束时间">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            bindLayDate("${item.colname}_start","${item.colname}_end");
                        </script>
                    </div>
                <#else>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="ibox float-e-margins">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${item.colcomment}</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="${item.colname}" name="${item.colname}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </#if>
            </#list>
            </div>

            <div class="row border-bottom">
                <div class="col-lg-12">
                    <div class="float-e-margins">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-12 text-center">
                                    <input type="button" id="table_list_1_submit" onclick="queryDataByCondition();" class="btn btn-sm btn-default" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="reset" class="btn btn-sm btn--light" value="重置" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <!--jqgrid表格容器-->
        <div class="jqGrid_wrapper">
            <table id="table_list_1"></table>
            <div id="pager_list_1"></div>
        </div>
    </div>
</div>
<!-- javascript -->
<script>
    //ready function
    $(function () {
        loadGridData();

        //快速搜索，回车触发
        $("#qiucksearch").keydown(function(event) {
            if (event.keyCode == 13) {
                var keyword=$(this).val().trim();
                if(!keyword){
                    showLayTip($(this),"请输入目标库名称",1);
                    return;
                }
                var formData={};
                formData["targetname"]=keyword;
                $("#table_list_1").jqGrid('setGridParam',{
                    postData:formData
                }).trigger("reloadGrid"); //重新载入

            }
        })
    });

    //jqgrid数据填充绑定
    function loadGridData() {
        // Configuration for jqGrid Example 1
  <#noparse>$("#table_list_1").jqGrid({
            url:"${acp}/</#noparse>${entityName?lower_case}/loadList",
            mtype : "POST",
            postData: getPostData("form_query"),
            datatype: "json",
            jsonReader : {
                rows: "rows",
                total: "totalPage",
                records: "total"
            },
            height: 520,
            autowidth: true,
            shrinkToFit: true,
            rowNum : 10,
            rowList: [10, 20, 30],
            colNames: [
                <#list ColumnsList as item>
                    '${item.colcomment}',
                </#list>
                    '操作'],
            colModel: [
            <#list ColumnsList as item>
                <#if "${item.colname}"=="${primaryKey}">
                    {
                        name: '${item.colname}',
                        index: '${item.colname}',
                        key:true,
                        sorttype: "int"
                    },
                <#else>
                    {
                        name: '${item.colname}',
                        index: '${item.colname}'
                    },
                </#if>
            </#list>
                {
                    align: "center",
                    width : 250,
                    formatter : function( value, options, rows) {
                        var htmlStr = '<input type="button" class="btn btn-sm btn-default" onclick="showDetail(\'' + rows.${primaryKey} + '\');"  value="详情">&nbsp;';
                        htmlStr += '<input type="button" class="btn btn-sm btn-default" onclick="showEdit(\'' + rows.${primaryKey} + '\');"  value="修改">&nbsp;';
                        return htmlStr+'<input type="button" class="btn btn-sm btn-default" onclick="deleteAlert(\'' + rows.${primaryKey} + '\');"  value="删除">';
                    }
                }
            ],
            pager: "#pager_list_1",
            viewrecords: true,
            hidegrid: false
        });

        // Add responsive to jqGrid
        $(window).bind('resize', function () {
            var width = $('.jqGrid_wrapper').width();
            $('#table_list_1').setGridWidth(width);
        });
    }

    //精确查询
    function queryDataByCondition() {
        $("#table_list_1").jqGrid('setGridParam',{
            postData: getPostData("form_query")//发送数据
        }).trigger("reloadGrid"); //重新载入
    }

    //弹出新增页
    function showAdd() {
        layer.open({
            type : 2,
            title : '目标库添加',
            area : [ '800px', '600px' ],
            fix : false, //不固定
            maxmin : true,
            shadeClose : true,
            content :  <#noparse>"${acp}/</#noparse>${entityName?lower_case}/add",
            end : function() {
                queryDataByCondition();
            }
        });
    }

    //弹出详情页
    function showDetail(id) {
        layer.open({
            type : 2,
            title : '详情',
            area : [ '800px', '520px' ],
            fix : false, //不固定
            maxmin : true,
            shadeClose : true,
            content :<#noparse>"${acp}/</#noparse>${entityName?lower_case}/view/"+id,
            end : function() {

            }
        });
    }

    //弹出修改页
    function showEdit(id) {
        layer.open({
            type : 2,
            title : '修改',
            area : [ '800px', '500px' ],
            fix : false, //不固定
            maxmin : true,
            shadeClose : true,
            content : <#noparse>"${acp}/</#noparse>${entityName?lower_case}/edit/"+id,
            end : function() {

            }
        });
    }

    //弹出删除提示
    function deleteAlert(id) {
        layer.confirm('您确认删除此条数据？', {
            title:'警告',
            btn: ['是的','我再想想'] //按钮
        }, function(){
            //执行删除
            <#noparse>$.post("${acp}/</#noparse>${entityName?lower_case}/delete/"+id,function (res) {
                if(res.success){
                    showLayMsg("删除成功",1,1000,queryDataByCondition);
                }else{
                    showLayMsg("删除失败",7,1000);
                }
            },"json");

        }, function(){
            //取消操作
        });
    }

</script>
</body>
</html>
