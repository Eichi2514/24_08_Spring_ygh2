package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrMemberController {
	
	@Autowired
	private Rq rq;

	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");
		
		rq.logout();
		
		return Ut.jsReplace("S-1", Ut.f("로그아웃 되었습니다"), "/");
	}
	
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "/usr/member/login";
	}
	

	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "/usr/member/join";
	}


	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw, String afterLoginUri) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isEmptyOrNull(loginId)) {
			return Ut.jsHistoryBack("F-1", "loginId 입력 x");
		}
		if (Ut.isEmptyOrNull(loginPw)) {
			return Ut.jsHistoryBack("F-2", "loginPw 입력 x");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("F-3", Ut.f("%s는(은) 존재 x", loginId));
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("F-4", Ut.f("비밀번호 틀림"));
		}
		
		rq.login(member);
		
		if (afterLoginUri.length() > 0) {
			return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getNickname()), afterLoginUri);
		}
		

		return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getNickname()), "/");
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(HttpServletRequest req, String loginId, String loginPw, String name,
			String nickname, String cellphoneNum, String email) {
		
		if (Ut.isEmptyOrNull(loginId)) {
			return Ut.jsHistoryBack("F-1", "loginId 입력 x");
		}
		if (Ut.isEmptyOrNull(loginPw)) {
			return Ut.jsHistoryBack("F-2", "loginPw 입력 x");
		}
		if (Ut.isEmptyOrNull(name)) {
			return Ut.jsHistoryBack("F-3", "name 입력 x");
		}
		if (Ut.isEmptyOrNull(nickname)) {
			return Ut.jsHistoryBack("F-4", "nickname 입력 x");
		}
		if (Ut.isEmptyOrNull(cellphoneNum)) {
			return Ut.jsHistoryBack("F-5", "cellphoneNum 입력 x");
		}
		if (Ut.isEmptyOrNull(email)) {
			return Ut.jsHistoryBack("F-6", "email 입력 x");
		}
		
		ResultData doJoinRd = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);

		if (doJoinRd.isFail()) {
			return Ut.jsHistoryBack(doJoinRd.getResultCode(), doJoinRd.getMsg());
		}

		Member member = memberService.getMemberById((int) doJoinRd.getData1());

		return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", nickname), "../member/login");
	}
	
	@RequestMapping("/usr/member/myPage")
	public String showmyPage() {
		return "usr/member/myPage";
	}

	@RequestMapping("/usr/member/checkPw")
	public String showCheckPw() {
		return "usr/member/checkPw";
	}
	
	@RequestMapping("/usr/member/doCheckPw")
	@ResponseBody
	public String doCheckPw(String loginPw) {
		if (Ut.isEmptyOrNull(loginPw)) {
			return Ut.jsHistoryBack("F-1", "비밀번호 입력 x");
		}

		if (rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("F-2", "비밀번호 틀림");
		}

		return Ut.jsReplace("S-1", Ut.f("비밀번호 확인 성공"), "modify");
	}

	@RequestMapping("/usr/member/modify")
	public String showmyModify() {
		return "usr/member/modify";
	}
	
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, @RequestParam(defaultValue = "No") String loginPw, String name, String nickname, String email, String cellphoneNum) {

			if (Ut.isEmptyOrNull(name)) {
				return Ut.jsHistoryBack("F-3", "name 입력 x");
			}
			if (Ut.isEmptyOrNull(nickname)) {
				return Ut.jsHistoryBack("F-4", "nickname 입력 x");
			}
			if (Ut.isEmptyOrNull(cellphoneNum)) {
				return Ut.jsHistoryBack("F-5", "cellphoneNum 입력 x");
			}
			if (Ut.isEmptyOrNull(email)) {
				return Ut.jsHistoryBack("F-6", "email 입력 x");
			}
		
			ResultData modifyRD = memberService.modifyMember(rq.getLoginedMemberId(), loginPw, name, nickname, email, cellphoneNum);
			
		
		return Ut.jsReplace("S-1", Ut.f("회원정보 수정 성공"), "myPage");
	}

}