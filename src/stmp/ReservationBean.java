package stmp;

import java.util.Date;

public class ReservationBean {
	private String RES_NAME;
	private Date RES_DATE;
	private int SEND_CHECK;
	
	public String getRES_NAME() {
		return RES_NAME;
	}
	public void setRES_NAME(String rES_NAME) {
		RES_NAME = rES_NAME;
	}
	public Date getRES_DATE() {
		return RES_DATE;
	}
	public void setRES_DATE(Date rES_DATE) {
		RES_DATE = rES_DATE;
	}
	public int getSEND_CHECK() {
		return SEND_CHECK;
	}
	public void setSEND_CHECK(int sEND_CHECK) {
		SEND_CHECK = sEND_CHECK;
	}
	
	
}
