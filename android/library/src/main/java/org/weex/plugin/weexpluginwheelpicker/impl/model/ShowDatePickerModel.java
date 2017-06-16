package org.weex.plugin.weexpluginwheelpicker.impl.model;

import java.io.Serializable;
import java.util.List;

/**
 * Created by guqiu on 2017/4/24.
 */
public class ShowDatePickerModel implements Serializable {

    /**
     * 默认起始点
     */
    public int startIndex;

    /**
     * 默认结束点
     */
    public int endIndex;

    /**
     * 列表
     */
    public List<String> showDates;

}
