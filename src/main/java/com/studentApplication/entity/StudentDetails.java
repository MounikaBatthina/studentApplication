package com.studentApplication.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Proxy;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name="STUDENT_INFO")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Proxy(lazy = false)
public class StudentDetails implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	 @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ")
	 @SequenceGenerator(name = "SEQ", sequenceName = "STUDENT_INFO_SEQ")
	@Column(name="STUDENT_ID")
    private int student_id;  
	
	@Column(name="STUDENT_NAME")
    private String student_name;
	
	@Column(name="ADDRESS")	
	private String address;
	
	
	public int getStudent_id() {
		return student_id;
	}

	public void setStudent_id(int student_id) {
		this.student_id = student_id;
	}

	public String getStudent_name() {
		return student_name;
	}

	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}


	@Override
	public String toString() {
		return "StudentDetails [student_id=" + student_id + ", student_name=" + student_name + ", address=" + address
				+ "]";
	}
	
}
