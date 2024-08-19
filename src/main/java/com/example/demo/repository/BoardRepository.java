package com.example.demo.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import com.example.demo.vo.Board;

@Mapper
public interface BoardRepository {

	@Select("SELECT * FROM board WHERE id = #{id}")
	public Board getBoardByid(int id);

}
