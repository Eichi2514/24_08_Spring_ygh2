package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		
		articleService.increasseHitCount(id, article.getHitCount());

		model.addAttribute("article", article);

		return "usr/article/detail";
	}

	// 로그인 체크 -> 유무 체크 -> 권한 체크 -> 수정
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String title, String body) {

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
		}

		ResultData userCanModifyRd = articleService.userCanModify(rq.getLoginedMemberId(), article);

		if (userCanModifyRd.isFail()) {
			return Ut.jsHistoryBack(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg());
		}

		if (userCanModifyRd.isSuccess()) {
			articleService.modifyArticle(id, title, body);
		}

		article = articleService.getArticleById(id);

		return Ut.jsReplace(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg(), "../article/detail?id=" + id);
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
		}

		ResultData userCanDeleteRd = articleService.userCanDelete(rq.getLoginedMemberId(), article);

		if (userCanDeleteRd.isFail()) {
			return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
		}

		if (userCanDeleteRd.isSuccess()) {
			articleService.deleteArticle(id);
		}

		return Ut.jsReplace(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg(), "../article/list");
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, int boardId, String title, String body) {

		Rq rq = (Rq) req.getAttribute("rq");
		
		if (Ut.isEmptyOrNull(title)) {
//			return ResultData.from("F-1", "제목을 입력해주세요");
			return Ut.jsReplace("F-1", "제목을 입력해주세요", "../article/write");
		}
		if (Ut.isEmptyOrNull(body)) {
			return Ut.jsReplace("F-2", "내용을 입력해주세요", "../article/write");
		}

		ResultData writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);

		int id = (int) writeArticleRd.getData1();

		Article article = articleService.getArticleById(id);

//		return ResultData.newData(writeArticleRd, "생성된 게시글", article);
		return Ut.jsReplace("S-1", Ut.f("%d번 게시글이 생성되었습니다", id), "../article/list?boardId=0&page=1");
	}

	@RequestMapping("/usr/article/list")
	public String showList(Model model, @RequestParam(defaultValue = "0") int boardId, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "") String search, @RequestParam(defaultValue = "") String str) {
		
		int itemsInAPage = 10;
		int limitFrom = (page - 1) * itemsInAPage;
		
		int totalCnt = articleService.totalCnt(boardId, search, str);
		int totalPage = (int) Math.ceil(totalCnt / (double) itemsInAPage);
		

		int lpage = page-1;
		if (page-1 <= 0) {lpage = 1;}
		int rpage = page+1;
		if (page+1 >= totalPage) {rpage = totalPage;}
							
		List<Article> articles = articleService.getArticles(boardId, limitFrom, itemsInAPage, search, str);
		Board board = boardService.getBoardByid(boardId);
		
		model.addAttribute("articles", articles);
		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", page);
		model.addAttribute("search", search);
		model.addAttribute("str", str);
		model.addAttribute("lpage", lpage);
		model.addAttribute("rpage", rpage);


		return "usr/article/list";
	}

	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) {

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
		}

		model.addAttribute("article", article);

		return "usr/article/modify";
	}

	@RequestMapping("/usr/article/write")
	public String showwrite(Model model) {

		return "usr/article/write";
	}

}