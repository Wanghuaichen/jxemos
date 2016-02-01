package com.hoson.search;

public class zhTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		zhTest zh = new zhTest();
		System.out.println(zh.changeToChinese(1232328.00));
	}

	public static String changeToChinese(double money)
    {
  char[] s1 = {'零','壹','贰','叁','肆','伍','陆','柒','捌','玖'};
  char[] s4 = {'分','角','元','拾','佰','仟','万','拾','佰','仟','亿','拾','佰','仟','万'};

   //小写金额
     String str = String.valueOf(Math.round(money * 100 + 0.001));
     String result = "";
     //System.out.println(str);

    //转换成大写金额
     for (int i = 0; i < str.length(); i++)
  {
      int n = str.charAt(str.length() - 1 - i) - 48;
      result = s1[n] + "" + s4[i] + result;
  }
     //以下是替换，大写金额里面的特殊情况
     result=result.replaceAll("零仟","零");
     result=result.replaceAll("零佰","零");
     result=result.replaceAll("零拾","零");
     result=result.replaceAll("零亿","亿");
     result=result.replaceAll("零万","万");
     result=result.replaceAll("零元","元");
     result=result.replaceAll("零角","零");
     result=result.replaceAll("零分","零");

     result=result.replaceAll("零零","零");
     result=result.replaceAll("零亿","亿");
     result=result.replaceAll("零零","零");
     result=result.replaceAll("零万","万");
     result=result.replaceAll("零零","零");
     result=result.replaceAll("零元","元");
     result=result.replaceAll("亿万","亿");

     result=result.replaceAll("零$","");
     result=result.replaceAll("元$","元整");
     return result;
    }


}
