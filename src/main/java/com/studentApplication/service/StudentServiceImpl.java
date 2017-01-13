package com.studentApplication.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.studentApplication.dao.StudentDAO;
import com.studentApplication.dao.StudentDAOImpl;
import com.studentApplication.entity.StudentDetails;

@Service("studentService")
public class StudentServiceImpl implements StudentService{
	
	//@Autowired(required=true)  
	StudentDAOImpl studentDao = new StudentDAOImpl();  
	   
	@Transactional 
	public List<StudentDetails> getAllStudents() {
		return studentDao.getAllStudents();
	}

	@Transactional 
	public StudentDetails getStudentById(int student_id) {
		  return studentDao.getStudentById(student_id);
	}
	
	@Transactional 
	public StudentDetails addStudent(StudentDetails student) {
		 return  studentDao.addStudent(student); 
	}
	
	@Transactional 
	public void updateStudent(StudentDetails student) {
		studentDao.updateStudent(student); 
		
	}
	
	@Transactional 
	public boolean deleteStudent(int student_id) {
		return studentDao.deleteStudent(student_id); 
	}
	
//	@Transactional 
//	public StudentDetails searchStudent(String student_name) {
//		return studentDao.searchStudent(student_name); 
//	}

}
