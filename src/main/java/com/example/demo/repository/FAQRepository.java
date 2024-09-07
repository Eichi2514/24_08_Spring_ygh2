package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Article;
import com.example.demo.vo.FAQ;

@Mapper
public interface FAQRepository {

	@Select("""
			<script>
			SELECT COUNT(*)
			FROM FAQ
			WHERE 1
			<if test="search != ''">
			AND ${search} LIKE '%${str}%'
			</if>
			</script>
			""")
	public int totalCnt(String search, String str);

	@Select("""
			<script>
			SELECT F.*, M.nickname AS extra__writer
            FROM FAQ AS F
            INNER JOIN `member` AS M 
            ON F.memberId = M.id
			WHERE 1
			<if test="search != ''">
			AND ${search} LIKE '%${str}%'
			</if>		
			LIMIT #{limitFrom}, #{itemsInAPage}
			</script>
			""")
	public List<FAQ> getFAQs(int limitFrom, int itemsInAPage, String search, String str);	

}