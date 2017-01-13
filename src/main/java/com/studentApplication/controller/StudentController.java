package com.studentApplication.controller;




import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;  
import org.springframework.web.bind.annotation.RequestBody;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.bind.annotation.RestController;


import com.studentApplication.dao.StudentDAOImpl;
import com.studentApplication.entity.StudentDetails;
import com.studentApplication.service.StudentService;
import com.studentApplication.service.StudentServiceImpl;  

@RestController
@RequestMapping("/studentApplication")
public class StudentController {
	
	//@Autowired(required=true)
	private StudentServiceImpl studentService = new StudentServiceImpl();
	
  @RequestMapping(value="/hello", method = RequestMethod.GET, headers="Accept=application/json")
  public String sayHello(){
	System.out.println("calling greeting");
	   return "Hi";
  }
	@RequestMapping("/home")
	public String home() {
 		return "home";
 	}
	
	@RequestMapping(value= "/getStudents", method = RequestMethod.GET,headers = "Accept=application/json")
	public List<StudentDetails> getAllstudents() {
		List<StudentDetails> list = studentService.getAllStudents();
		return list;
	}
	
	@RequestMapping(value="/edit/{id}", method = RequestMethod.GET ,headers = "Accept=application/json")
	public StudentDetails getstudentById(@PathVariable("id") Integer id) {
		StudentDetails student = studentService.getStudentById(id);
		return student;
	}

	@RequestMapping(value= "/add", method = RequestMethod.POST,headers = "Accept=application/json")
	public void addstudent(@RequestBody StudentDetails student) {
		StudentDetails flag = studentService.addStudent(student);
//        if ((flag != null)) {
//        	return true;
//        }
       //return flag;
	}
	
	@RequestMapping(value="/update/{id}", method = RequestMethod.PUT,headers = "Accept=application/json" )
	public void updatestudent(@RequestBody StudentDetails student) {
		studentService.updateStudent(student);
	}
	
	@RequestMapping(value="/delete/{id}", method = RequestMethod.DELETE ,headers = "Accept=application/json")
	public boolean deletestudent(@PathVariable("id") Integer id) {
		boolean flag= studentService.deleteStudent(id);
		return flag;
		
	}	
}
