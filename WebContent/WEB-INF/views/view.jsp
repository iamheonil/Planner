<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <!-- CDN -->
    <script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>

<!-- 부트스트랩 3.3.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>



    <style type="text/css">
		@import url(//cdn.jsdelivr.net/font-nanum/1.0/nanumbarungothic/nanumbarungothic.css);
		
		* {
			margin: 0px;
			padding: 0px;
		}
		
		#contents {
		
		width: 1024px;
		margin: 0 auto;
		
		}
		
		#centerBtn {
		
			width: 500px;
			margin: 0 auto;
		
		}

    </style>

<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/fullcalendar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/daygrid.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/interaction.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/timegrid.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/httpRequest.js'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/settings.js'/>"></script> --%>

<link rel="stylesheet" type="text/css" href="${ctx }/resources/css/fullcalendar/daygrid.css">
<link rel="stylesheet" type="text/css" href="${ctx }/resources/css/fullcalendar/fullcalendar.css">
<link rel="stylesheet" type="text/css" href="${ctx }/resources/css/fullcalendar/timegrid.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">

<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>



<script type='text/javascript'>
	/* $(document).ready(function() {

		$("#ptime_start").datepicker({
			format: "yyyy/mm/dd",
			showOn: "button",
	        // buttonImage: "images/calendar.gif",
		    buttonImageOnly: false,
			buttonText: "Select date"
		});
		
		$("#ptime_end").datepicker({
			format: "yyyy/mm/dd",
			showOn: "button",
	        // buttonImage: "images/calendar.gif",
		    buttonImageOnly: false,
			buttonText: "Select date"
		});
		
		$("#date3").datepicker({
			onSelect:function(dateText, inst) {
				console.log(dateText);
				console.log(inst);
			}
		});
		
		console.log("달력 준비 완료");
	}); */

	document.addEventListener('DOMContentLoaded', function() {
		
		var calendarEl = document.getElementById('calendar');
		
		var calendar = new FullCalendar.Calendar(calendarEl, {
			
			plugins : [ 'interaction', 'dayGrid' ],
			// defaultDate : '2019-06-12', 기본 날짜 설정을 삭제, 오늘 날짜로 기본 설정
			editable : false,
			eventLimit : true, // allow "more" link when too many events
			locale : 'ko',
			displayEventTime: false,
			events : [ 
				<c:forEach items="${allPlan }" var="plan">
				{
				title : '${plan.plan_name }',
				start : '${plan.ptime_start }',
				end : '${plan.ptime_end }'
				}, 
			</c:forEach>
			{
				title : '',
				// url : 'http://google.com/',
				start : '',
				end : ''
			} ], 
		});

		calendar.render();

	});
	
	$(document).ready(function() {
		$('#calendar').FullCalendar.Calendar({
	    	disableDragging: true
		});		
	});
</script>

</head>

<body>


<div id="contents">

<br>
<br>

	<div id="centerBtn">

		<a data-toggle="modal" href="#addPlan"><button class="btn btn-primary">일정 등록하기</button></a>
		<a data-toggle="modal" href="#modiPlan"><button class="btn btn-success" onclick="location.href='#modiPlan'">일정 수정하기</button></a>
		<a data-toggle="modal" href="#delPlan"><button class="btn btn-danger" onclick="location.href='#delPlan'">일정 삭제하기</button></a>

	</div>
	
	<!-- 일정 추가 Modal -->
	<div class="modal fade" id="addPlan" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<h3 class="modal-title">일정 등록 폼</h3>
				</div>
				<div class="modal-body">
					<form action="/plan/insert" method="post">
						<table
							style="width: 300px; margin: 0 auto; border-collapse: separate; border-spacing: 0px 30px;">
							<tr>
								<td>일정명 :</td>
								<td><input type="text" name="plan_name" id="plan_name"
									size="20" /></td>
							</tr>
							<tr>
								<td>일정 시작 날짜 :</td>
								<td><input type="date" name="ptime_start" id="ptime_start"
									size="20" /></td>
							</tr>
							<tr>
								<td>일정 종료 날짜 :</td>
								<td><input type="date" name="ptime_end" id="ptime_end"
									size="20" /></td>
							</tr>
							<!-- <input type="button" value="달력" onclick="$('#date3').datepicker('show');" /> -->
							<tr>
								<td><button class="btn btn-primary">일정 등록 하기</button></td>
							</tr>
						</table>
						<br>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>


<!-- 일정 수정 Modal -->
	<div class="modal fade" id="modiPlan" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<h3 class="modal-title">일정 수정 폼</h3>
				</div>
				<div class="modal-body">
					<h4>등록되어 있는 나의 일정 목록</h4>
					<br>
					<c:out value="${ptime_start }"></c:out>
					<c:forEach items="${allPlan }" var="plan">
			<form action="/plan/modify?plan_num=${plan.plan_num }" method="POST">
				<table style="width: 300px; margin: 0 auto; border-collapse: separate; border-spacing: 0px 30px;">
					
						<tr>
							<td>일정명 :</td>
							<td><input type="text" name="plan_name" id="plan_name" value="${plan.plan_name }"></td>
						</tr>
						<tr>
							<td>일정 시작 날짜 :</td>
							<td><input type="date" name="ptime_start" id="ptime_start" value="${plan.ptime_start }"></td>
						</tr>
						<tr>
							<td>일정 종료 날짜 :</td>
							<td><input type="date" name="ptime_end" id="ptime_end" value="${plan.ptime_end }"></td>
						</tr>
							<tr>
								<td>
									<button class="btn btn-success" id="btnModify">해당 일정 수정</button>
								</td>
							</tr>
						</table>
				</form>
						<hr>
					</c:forEach>
					<br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 일정 삭제 Modal -->
	<div class="modal fade" id="delPlan" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<h3 class="modal-title">일정 삭제 폼</h3>
				</div>
				<div class="modal-body">
					<h4>등록되어 있는 나의 일정 목록</h4>
					<br>
					<c:out value="${ptime_start }"></c:out>
					<c:forEach items="${allPlan }" var="plan">
<script type="text/javascript">
		$(document).ready(function() {
			// 삭제버튼 동작
			$("#btnDelete").click(function() {
				location.href = "/plan/delete?plan_num=${plan.plan_num }";
			});
		});
</script>
							일정명 : ${plan.plan_name } <br>
							일정시작시간 : ${plan.ptime_start } <br>
							일정종료시간 : ${plan.ptime_end } <br>
						<button class="btn btn-danger" id="btnDelete">해당 일정 삭제</button>
						<hr>
					</c:forEach>
					<br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
<br>
<br>

	<div id="calendar">
	</div>

<br>

</div>

</body>

</html>


