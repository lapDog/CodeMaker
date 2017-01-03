package indi.hjk.codemaker.Factory;

import indi.hjk.codemaker.Entity.BaseCreateBean;

/**
 * 模板生成工厂
 * Created by HJK on 2016/12/30.
 */
public interface MakerFactory {

    /**
     * 执行生成代码
     */
    public BaseCreateBean getCreateBean();
}
