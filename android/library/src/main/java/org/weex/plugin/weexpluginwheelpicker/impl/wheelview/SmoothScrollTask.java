package org.weex.plugin.weexpluginwheelpicker.impl.wheelview;

/**
 * Created by guqiu on 2017/4/24.
 */

public class SmoothScrollTask implements Runnable {

    private int realTotalOffset;
    private int realOffset;
    private int offset;
    private final WheelView wheelView;

    SmoothScrollTask(WheelView wheelView, int offset) {
        this.wheelView = wheelView;
        this.offset = offset;
        realTotalOffset = Integer.MAX_VALUE;
        realOffset = 0;
    }

    @Override
    public final void run() {
        if (realTotalOffset == Integer.MAX_VALUE) {
            realTotalOffset = offset;
        }
        realOffset = (int) ((float) realTotalOffset * 0.1F);

        if (realOffset == 0) {
            if (realTotalOffset < 0) {
                realOffset = -1;
            } else {
                realOffset = 1;
            }
        }
        if (Math.abs(realTotalOffset) <= 0) {
            wheelView.cancelFuture();
            wheelView.handler.sendEmptyMessage(WheelMessageHandler.WHAT_ITEM_SELECTED);
        } else {
            wheelView.setTotalScrollY(wheelView.getTotalScrollY() + realOffset);
            wheelView.handler.sendEmptyMessage(WheelMessageHandler.WHAT_INVALIDATE_LOOP_VIEW);
            realTotalOffset = realTotalOffset - realOffset;
        }
    }
}
