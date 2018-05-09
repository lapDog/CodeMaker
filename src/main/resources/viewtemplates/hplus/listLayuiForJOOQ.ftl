<!DOCTYPE html>
<html>
<head>
    <title>${entityNickname}管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script>
        var table = layui.table,layer = layui.layer;

        $(function () {
            loadGridData();

            $("#form_query").validate({
                submitHandler:function(form){
                    queryDataByCondition();

                },rules: {
                <#list ColumnsList as item>
                    <#if item.javatype=="Integer">${item.colname}:{number:true}<#else>${item.colname}:{maxlength:50}</#if><#sep>,</#sep>
                </#list>
                }
            });

        });

        //region 数据列表初始化/重载
        function loadGridData() {
            //展示已知数据
            table.render({
                elem: '#demo'
                ,url:<#noparse>'${acp.contextPath}/</#noparse>${entityName?lower_case}/loadList'
                ,method:'POST'
                ,request:{
                    pageName: 'page' //页码的参数名称，默认：page
                    ,limitName: 'rows' //每页数据量的参数名，默认：limit
                }
                ,response: {
                    statusName: 'status' //数据状态的字段名称，默认：code
                    ,statusCode: 200 //成功的状态码，默认：0
                    ,msgName: 'msg' //状态信息的字段名称，默认：msg
                    ,countName: 'total' //数据总数的字段名称，默认：count
                    ,dataName: 'rows' //数据列表的字段名称，默认：data
                }
                ,limits: [10, 20, 30]
                ,limit: 10 //每页默认显示的数量
                ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                ,page: {
                    layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                    ,curr: 1 //设定初始在第 1 页
                    ,groups: 3 //只显示 1 个连续页码
                    ,first: false //不显示首页
                    ,last: false //不显示尾页

                }
                ,cols: [[ //标题栏
                    {field: '序号', title: '序号',type:'numbers' ,align:'center'},
                <#list ColumnsList as item>
                    {field: '${item.colname}', title: '${item.colcomment}', align:'center', sort:true},
                </#list>
                    {fixed: 'right',title:'操作', width: 165, align:'center', toolbar: '#barDemo'}
                ]]

            });

            //监听工具条
            table.on('tool(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data ,layEvent = obj.event; //获得 lay-event 对应的值
                if(layEvent === 'detail'){
                    showDetail(data.id);
                } else if(layEvent === 'del'){
                    deleteAlert(data.id);
                } else if(layEvent === 'edit'){
                    showEdit(data.id);
                }
            });

            table.on('sort(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                table.reload('demo', {
                    initSort: obj
                    ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                        sidx: obj.field //排序字段
                        ,sord: obj.type //排序方式
                    }
                });
            });
        }

        //精确查询
        function queryDataByCondition() {
            //执行重载
            table.reload('demo', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,where:getPostData("form_query")
            });
        }
        //endregion

        //region CURD操作
        //弹出新增页
        function showAdd() {
            layer.open({
                type : 2,
                title : '添加',
                area : [ '800px', '500px' ],
                fix : false, //不固定
                maxmin : true,
                shadeClose : true,
                content : <#noparse>"${acp.contextPath}/</#noparse>${entityName?lower_case}/add",
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
                area : [ '800px', '500px' ],
                fix : false, //不固定
                maxmin : true,
                shadeClose : true,
                content :<#noparse>"${acp.contextPath}/</#noparse>${entityName?lower_case}/view/"+id,
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
                content : <#noparse>"${acp.contextPath}/</#noparse>${entityName?lower_case}/edit/"+id,
                end : function() {
                    queryDataByCondition();
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
                <#noparse>$.post("${acp.contextPath}/</#noparse>${entityName?lower_case}/delete/"+id,function (res) {
                        if(res.success){
                            layer.msg('删除成功', {
                                icon: 1,
                                time:1000,
                                skin: 'layer-ext-moon', //该皮肤由layer.seaning.com友情扩展。关于皮肤的扩展规则，去这里查阅
                                end:function () {
                                    queryDataByCondition();
                                }
                            });
                        }else{
                            layer.msg('删除失败,请重试!');
                        }
                    })

            }, function(){
                //取消操作
            });
        }
        //endregion

    </script>
</head>
<body>
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox ">
                <div class="ibox-title">
                    <h5>${entityNickname}管理</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a id="btn_add" onclick="showAdd();">
                            <i class="fa fa-plus-square"></i>
                        </a>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-th-list"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li><a href="javascript:$('#form_query').toggle('hidden');">显示/隐藏所有查询条件</a>
                            </li>
                            <li><a href="javascript:$('#cont_more_condition').toggle('hidden');">显示/隐藏更多查询条件</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="ibox-content">
                    <form id="form_query" class="margin-bottom">
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
                    <!-- 表格容器 -->
                    <table class="layui-hide" id="demo" lay-filter="demo"></table>
                    <script type="text/html" id="barDemo">
                        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
                        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                    </script>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
