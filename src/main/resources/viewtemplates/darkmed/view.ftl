<#noparse>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="acp" value="${pageContext.request.contextPath}"/>
<jsp:include page="../common/statics.jsp"/>
</#noparse>
<html>
<head>
    <title>${entityNickname}详情</title>
</head>
<body>
    <div class="content--boxed-sm">
        <header class="content__header">
            <h2></h2>
        </header>
        <div class="card">
            <div class="card__body" >
            <#list ColumnsList as item>
                <#assign DateTypeList = ["DATETIME", "DATE", "TIMESTAMP"]/>
                <#if DateTypeList?seq_contains("${item.jdbctype}")>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="ibox float-e-margins">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${item.colcomment}</label>
                                    <div class="col-sm-8">
                                        <input class="form-control layer-date" id="${item.colname}" name="${item.colname}" readonly
                                               value="<fmt:formatDate value="<#noparse>${ </#noparse>${entityName?lower_case}<#noparse>.</#noparse>${item.colname} }" pattern="yyyy-MM-dd HH:mm:ss"/>">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <#else>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="ibox float-e-margins">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${item.colcomment}</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="${item.colname}" name="${item.colname}" readonly value="<#noparse>${ </#noparse>${entityName?lower_case}<#noparse>.</#noparse>${item.colname} }"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </#if>
            </#list>
                <div class="row border-bottom">
                    <div class="col-lg-12">
                        <div class="float-e-margins">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-12 text-center">
                                        <input type="button" onclick="closeMySelf();" class="btn btn-sm btn--light" value="关闭" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>
</html>
