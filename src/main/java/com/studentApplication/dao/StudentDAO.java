package com.studentApplication.dao;
import java.util.List;


import com.studentApplication.entity.StudentDetails;

public interface StudentDAO {

	    List<StudentDetails> getAllStudents();
	    StudentDetails getStudentById(int student_id);
	    StudentDetails addStudent(StudentDetails student);
	    void updateStudent(StudentDetails student);
	    boolean deleteStudent(int student_id);
	//StudentDetails searchStudent(String student_name);
	
}
