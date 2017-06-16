package org.weex.plugin.weexpluginwheelpicker;

import android.text.TextUtils;

import com.alibaba.weex.plugin.annotation.WeexModule;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;
import com.taobao.weex.common.WXModule;

import org.weex.plugin.weexpluginwheelpicker.impl.OnResultListener;
import org.weex.plugin.weexpluginwheelpicker.impl.WheelSelectorHelper;
import org.weex.plugin.weexpluginwheelpicker.impl.model.ShowDateResultModel;

import java.util.HashMap;
import java.util.Map;

@WeexModule(name = "weexPluginWheelPicker")
public class WeexPluginWheelPickerModule extends WXModule {

    @JSMethod
    public void showPicker(String param, final JSCallback callback) {
        if (TextUtils.isEmpty(param)) {
            callback.invoke(new Result("fail"));
            return;
        }
        WheelSelectorHelper.startShowDatePicker(mWXSDKInstance.getContext(), param,
                new OnResultListener<ShowDateResultModel>() {
                    @Override
                    public void onResult(ShowDateResultModel result) {
                        if (result != null) {
                            Map<String, Object> ret = new HashMap<>(2);
                            ret.put("result", "success");
                            ret.put("data", result);
                            callback.invoke(ret);
                        }
                    }
                });
    }

    public  static class Result {

        public Result(String result, Object data) {
            this.result = result;
            this.data = data;
        }
        public Result(String result) {
            this(result, null);
        }

        public String result;
        public Object data;
    }
}
