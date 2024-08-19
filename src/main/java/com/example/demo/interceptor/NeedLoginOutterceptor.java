package com.example.demo.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class NeedLoginOutterceptor implements HandlerInterceptor {
	
	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			System.err.println("==================로그인 중이야====================");
//			resp.getWriter().append("<script>~~~~");

			rq.printHistoryBack("로그인 중이야");

			return false;

		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}