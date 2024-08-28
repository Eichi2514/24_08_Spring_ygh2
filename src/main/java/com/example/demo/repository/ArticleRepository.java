package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Article;

@Mapper
public interface ArticleRepository {

	@Insert("INSERT INTO article SET regDate = NOW(), updateDate = NOW(), memberId = #{memberId}, boardId = #{boardId}, title = #{title}, `body` = #{body}")
	public void writeArticle(int memberId, int boardId, String title, String body);

	@Delete("DELETE FROM article WHERE id = #{id}")
	public void deleteArticle(int id);

	@Update("UPDATE article SET updateDate = NOW(), title = #{title}, `body` = #{body} WHERE id = #{id}")
	public void modifyArticle(int id, String title, String body);

	@Select("""
			SELECT A.*, M.nickname AS extra__writer
            FROM article AS A
            INNER JOIN `member` AS M 
            ON A.memberId = M.id
            WHERE A.id = #{id}			
				""")
	public Article getForPrintArticle(int id);

	@Select("""
			SELECT A.* , M.nickname AS extra__writer
			FROM article AS A
			INNER JOIN `member` AS M
			ON A.memberId = M.id
			WHERE A.id = #{id}
				""")
	public Article getArticleById(int id);

	@Select("""
			<script>
			SELECT A.*, M.nickname AS extra__writer, IFNULL(COUNT(R.id),0) AS extra__repliesCount
            FROM article AS A
            INNER JOIN `member` AS M 
            ON A.memberId = M.id
            LEFT JOIN `reply` AS R
			ON A.id = R.relId
			WHERE 1
			<if test="boardId > 0">
			AND A.boardId = #{boardId}
			</if>
			<if test="search != ''">
			AND ${search} LIKE '%${str}%'
			</if>
			GROUP BY A.id
			ORDER BY A.id DESC
			LIMIT #{limitFrom}, #{itemsInAPage}
			</script>
			""")
	public List<Article> getArticles(int boardId, int limitFrom, int itemsInAPage, String search, String str);

	@Select("SELECT LAST_INSERT_ID();")
	public int getLastInsertId();

	@Select("""
			<script>
			SELECT COUNT(*)
			FROM article AS A
			INNER JOIN board AS B
			ON A.boardId = B.id
			WHERE 1
			<if test="boardId > 0">
			AND A.boardId = #{boardId}
			</if>
			<if test="search != ''">
			AND ${search} LIKE '%${str}%'
			</if>
			ORDER BY A.id DESC
			</script>
			""")
	public int totalCnt(int boardId, String search, String str);

	@Select("""
			SELECT hitCount
			FROM article
			WHERE id = #{id}
				""")
	public int getArticleHitCount(int id);

	@Update("""
			UPDATE article
			SET goodReactionPoint = goodReactionPoint + 1
			WHERE id = #{relId}
			""")
	public int increaseGoodReactionPoint(int relId);

	@Update("""
			UPDATE article
			SET goodReactionPoint = goodReactionPoint - 1
			WHERE id = #{relId}
			""")
	public int decreaseGoodReactionPoint(int relId);

	@Update("""
			UPDATE article
			SET badReactionPoint = badReactionPoint + 1
			WHERE id = #{relId}
			""")
	public int increaseBadReactionPoint(int relId);

	@Update("""
			UPDATE article
			SET badReactionPoint = badReactionPoint - 1
			WHERE id = #{relId}
			""")
	public int decreaseBadReactionPoint(int relId);

	@Update("""
			UPDATE article
			SET hitCount = hitCount + 1
			WHERE id = #{id}
			""")
	public int increaseHitCount(int id);

}