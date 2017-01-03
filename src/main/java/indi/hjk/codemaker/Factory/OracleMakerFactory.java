package indi.hjk.codemaker.Factory;

import indi.hjk.codemaker.Entity.BaseCreateBean;
import indi.hjk.codemaker.Entity.OracleCreateBean;

/**
 * Created by HJK on 2016/12/30.
 */
public class OracleMakerFactory implements MakerFactory {

    public BaseCreateBean getCreateBean() {
        return new OracleCreateBean();
    }
}
