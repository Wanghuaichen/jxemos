package com.hoson.search;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharacterEncodeFilter implements Filter {

	private String encode;
	 public void destroy() {
	  
	 }

	 public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
	  request.setCharacterEncoding(encode);
	  filterChain.doFilter(request, response);
	 }

	 public void init(FilterConfig filterConfig) throws ServletException {
	  encode = filterConfig.getInitParameter("encode");
	 }

}
