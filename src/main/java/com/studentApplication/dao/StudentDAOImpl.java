package com.studentApplication.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.hibernate.Session;  
import org.springframework.stereotype.Repository;



import com.studentApplication.*;



import com.studentApplication.entity.StudentDetails;
import com.studentApplication.utill.HibernateUtill;

public class StudentDAOImpl implements StudentDAO{

	@Autowired  
	 private SessionFactory sessionFactory;  
	  
	 public void setSessionFactory(SessionFactory sf) {  
	  this.sessionFactory = sf;  
	 }
	 
	
	@SuppressWarnings("unchecked")
	public List<StudentDetails> getAllStudents() {
	 		Session session = HibernateUtill.getSessionFactory().openSession();
			 session.beginTransaction(); 
		  List<StudentDetails> studentList = session.createQuery("from StudentDetails").list(); 
		  System.out.println(studentList.get(0).getStudent_name());
		  session.getTransaction().commit();
		  return studentList;  
	}

	public StudentDetails getStudentById(int student_id) {
		Session session = HibernateUtill.getSessionFactory().openSession();
		 session.beginTransaction();   
		StudentDetails student = (StudentDetails) session.load(StudentDetails.class, student_id);
		System.out.println(student.getStudent_name());
		session.getTransaction().commit();
		  return student;  
	}

	public StudentDetails addStudent(StudentDetails student) {
		Session session = HibernateUtill.getSessionFactory().openSession();
		 session.beginTransaction(); 
		
		 session.saveOrUpdate(student);
		  
			session.getTransaction().commit();
		  return student;  
	}

	public void updateStudent(StudentDetails student) {
		Session session = HibernateUtill.getSessionFactory().openSession();
		 session.beginTransaction(); 
		  session.update(student);  
			session.getTransaction().commit();
	}

	public boolean deleteStudent(int student_id) {
		Session session = HibernateUtill.getSessionFactory().openSession();
		 session.beginTransaction(); 
		StudentDetails p = (StudentDetails) session.load(StudentDetails.class, student_id);  
		  if (null != p) {  
		   session.delete(p); 
			session.getTransaction().commit();
		   return true;
		  }  
		  return false;
	}

}
