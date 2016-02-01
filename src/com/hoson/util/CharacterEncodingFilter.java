/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) radix(10) lradix(10) 
// Source File Name:   CharacterEncodingFilter.java

package com.hoson.util;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.hoson.JspUtil;
import org.springframework.util.ClassUtils;
import org.springframework.web.filter.OncePerRequestFilter;

// Referenced classes of package org.springframework.web.filter:
//            OncePerRequestFilter

public class CharacterEncodingFilter extends OncePerRequestFilter {

	public CharacterEncodingFilter() {
		forceEncoding = false;
	}

	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	public void setForceEncoding(boolean forceEncoding) {
		this.forceEncoding = forceEncoding;
	}

	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		if (encoding != null
				&& (forceEncoding || request.getCharacterEncoding() == null)) {
			//request.setCharacterEncoding(encoding);
			if (forceEncoding && responseSetCharacterEncodingAvailable) {
				response.setCharacterEncoding(encoding);
				// System.out.println(request.getRemoteAddr()+
				// Function.getNowTime()+" 访问系统...");
			}
		}
		request.getSession().setMaxInactiveInterval(-1);
//		System.out.println(request.getRequestURI());
		if (request.getSession().getAttribute("user_name") == null
				&& !request.getRequestURI().endsWith("login.jsp")
				&& !request.getRequestURI().endsWith("login_action.jsp")) {
			response.sendRedirect("/" + JspUtil.getCtx(request)
					+ "/pages/login/login.jsp");
			return;
		}
		filterChain.doFilter(request, response);
	}

	/*
	 * static Class _mthclass$(String x0) { return Class.forName(x0);
	 * ClassNotFoundException x1; //x1; throw new
	 * NoClassDefFoundError(x1.getMessage()); }
	 */

	private static final boolean responseSetCharacterEncodingAvailable;
	private String encoding;
	private boolean forceEncoding;

	static {
		responseSetCharacterEncodingAvailable = ClassUtils.hasMethod(
				javax.servlet.http.HttpServletResponse.class,
				"setCharacterEncoding", new Class[] { java.lang.String.class });
	}
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * D:\eclipse\WorkSpace\xnjcxt\WebRoot\WEB-INF\lib\spring-web.jar Total time: 31
 * ms Jad reported messages/errors: Couldn't fully decompile method _mthclass$
 * Couldn't resolve all exception handlers in method _mthclass$ Exit status: 0
 * Caught exceptions:
 */
