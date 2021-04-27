package vo;

public class AccountBookVo {
	private int accountbookID;
	private String logId;
	private int meal;
	private int clothes;
	private int hospital;
	private int hair;
	private int etc;
	private String accountbookdate;
	private int accountbookAvailable;
	private String dogname;
	private String beforeDate;
	private String afterDate;
	private String total;
	public AccountBookVo() {

	}

	public AccountBookVo(String logId) {
		
		this.logId = logId;
	}

	public int getAccountbookID() {
		return accountbookID;
	}

	public void setAccountbookID(int accountbookID) {
		this.accountbookID = accountbookID;
	}

	public String getLogId() {
		return logId;
	}

	public void setLogId(String logId) {
		this.logId = logId;
	}

	public int getMeal() {
		return meal;
	}

	public void setMeal(int meal) {
		this.meal = meal;
	}

	public int getClothes() {
		return clothes;
	}

	public void setClothes(int clothes) {
		this.clothes = clothes;
	}

	public int getHospital() {
		return hospital;
	}

	public void setHospital(int hospital) {
		this.hospital = hospital;
	}

	public int getHair() {
		return hair;
	}

	public void setHair(int hair) {
		this.hair = hair;
	}

	public int getEtc() {
		return etc;
	}

	public void setEtc(int etc) {
		this.etc = etc;
	}

	public String getAccountbookdate() {
		return accountbookdate;
	}

	public void setAccountbookdate(String accountbookdate) {
		this.accountbookdate = accountbookdate;
	}

	public int getAccountbookAvailable() {
		return accountbookAvailable;
	}

	public void setAccountbookAvailable(int accountbookAvailable) {
		this.accountbookAvailable = accountbookAvailable;
	}

	public String getDogname() {
		return dogname;
	}

	public void setDogname(String dogname) {
		this.dogname = dogname;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getBeforeDate() {
		return beforeDate;
	}

	public void setBeforeDate(String beforeDate) {
		this.beforeDate = beforeDate;
	}

	public String getAfterDate() {
		return afterDate;
	}

	public void setAfterDate(String afterDate) {
		this.afterDate = afterDate;
	}
	
	
}
