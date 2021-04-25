package vo;

public class MemberVo {
	private String logId;
	private String pwd;
	private String pwdcheck;
	private String dogname;
	private String email;
	private String gender;
	private String age;
	private String Profile;
	

	public MemberVo() {
		
	}

	public MemberVo(String logId, String pwd, String dogname, String email, String gender, String age) {
		
		this.logId = logId;
		this.pwd = pwd;
		this.dogname = dogname;
		this.email = email;
		this.gender = gender;
		this.age = age;
	}

	public String getLogid() {
		return logId;
	}

	public void setLogid(String logid) {
		this.logId = logid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	
	
	public String getPwdcheck() {
		return pwdcheck;
	}

	public void setPwdcheck(String pwdcheck) {
		this.pwdcheck = pwdcheck;
	}

	public String getDogname() {
		return dogname;
	}

	public void setDogname(String dogname) {
		this.dogname = dogname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getProfile() {
		return Profile;
	}

	public void setProfile(String profile) {
		Profile = profile;
	}
 
}
