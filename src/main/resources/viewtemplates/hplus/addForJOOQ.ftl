<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${entityNickname}管理</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    </head>
    <body class="gray-bg">
        <div class="col-lg-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content m-t-sm no-borders">
                    <form id="form1" class="margin-bottom">
                        <div class="row">
                        <#list ColumnsList as item>
                            <#assign DateTypeList = ["DATETIME", "DATE", "TIMESTAMP"]/>
                            <#if item_index==6>
                            </div>
                            <div id="cont_more_condition" class="row">
                            </#if>
                            <#if DateTypeList?seq_contains("${item.jdbctype}")>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="ibox float-e-margins">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">${item.colcomment}</label>
                                            <div class="col-sm-8">
                                                <input class="form-control layer-date" id="${item.colname}" name="${item.colname}" placeholder="请选择起始时间">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    bindLayDate("${item.colname}_start","${item.colname}_end");
                                </script>
                            </div>
                            <#else>
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="ibox float-e-margins">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">${item.colcomment}</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control" id="${item.colname}" name="${item.colname}" placeholder="请输入${item.colcomment}模糊匹配"/>
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
                                                <input type="submit" class="btn btn-sm btn-primary" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input type="reset" class="btn btn-sm btn-white ppd" value="重置" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>

    <#noparse><#include "../common/header.ftl"/></#noparse>
    <script>
        $(function () {

            $("#form1").validate({
                submitHandler:function(form){
                    doAdd();

                },rules: {
                <#list ColumnsList as item>
                    <#if item.javatype=="Integer">
                        ${item.colname}:{
                        required:true,
                        number:true
                    }
                    <#else>
                        ${item.colname}:{
                        required:true,
                        maxlength:50
                    }</#if><#sep>,</#sep>
                </#list>
                }
            });

        });

        //执行添加
        function doAdd() {
            var formData=getPostData("form1");

            $.post(<#noparse>"${acp.contextPath}/</#noparse>${entityName?lower_case}/doAdd",formData,function (res) {
                if(res.success){
                    layer.msg("添加成功",{time:1000},function () {
                        closeMySelf();
                    });
                }else{
                    layer.msg("添加失败,请重试.");
                }
            },"json");
        }
    </script>
</html>