package com.example.demo.repository;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Member;
@Mapper
public interface MemberRepository {
	@Select("SELECT LAST_INSERT_ID();")
	public int getLastInsertId();
	@Insert("INSERT INTO `member` SET regDate = NOW(), updateDate = NOW(), loginId = #{loginId}, loginPw = #{loginPw}, `name` = #{name}, nickname = #{nickname}, cellphoneNum = #{cellphoneNum}, email = #{email}")
	public void doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);
	@Select("SELECT * FROM `member` WHERE id = #{id}")
	public Member getMemberById(int id);
	@Select("SELECT * FROM `member`	WHERE loginId = #{loginId}")
	public Member getMemberByLoginId(String loginId);
	
	@Select("""
			SELECT *
			FROM `member`
			WHERE name = #{name}
			AND email = #{email}
			""")
	public Member getMemberByNameAndEmail(String name, String email);
	
	
	
	@Update("""
			<script>
			UPDATE `member` 
			SET	updateDate = NOW(),		
			<if test="loginPw != 'No'">
			loginPw = #{loginPw}, 
			</if>
			`name` = #{name},
			`nickname` = #{nickname}, 
			`email` = #{email},
			`cellphoneNum` = #{cellphoneNum}  
			WHERE id = #{loginedMemberId}
			</script>
			""")
	public void modifyMember(int loginedMemberId, String loginPw, String name, String nickname, String email, String cellphoneNum);

}