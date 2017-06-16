package org.weex.plugin.weexpluginwheelpicker.impl;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import com.alibaba.fastjson.JSON;

import org.weex.plugin.weexpluginwheelpicker.impl.model.ShowDatePickerModel;
import org.weex.plugin.weexpluginwheelpicker.impl.model.ShowDateResultModel;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by guqiu on 2017/4/24.
 */

public final class WheelSelectorHelper {
    private static OnResultListener<ShowDateResultModel> listener;
    public static boolean hasLauched;

    public static void startShowDatePicker(Context context, String jsParams, OnResultListener<ShowDateResultModel> callback) {
        ShowDatePickerModel data = JSON.parseObject(jsParams, ShowDatePickerModel.class);
        startShowDatePicker(context, data, callback);
    }

    public static void startShowDatePicker(Context context, ShowDatePickerModel data, OnResultListener<ShowDateResultModel> callback) {
        if (data == null) {
            return;
        }
        if (hasLauched) {//页面已经存在
            return;
        }
        hasLauched = true;
        listener = callback;
        if (context == null) {
            return;
        }
        Intent intent = new Intent(context, WheelPickerActivity.class);
        intent.putExtra(WheelPickerActivity.KEY_SHOW_DATE_PICKER_CONTENT, data);

        if (!(context instanceof Activity)) {
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        }

        try {
            context.startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void notifyResultListener(ShowDateResultModel result) {
        if (listener == null) {
            return;
        }
        listener.onResult(result);
        listener = null;
    }


    public static ShowDatePickerModel testData() {
        ShowDatePickerModel model = new ShowDatePickerModel();
        List<String> items = new ArrayList<>();

        for (int i = 0; i < 20; i++) {
            items.add("item: " + i);
        }
        model.showDates = items;
        model.startIndex = 1;
        model.endIndex = 4;
        return model;
    }

}
