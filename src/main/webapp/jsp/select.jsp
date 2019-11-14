<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Shaochenjie
  Date: 2019/8/14
  Time: 19:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:import url="to/jsp.jsp"/>
    <title>Title</title>
</head>
<body>
<div class="hero">
    <div class="hero-body">
        <div class="columns ">
           <div class="column">
               <select name="type">

                   <option value="0">全部</option>
                   <option value="bookName" <c:if test="${book.type eq 'bookName'}">selected</c:if>>书名</option>
                   <option value="bookAuthor" <c:if test="${book.type eq 'bookAuthor'}">selected</c:if>>作者</option>
                   <option value="bookPublish" <c:if test="${book.type eq 'bookPublish'}">selected</c:if>>出版社</option>
               </select>
               <input type="text" name="value" value="${book.value}">
               <input type="button" id="but" class="button" value="提交">
           </div>
        </div>
                    <a href="${ctx}/book/toAdd" class="button">增加新书</a>
                    <table class="layui-table" lay-even>
                        <colgroup>
                            <col width="150">
                            <col width="200">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>书名</th>
                            <th>作者</th>
                            <th>出版社</th>
                            <th>页数</th>
                            <th>价格</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="obj">
                            <tr>
                                <td>${obj.bookName}</td>
                                <td>${obj.bookAuthor}</td>
                                <td>${obj.bookPublish}</td>
                                <td>${obj.bookPage}</td>
                                <td>${obj.bookPrice}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                <div>
                        <a href="javascript:void (0)" data="page-first" class="button">首页</a>||<a href="javascript:void (0)" data="page-prev" class="button">上一页</a>||<a href="javascript:void (0)" data="page-next" class="button">下一页</a>||<a href="javascript:void (0)" data="page-last" class="button">尾页</a>第 ${page.pageNum}页/共${page.pages}页(${page.total}条记录)
                </div>


        <form action="${ctx}/book/query" method="post">
            <input type="hidden" name="pageNum" value="${page.pageNum}">
            <input type="hidden" name="pageSize" value="${page.pageSize}">
            <input type="hidden" value="" id="type" name="type">
            <input type="hidden" value="" id="value" name="value">
        </form>
    </div>
</div>
<script>
    $(function () {
        $("a[data^='page']").click(function () {
            $("#type").val($("select[name='type']").val());
            $("#value").val($("input[name='value']").val());
            var page = $(this).attr("data");
            var creeNum = ${page.pageNum};
            var pages = ${page.pages};
            var pageNum = 1;
                switch (page) {
                    case "page-first":
                        if(creeNum <= 1){
                            pageNum=1;
                        }
                        break;
                    case "page-prev":
                        if(creeNum<=1){
                            layer.msg("已经是第一页了");
                            return
                        }
                        pageNum=creeNum-1;
                        break;
                    case "page-next":
                        if(creeNum>=pages){
                            layer.msg("已经是最后一页了");
                            return
                        }
                        pageNum=creeNum+1;
                        break;
                    case "page-last":
                        if(creeNum>=1){
                            pageNum=${page.pages};
                        }
                        break;
                }
                $("input[name='pageNum']").val(pageNum);
                $("form").submit();
        })
        $("#but").click(function () {
            $("#type").val($("select[name='type']").val());
            $("#value").val($("input[name='value']").val());
            var page = 'page-first';
            var creeNum = ${page.pageNum};
            var pages = ${page.pages};
            var pageNum = 1;
            switch (page) {
                case "page-first":
                    if(creeNum <= 1){
                        pageNum=1;
                    }
                    break;
                case "page-prev":
                    if(creeNum<=1){
                        layer.msg("已经是第一页了");
                        return
                    }
                    pageNum=creeNum-1;
                    break;
                case "page-next":
                    if(creeNum>=pages){
                        layer.msg("已经是最后一页了");
                        return
                    }
                    pageNum=creeNum+1;
                    break;
                case "page-last":
                    if(creeNum>=1){
                        pageNum=${page.pages};
                    }
                    break;
            }
            $("input[name='pageNum']").val(pageNum);
            $("form").submit();
        })
    });

</script>
</body>
</html>
