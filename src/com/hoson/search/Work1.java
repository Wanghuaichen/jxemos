package com.hoson.search;

public class Work1 {

	public static void main(String[] args) {
		 int[] a = {5,9,7,1};
		 for (int i = a.length - 1; i >= 0; i--) {
		  for (int j = 0; j < i; j++) {
		   if(a[j] < a[j+1]){
		    int temp;
		    temp = a[j];
		    a[j] = a[j+1];
		    a[j+1] = temp;
		   }
		  }
		  System.out.println("aa:"+a[i]);
		 }
		System.out.println("aa:");
	}
}
