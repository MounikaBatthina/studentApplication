
<html>
  <head>  

  
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
function valid(){
	var name = document.getElementById("Name").value;
	if (name == "" || name == null) {
		 alert("Enter your name");
		 return false;
	}
	
	var u_name = document.getElementById("Address").value;
	if (u_name == "" || u_name == null) {
		 alert("Address is required");
		 return false;
	}
	
	return true;
}
</script>
    <title>AngularJS $http Rest example</title>  
 <script type="text/javascript">
            var app = angular.module("StudentManagement", []);
         
            //Controller Part
            app.controller("StudentController", function($scope, $http) {
         
               
                $scope.students = [];
                $scope.studentForm = {
                    student_id : 0,
                    student_name    : "",
                    address : ""
                };
         
                
                _refreshStudentData();
        
                
                $scope.submitStudent = function() {
         
                    var method = "";
                    var url = "";
                    if ($scope.studentForm.student_id == 0) {
                        
                        method = "POST";
                        url = '/studentApplication/add';
                    } else {
                        
                        method = "PUT";
                        url = '/studentApplication/update';
                    }
         
                    $http({
                        method : method,
                        url : url,
                        data : angular.toJson($scope.studentForm),
                        headers : {
                            'Content-Type' : 'application/json'
                        }
                    }).then( _success, _error );
                };
         
                
                $scope.deleteStudent = function(deleteStudent) {
                    $http({
                        method : 'DELETE',
                        url : '/studentApplication/delete/' + deleteStudent.student_id
                    }).then(_success, _error);
                };
 
             
                $scope.editStudent = function(student) {
                  
                    $scope.studentForm.student_name = student.student_name;
                    $scope.studentForm.address = student.address;
                    $scope.studentForm.student_id = student.student_id;
                };
         
                
                function _refreshStudentData() {
                    $http({
                        method : 'GET',
                        url : 'http://localhost:8080/studentApplication/getStudents'
                    }).then(function successCallback(response) {
                        $scope.students = response.data;
                        console.log($scope.students.student_name)
                    }, function errorCallback(response) {
                        console.log(response.statusText);
                    });
                }
         
                function _success(response) {
                    _refreshStudentData();
                    _clearFormData()
                }
         
                function _error(response) {
                    console.log(response.statusText);
                }
         
        $scope.reset = function(){
         			$scope.studentForm.student_id = 0;
                    $scope.studentForm.student_name = "";
                    $scope.studentForm.address = "";
         };
                
                function _clearFormData() {
                    $scope.studentForm.student_id = 0;
                    $scope.studentForm.student_name = "";
                    $scope.studentForm.address = "";
                
                };
            });
        </script>

<style>
body, #mainWrapper {
  height: 70%;
  background-color:rgb(245, 245, 245);
}

body, .form-control{
  font-size:12px!important;
}

.floatRight{
  float:right;
  margin-right: 18px;
}

.has-error{
  color:red;
}

.formcontainer{
  background-color: #DAE8E8;
  padding: 20px;
}

.tablecontainer{
  padding-left: 20px;
}

.generic-container {
  width:80%;
  margin-left: 20px;
  margin-top: 20px;
  margin-bottom: 20px;
  padding: 20px;
  background-color: #EAE7E7;
  border: 1px solid #ddd;
  border-radius: 4px;
  box-shadow: 0 0 30px black;
}

.custom-width {
    width: 80px !important;
}

        </style>
</head>
    
    <body ng-app="StudentManagement" ng-controller="StudentController" class="ng-cloak">
    <div>
         <div class="generic-container" >
          <div class="panel panel-default">
              <div class="panel-heading"><span class="lead">Student Registration Form </span></div>
              <div class="formcontainer"> 
        
          <form ng-submit="submitStudent()" onsubmit="return valid()">
            
            <!--  
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Student NO</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="studentForm.student_id" name="Name" class="username form-control input-sm" placeholder="Enter student number" required ng-minlength="3"/>
                                  </div>
                          </div>
                      </div>
                -->
                 <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Name</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="studentForm.student_name" name="Name" id="name" class="username form-control input-sm" placeholder="Enter your name" required ng-minlength="3"/>
                                 <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.uname.$error.required">This is a required field</span>
                                      <span ng-show="myForm.uname.$error.minlength">Minimum length required is 3</span>
                                      <span ng-show="myForm.uname.$invalid">This field is invalid </span>
                                  </div>
                                  </div>
                          </div>
                      </div>
                
                 <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Address</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="studentForm.address" id="Address" class="form-control input-sm" placeholder="Enter your Address. [This field is validation free]"/>
                              </div>
                          </div>
                      </div>
               <div class="row">
                          <div class="form-actions floatRight">
                    <input type="submit" value="{{!studentForm.student_id ? 'Add' : 'Update'}}" class="btn btn-primary btn-sm" />
                    <button type="button" ng-click="reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset Form</button>

                    </div>

                      </div>
                  </form>
              </div>
          </div>
        </form>
       
         
 
       <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">List of Students </span><span><input type="text" ng-model="searchText" placeholder="Search Students"></span></div>
              <div class="tablecontainer">
                  <table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Name</th>
                              <th>Address</th>
                              <th width="20%"></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="student in students  | filter:searchText">
                             <!--<td><span ng-bind="student.student_id"></span></td>  --> 
                              <td><span ng-bind="student.student_name"></span></td>
                              <td><span ng-bind="student.address"></span></td>
                              <td>
                              <button type="button" ng-click="editStudent(student)" class="btn btn-success custom-width">Edit</button>  <button type="button" ng-click="deleteStudent(student)" class="btn btn-danger custom-width">Remove</button>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
      </div>
 
    </div>
      
  </body>
</html>