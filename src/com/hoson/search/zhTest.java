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
  char[] s1 = {'��','Ҽ','��','��','��','��','½','��','��','��'};
  char[] s4 = {'��','��','Ԫ','ʰ','��','Ǫ','��','ʰ','��','Ǫ','��','ʰ','��','Ǫ','��'};

   //Сд���
     String str = String.valueOf(Math.round(money * 100 + 0.001));
     String result = "";
     //System.out.println(str);

    //ת���ɴ�д���
     for (int i = 0; i < str.length(); i++)
  {
      int n = str.charAt(str.length() - 1 - i) - 48;
      result = s1[n] + "" + s4[i] + result;
  }
     //�������滻����д���������������
     result=result.replaceAll("��Ǫ","��");
     result=result.replaceAll("���","��");
     result=result.replaceAll("��ʰ","��");
     result=result.replaceAll("����","��");
     result=result.replaceAll("����","��");
     result=result.replaceAll("��Ԫ","Ԫ");
     result=result.replaceAll("���","��");
     result=result.replaceAll("���","��");

     result=result.replaceAll("����","��");
     result=result.replaceAll("����","��");
     result=result.replaceAll("����","��");
     result=result.replaceAll("����","��");
     result=result.replaceAll("����","��");
     result=result.replaceAll("��Ԫ","Ԫ");
     result=result.replaceAll("����","��");

     result=result.replaceAll("��$","");
     result=result.replaceAll("Ԫ$","Ԫ��");
     return result;
    }


}
