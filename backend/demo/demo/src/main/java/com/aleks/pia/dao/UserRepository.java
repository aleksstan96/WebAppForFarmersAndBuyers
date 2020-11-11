package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.User;

@CrossOrigin
public interface UserRepository extends JpaRepository<User, Long>{
	
	public Page<User> findByUsername(@RequestParam("username") String username, Pageable pageable);
	
	public Page<User> findById(@RequestParam("id") Long id, Pageable pageable);
	
	public Page<User> findByUsernameAndPassword(@RequestParam("username") String username, @RequestParam("password") String password, Pageable pageable);

}
