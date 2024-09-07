package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.FAQService;
import com.example.demo.vo.Article;
import com.example.demo.vo.FAQ;

@Controller
public class UsrFAQController {

	@Autowired
	private FAQService faqService;

	@RequestMapping("/usr/FAQ/list")
	public String showList(Model model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "") String search, @RequestParam(defaultValue = "") String str) {

		int itemsInAPage = 10;
		int limitFrom = (page - 1) * itemsInAPage;

		int totalCnt = faqService.totalCnt(search, str);
		int totalPage = (int) Math.ceil(totalCnt / (double) itemsInAPage);

		int lpage = page - 1;
		if (page - 1 <= 0) {
			lpage = 1;
		}
		int rpage = page + 1;
		if (page + 1 >= totalPage) {
			rpage = totalPage;
		}

		List<FAQ> FAQs = faqService.getFAQs(limitFrom, itemsInAPage, search, str);

		model.addAttribute("FAQs", FAQs);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", page);
		model.addAttribute("str", str);
		model.addAttribute("lpage", lpage);
		model.addAttribute("rpage", rpage);

		return "usr/FAQ/list";
	}

}