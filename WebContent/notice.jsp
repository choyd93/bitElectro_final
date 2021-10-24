<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.bc.model.vo.NoticeVO"%>
<%@page import="java.util.List"%>
<%@page import="com.bc.model.common.Paging"%>
<%@page import="com.bc.model.dao.NoticeDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<html lang="en">
  <head>
    <title>공지사항 | bitElectro</title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="./styles.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      $(document).ready(function () {
        console.log("notice 실행");
        
        var link = document.location.href;
        console.log("link : " + link );
        
        getJSONNotice();
        
        $("#csCenterBtn").click(getJSONNotice);
        $("#cartBtn").click(getCart);
        
        $("#noticeBtn").click(getJSONNotice);
        $("#faqBtn").click(getJSONFaq);
        $("#inquireBtn").click(getJSONInquire);
        $("#login").click(getLogin);
        $("#joinMember").click(getJoinMember);
       
      });
      
      function getLogin() {
    	  console.log(">> getLogin() 실행~~~");
          location.href = "logIn.jsp"; 
      }
      
      function getJoinMember() {
    	  console.log(">> getLogin() 실행~~~");
          location.href = "joinMemberShip.jsp"; 
      }

      function getJSONNotice() {
        console.log(">> getJSONNotice() 실행~~~");

        $.ajax("csController?category=notice", {
          type: "get",
          dataType: "json", 
          success: function (data) {
        	  const list = data["list"];
              const plist = data["plist"];
              console.log(data); 
              console.log("list : " + list); 
              console.log(list); 
              console.log(plist); 
              const begin = plist[0].Begin;
              var cPage = plist[0].BeginPage;
              var cPagePrev = plist[0].BeginPage - 1;
              var cPageNext = plist[0].BeginPage + 1;
              console.log("begin : " + begin); 
              console.log("cPage : " + cPage); 
              console.log("cPagePrev : " + cPagePrev); 
              console.log("cPageNext : " + cPageNext); 
            
            // 데이터 넣기 전 공백으로 초기화 
            $("#noticeList").html("");
            
            var result = "";
            $.each(list, function(index, item){
		             result += "<tr>";
		             result += "<td>" + item.rnum + "</td>";
		           	 result += "<td>";
		           	 result += "<a href='"+"noticeOne.jsp?ccategory="+item.ccategory+"&page="+1+"&rnum="+item.rnum+"'>";
	             	 result += item.csubject + "</td>";
		             result += "<td>" + item.crdate + "</td>";
		             result += "</tr>";
         	});
            console.log("result : " + result);
            $("#noticeList").html(result);
            
            var page = "";
            page += "<tr>"
            page += "<td colspan='3'>"
            
            // 이전으로에 대한 사용여부 처리
            if(plist[0].Begin == 1){
         	  page += "<button type='button' class='pageBtn paging' disabled>이전으로</button>"
            }else {
        	  page += "<button type='button' class='pageBtn paging' onclick=javascript:location.href=inquire.jsp?cPage="+(cPagePrev)+">이전으로</button>"
            }
            
            // 블록내에 표시할 페이지 태그 작성(시작페이지~끝페이지)
            for(var i = plist[0].BeginPage; i <= plist[0].EndPage; i++){
          	  if(i == plist[0].NowPage){
      	  			page += "<button type='button' class='pageBtn pageNow paging'>"+i+"</button>"
          	  }else {
          		  	page += "<button type='button' class='pageBtn paging' onclick=javascript:location.href=inquire.jsp?cPage="+i+">"+i+"</button>"
          	  }
            }
            // [다음으로]에 대한 사용여부 처리
            if(plist[0].EndPage <= plist[0].TotalPage){
          	  page += "<button type='button' class='pageBtn paging' onclick=javascript:location.href=notice.jsp?cPage="+(cPageNext)+">다음으로</button>"
            }else if(plist[0].EndPage >= plist[0].TotalPage){
          	  page += "<button type='button' class='pageBtn paging' disabled>다음으로</button>"
            }
            page +="</ol>"
            page +="</td>"
            page +="</tr>"
            
            console.log("page : " + page);
            $("#pageBlock").html(page);
            
          },
          error: function (request, status, error) {
            alert(
              "Ajax 처리 실패, " + "\n" +
                "code : " + request.status + "\n" +
                "message : " + request.responseText + "\n" +
                "error : " + error
            );
          },
        });
      }
      
      function getJSONFaq() {
        	console.log(">> faqGo() 실행~~~");
            location.href = "faq.jsp";
        };
      
      function getJSONInquire() {
          console.log(">> getJSONInquire() 실행~~~");
          location.href = "inquire.jsp"; 
        }
      
      function getCart() {
    	  console.log(">> getCart() 실행~~~");
          location.href = "cart.jsp"; 
      }
      
    </script>
  <%@include file="headWrap.jsp" %>
  <body>

    <div id="container">
      <div id="content" class="csCenterContentHeight">
        <div class="locationArea">
          <h1>공지사항</h1>
          <hr />
        </div>
        <div id="bitContentArea">
          <div class="leftArea">
            <div class="leftMenu">
              <ul class="leftMenuBar">
                <li><button class="leftMenuTitle">고객센터</button></li>
                <li><button class="leftMenuBtn" id="noticeBtn">공지사항</button></li>
                <li><button class="leftMenuBtn" id="faqBtn"> 자주 묻는 질문 </button></li>
                <li><button class="leftMenuBtn" id="inquireBtn"> 나의 문의 내역 </button></li>
              </ul>
            </div>
          </div>
          <div id="mainArea">
            <div class="mainContent">
              <table class="tableContent">
                <thead>
                  <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>날짜</th>
                  </tr>
                </thead>
                <tbody id="noticeList">
                </tbody>
                <tfoot id="pageBlock">
                </tfoot>
              </table>
            </div>
          </div>
        </div>
        <div class="rightArea"></div>
      </div>
    </div>
  </body>
  <%@include file="footer.jsp" %>
</html>
        