package indi.hjk.codemaker;

import indi.hjk.codemaker.Entity.MysqlCreateBean;
import indi.hjk.codemaker.Entity.OracleCreateBean;
import indi.hjk.codemaker.Factory.MakerFactory;
import indi.hjk.codemaker.Factory.MysqlMakerFactory;
import indi.hjk.codemaker.Factory.OracleMakerFactory;
import indi.hjk.codemaker.Utils.CodeResourceUtil;

/**
 * 程序入口
 * Created by HJK on 2016/12/30.
 */
public class App {
    public static void main(String[] args){
        MakerFactory mf=new MysqlMakerFactory();
        MysqlCreateBean mcb= (MysqlCreateBean) mf.getCreateBean();
        mcb.makeCode();

    }
}
