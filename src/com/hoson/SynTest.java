package com.hoson;

public class SynTest{
	 
	 public synchronized  String get()throws Exception{
         String t1 = f.time()+"";
       String t2 = null;
       Thread.sleep(5000);
       t2 = f.time()+"";
       String s = t1+","+t2;
       return s;
}

    public synchronized static  String get2()throws Exception{
              String t1 = f.time()+"";
            String t2 = null;
            Thread.sleep(5000);
            t2 = f.time()+"";
            String s = t1+","+t2;
            return s;
   }
    
  }
