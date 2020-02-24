<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">


<div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
                <div class="offset-md-3 col-md-7 "><h1>관리자 로그인</h1></div>
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

                    <button type="submit" class="btn btn-primary btn-block">로그인</button>
                </form>
            </div>
        </div>
    </div>

</div>
        </div>
    </div>
