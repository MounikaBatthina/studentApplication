<!DOCTYPE html>
<html lang="en-US">
  <head>
    <meta charset="UTF-8" /> 
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
    <title> Spring MVC 4 REST + AngularJS </title>
    	
    <script type="text/javascript">
    		var app = angular.module('myApp', ['ngResource']);
			app.factory('Student', ['$resource', function ($resource) {
    		return $resource('http://localhost:8080/spring4-1/info/Student/:StudentId', {StudentId: '@student_id'},
			{
				updateStudent: {method: 'PUT'}
			});
			}]);

			app.controller('StudentController', ['$scope', 'Student', function($scope, Student) {
		    var ob = this;
		    ob.Students=[];
		    ob.Student = new Student(); 
		    ob.fetchAllStudents = function(){
		        ob.Students = Student.query();
		    };
		    ob.fetchAllStudents();
		    ob.addStudent = function(){
			console.log('Inside save');
			if($scope.StudentForm.$valid) {
			  ob.Student.$save(function(Student){
			     console.log(Student); 
			     ob.flag= 'created';	
			     ob.reset();	
			     ob.fetchAllStudents();
			  },
			  function(err){
			     console.log(err.status);
			     ob.flag='failed';
			  }
		          );
		        }
		    }; 
		    ob.editStudent = function(id){
			    console.log('Inside edit');
		        ob.Student = Student.get({ StudentId: id}, function() {
			       ob.flag = 'edit'; 
			    });
		    };    
		    ob.updateStudentDetail = function(){
			console.log('Inside update');
			if($scope.StudentForm.$valid) {
		    	   ob.Student.$updateStudent(function(Student){
		    		console.log(Student); 
				ob.updatedId = Student.student_id;
						ob.reset();
				ob.flag = 'updated'; 
		    		ob.fetchAllStudents();
		           });
			}
		    };	
		    ob.deleteStudent = function(id){
			    console.log('Inside delete');
			    ob.Student = Student.deleteStudent({ StudentId: id}, function() {
				ob.reset();  
				ob.flag = 'deleted';
		    		ob.fetchAllStudents(); 
			    });
		    };		
		    ob.reset = function(){
		    	ob.Student = new Student();
		        $scope.StudentForm.$setPristine();
		    };	
		    ob.cancelUpdate = function(id){
			    ob.Student = new Student();
			    ob.flag= '';	
		   	    ob.fetchAllStudents();
		    };    
      }]);    
   
    </script>
    <style type="text/css">
    .msg-val {
	color: red;
		}
.msg-success {
	color: green;
}
    </style>
  </head>
  
  <body ng-app="myApp">
   <div ng-controller="StudentController as StudentCtrl">
       <h1> Spring MVC 4 REST + AngularJS </h1>
	<form name="StudentForm" method="POST">
	    <table>
		<tr><td colspan="2">
		  <div ng-if="StudentCtrl.flag != 'edit'">
		     <h3> Add New Student </h3> 
		  </div>
		  <div ng-if="StudentCtrl.flag == 'edit'">
		     <h3> Update Student for ID: {{ StudentCtrl.Student.student_id }} </h3> 
		  </div> </td>
		</tr>
		<tr>
		      <td>Name: </td> <td><input type="text" name="name" ng-model="StudentCtrl.Student.name" required/> 
         	      <span ng-show="StudentForm.name.$error.required" class="msg-val">Name is required.</span> </td>
		</tr>
		<tr>
		      <td>Location: </td> <td> <input type="text" name="location" ng-model="StudentCtrl.Student.location" required/> 
	              <span ng-show="StudentForm.location.$error.required" class="msg-val">Location is required.</span> </td>
		</tr>
		<tr>
		     <td colspan="2"> <span ng-if="StudentCtrl.flag=='created'" class="msg-success">Student successfully added.</span>
		     <span ng-if="StudentCtrl.flag=='failed'" class="msg-val">Student already exists.</span> </td>
		</tr>
	        <tr><td colspan="2">
	            <div ng-if="StudentCtrl.flag != 'edit'">
		       <input  type="submit" ng-click="StudentCtrl.addStudent()" value="Add Student"/> 
		       <input type="button" ng-click="StudentCtrl.reset()" value="Reset"/>
		    </div>
		    <div ng-if="StudentCtrl.flag == 'edit'">
		       <input  type="submit" ng-click="StudentCtrl.updateStudentDetail()" value="Update Student"/> 	
			   <input type="button" ng-click="StudentCtrl.cancelUpdate()" value="Cancel"/>				   
		    </div> </td>
		</tr>
		<tr>
		     <td colspan="2"> <span ng-if="StudentCtrl.flag=='deleted'" class="msg-success">Student successfully deleted.</span>
		</tr>
	    </table>     
	</form>
        <table>
	      <tr><th>ID </th> <th>Name</th> <th>Location</th></tr>
	      <tr ng-repeat="row in StudentCtrl.Students">
	         <td><span ng-bind="row.student_id"></span></td>
	         <td><span ng-bind="row.name"></span></td>
	         <td><span ng-bind="row.location"></span></td>
	         <td>
		    <input type="button" ng-click="StudentCtrl.deleteStudent(row.student_id)" value="Delete"/>
		    <input type="button" ng-click="StudentCtrl.editStudent(row.student_id)" value="Edit"/>
		    <span ng-if="StudentCtrl.flag=='updated' && row.student_id==StudentCtrl.updatedId" class="msg-success">Student successfully updated.</span> </td> 
	      </tr>	
	</table>
	</div>

 </body>
</html>  
  