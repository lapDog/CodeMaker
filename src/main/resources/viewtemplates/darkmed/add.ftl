<#noparse>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="acp" value="${pageContext.request.contextPath}"/>
<jsp:include page="../common/statics.jsp"/>
</#noparse>
<html>
<head>
    <title>${entityNickname}添加</title>
    <script>
        //提交数据
        function submitData() {
            var formData=getPostData("form1");
            <#noparse>$.post("${acp}/</#noparse>${entityName?lower_case}/doAdd",formData,function (res) {
                if(res.success){
                    showLayMsg("添加成功",1,1500,closeMySelf);
                }else{
                    showLayMsg("添加失败",7,1500);
                }
            },"json");

        }
    </script>
</head>
<body>
    <div class="content--boxed-sm">
        <header class="content__header">
            <h2></h2>
        </header>
        <div class="card">
            <div class="card__header">
                <h2>填写以下信息进行添加 <small>修改此处...</small></h2>
            </div>
            <div class="card__body" >
                <form id="form1">
                    <div class="row">
            <#list ColumnsList as item>
                <#assign DateTypeList = ["DATETIME", "DATE", "TIMESTAMP"]/>
                <#if DateTypeList?seq_contains("${item.jdbctype}")>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="ibox float-e-margins">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${item.colcomment}</label>
                                    <div class="col-sm-8">
                                        <input class="form-control layer-date" id="${item.colname}" name="${item.colname}" placeholder="请选择${item.colcomment}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            bindLayDate("${item.colname}");
                        </script>
                    </div>
                <#else>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="ibox float-e-margins">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${item.colcomment}</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="${item.colname}" name="${item.colname}" />
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
                                            <input type="button" onclick="submitData();" class="btn btn-sm btn-default" value="添加"/>
                                            <input type="reset" class="btn btn-sm btn--light" value="重置" />
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
</html>
