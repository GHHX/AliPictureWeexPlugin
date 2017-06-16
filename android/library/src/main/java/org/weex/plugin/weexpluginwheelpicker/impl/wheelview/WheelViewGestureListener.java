package org.weex.plugin.weexpluginwheelpicker.impl.wheelview;

import android.view.GestureDetector;
import android.view.MotionEvent;

/**
 * Created by guqiu on 2017/4/24.
 */

public class WheelViewGestureListener extends GestureDetector.SimpleOnGestureListener{
    private WheelView wheelView;

    public WheelViewGestureListener(WheelView wheelView) {
        this.wheelView = wheelView;
    }

    @Override
    public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
        wheelView.scrollBy(velocityY);
        return true;
    }
}
