package indi.hjk.codemaker.Utils;

import java.sql.*;

/**
 * java数据库连接操作工具
 */
public class ConnectionUtil {

	private String url;
	private String driver;
	private String userName;
	private String passWord;

	private Connection conn;
	private Statement stat;
	private ResultSet rs;

	public ConnectionUtil() {
	}

	public ConnectionUtil(String driver,String url, String userName,String passWord) {
		this.url = url;
		this.driver = driver;
		this.userName = userName;
		this.passWord = passWord;
		try {
			// 加载MySql的驱动类
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			System.out.println("找不到驱动程序类 ，加载驱动失败！");
			e.printStackTrace();
		}
		this.setConnection();
	}

	/**
	 * 获取数据库链接
	 * @return Connection
	 */
	public Connection setConnection() {
		try {
			this.setConn(DriverManager.getConnection(this.getUrl(),
					this.getUserName(), this.getPassWord()));
		} catch (SQLException se) {
			System.out.println("数据库连接失败！");
			se.printStackTrace();
		}
		return this.getConn();
	}

	/**
	 * 执行更新语句
	 * @param sql
	 * @return
	 */
	public boolean executeSqlUpdate(String sql) {
		int result = -1;
		try {
			this.setStat(this.getConn().createStatement());
			result = this.getStat().executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if (this.getStat()!=null){
				this.getStat().close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (result >= 0) {
			return true;
		}
		return false;
	}
	
	/**
	 * 执行查询sql，获取结果集
	 * @return ResultSet
	 */
	public ResultSet executeQuery(String sql){
		try {
			this.setStat(this.getConn().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY));
			this.setRs(this.getStat().executeQuery(sql));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return this.getRs();
	}
	
	/**
	 * 关闭数据库链接
	 * @return boolean
	 */
	public boolean closeConnection() {
		try {
			if (this.getRs() != null) { // 关闭记录集
				try {
					this.getRs().close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (this.getStat() != null) { // 关闭声明
				try {
					this.getStat().close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (this.getConn() != null) { // 关闭连接对象
				try {
					this.getConn().close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			System.out.println("关闭连接失败!");
			return false;
		}
		return true;
	}

	// getter , setter
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	public Statement getStat() {
		return stat;
	}

	public void setStat(Statement stat) {
		this.stat = stat;
	}

	public ResultSet getRs() {
		return rs;
	}

	public void setRs(ResultSet rs) {
		this.rs = rs;
	}

}
