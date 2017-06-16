package org.weex.plugin.weexpluginwheelpicker.impl.wheelview;

/**
 * Created by guqiu on 2017/4/24.
 */

public class GestureScrollRunnable implements Runnable {
    private float throlhold;
    private final float velocityY;
    private final WheelView wheelView;

    GestureScrollRunnable(WheelView loopview, float velocityY) {
        super();
        wheelView = loopview;
        this.velocityY = velocityY;
        throlhold = Integer.MAX_VALUE;
    }

    @Override
    public final void run() {
        if (throlhold == Integer.MAX_VALUE) {
            if (Math.abs(velocityY) > 2000F) {
                if (velocityY > 0.0F) {
                    throlhold = 2000F;
                } else {
                    throlhold = -2000F;
                }
            } else {
                throlhold = velocityY;
            }
        }
        if (Math.abs(throlhold) >= 0.0F && Math.abs(throlhold) <= 20F) {
            wheelView.cancelFuture();
            wheelView.handler.sendEmptyMessage(WheelMessageHandler.WHAT_SMOOTH_SCROLL);
            return;
        }
        int i = (int) ((throlhold * 10F) / 1000F);
        WheelView loopview = wheelView;
        loopview.setTotalScrollY(loopview.getTotalScrollY() - i);
        if (!wheelView.isLoop()) {
            float itemHeight = wheelView.getLineSpacingMultiplier() * wheelView.getMaxTextHeight();
            if (wheelView.getTotalScrollY() <= (int) ((float) (-wheelView.getInitPosition()) * itemHeight)) {
                throlhold = 40F;
                wheelView.setTotalScrollY((int) ((float) (-wheelView.getInitPosition()) * itemHeight));
            } else if (wheelView.getTotalScrollY() >= (int) ((float) (wheelView.items.size() - 1 - wheelView.getInitPosition()) * itemHeight)) {
                wheelView.setTotalScrollY((int) ((float) (wheelView.items.size() - 1 - wheelView.getInitPosition()) * itemHeight));
                throlhold = -40F;
            }
        }
        if (throlhold < 0.0F) {
            throlhold = throlhold + 20F;
        } else {
            throlhold = throlhold - 20F;
        }
        wheelView.handler.sendEmptyMessage(WheelMessageHandler.WHAT_INVALIDATE_LOOP_VIEW);
    }
}
