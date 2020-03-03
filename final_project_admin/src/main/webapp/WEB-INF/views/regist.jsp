<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<div style="padding-top: 50px;">
<jsp:include page="template/header.jsp"></jsp:include>
</div>


<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-4 col-md-4 ">
                <div class="row justify-content-center" style="padding: 20px;"><h1>관리자 등록</h1></div>
                <br><br><br>
                <form action="" method="post"> 
                <!-- <form class="form-inline">옆으로 오는 입력 형식 -->
                    <!--아이디 입력창-->
                    <div class="form-group">
                        <label for="id-input">ID : </label>
                        <input class="form-control" type="text" id="id-input" name="admin_id" required>
                    </div>
                    
                    <!--비밀번호 입력창-->
                    <div class="form-group">
                        <label for="pw-input">PW : </label>
                        <input class="form-control" type="password" id="pw-input" name="admin_pw" required>
                    </div>
                    
                    <!--이름 입력창-->
                    <div class="form-group">
                        <label for="pw-input">이름 : </label>
                        <input class="form-control" type="text" id="pw-input" name="admin_name" required>
                    </div>
                    
                    <!--이메일 입력창-->
                    <div class="form-group">
                        <label for="pw-input">이메일 : </label>
                        <input class="form-control" type="text" id="pw-input" name="admin_email" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block">관리자가입</button>
                </form>
            </div>
        </div>
    </div>

