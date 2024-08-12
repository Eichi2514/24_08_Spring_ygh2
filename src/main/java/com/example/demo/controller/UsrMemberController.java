package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Controller
public class UsrMemberController {

	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public Object doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {

		if(Ut.isEmptyOrNull(loginId)) {
			return "아이디 입력해";
		}
		if(Ut.isEmptyOrNull(loginPw)) {
			return "비밀번호 입력해";
		}
		if(Ut.isEmptyOrNull(name)) {
			return "이름 입력해";
		}
		if(Ut.isEmptyOrNull(nickname)) {
			return "닉네임 입력해";
		}
		if(Ut.isEmptyOrNull(cellphoneNum)) {
			return "전화번호 입력해";
		}
		if(Ut.isEmptyOrNull(email)) {
			return "이메일 입력해";
		}
		
		int id = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);

		if (id == -1) {
			return ResultData.from("F-1", Ut.f("%s는 이미 사용중인 아이디입니다.", loginId));
		}
		
		if (id == -2) {
			return ResultData.from("F-1", Ut.f("%s와 %s는 이미 사용중인 이름과 이메일입니다.", name, email));
		}

		Member member = memberService.getMemberById(id);

		return ResultData.from("S-1", Ut.f("%s님 환영합니다", name), member);
	}

}