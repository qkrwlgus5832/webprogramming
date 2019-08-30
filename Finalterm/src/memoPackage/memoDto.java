package memoPackage;

import java.sql.Timestamp;

/**
 * @author sec
 *
 */
public class memoDto {

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	private int num;
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public Timestamp getIndate() {
		return indate;
	}

	public void setIndate(Timestamp indate) {
		this.indate = indate;
	}

	private String name;
	private String title;
	private String pass;
	private Timestamp indate;
	
	public memoDto() {
		// TODO Auto-generated constructor stub
	}
	
	public memoDto(int num, String name, String title, Timestamp indate, String pass ) {
		// TODO Auto-generated constructor stub
		this.name=name;
		this.title=title;
		this.pass=pass;
		this.indate = indate;
		this.pass =pass;
		this.num = num;

	}
	

}