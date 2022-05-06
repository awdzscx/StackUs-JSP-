package youtube;

public class youtube {
	private String str1 = "youtube.com/watch?v=";
	private String str2 = "youtu.be/";
	private String str = "";
	
	public String youtubeLink(String str) {
		String re ="";
		int a = 0;
		
		if(str.contains(str1)){
			a =str.indexOf(str1) + str1.length();
			re = str.substring(a,str.length());
		} else if (str.contains(str2)){
			a =str.indexOf(str2) + str2.length();
			re = str.substring(a,str.length());
		}
		
		return re;
	}
}
