package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.FAQRepository;
import com.example.demo.vo.FAQ;

@Service
public class FAQService {

	@Autowired
	private FAQRepository faqRepository;

	public int totalCnt(String search, String str) {
		return faqRepository.totalCnt(search, str);
	}

	public List<FAQ> getFAQs(int limitFrom, int itemsInAPage, String search, String str) {
		return faqRepository.getFAQs(limitFrom, itemsInAPage, search, str);
	}

}