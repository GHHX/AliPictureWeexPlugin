package org.weex.plugin.weexpluginwheelpicker.impl;

import android.os.Build;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;

import org.weex.plugin.weexpluginwheelpicker.R;
import org.weex.plugin.weexpluginwheelpicker.impl.model.ShowDatePickerModel;
import org.weex.plugin.weexpluginwheelpicker.impl.model.ShowDateResultModel;
import org.weex.plugin.weexpluginwheelpicker.impl.wheelview.OnWheelItemSelectedListener;
import org.weex.plugin.weexpluginwheelpicker.impl.wheelview.WheelView;


/**
 * Created by guqiu on 2017/4/24.
 */

public class WheelPickerActivity extends AppCompatActivity implements View.OnClickListener {

    public static final String KEY_SHOW_DATE_PICKER_CONTENT = "show_date_picker_content";

    private View rootView;

    private View contentView;

    private WheelView wheelStartView;

    private WheelView wheelEndView;

    private ShowDatePickerModel showDatePickerModel;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_wheel_selector_layout);

        rootView = findViewById(R.id.show_date_picker_root_indexpicker);

        contentView = findViewById(R.id.bottom_container_rootview);

        wheelStartView = (WheelView) findViewById(R.id.wheel_view_1);

        wheelEndView = (WheelView) findViewById(R.id.wheel_view_2);

        rootView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });

        findViewById(R.id.bottom_container_cancel).setOnClickListener(this);
        findViewById(R.id.bottom_container_ok).setOnClickListener(this);

        parseExtras();
        setUpWheelContent();
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
        WheelSelectorHelper.hasLauched = false;
    }

    @Override
    public void onBackPressed() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            getWindow().setTransitionBackgroundFadeDuration(0);
        }
        contentView.clearAnimation();
        Animation animation = AnimationUtils.loadAnimation(this, R.anim.slide_out_bottom);
        animation.setAnimationListener(new Animation.AnimationListener() {
            @Override
            public void onAnimationStart(Animation animation) {

            }

            @Override
            public void onAnimationEnd(Animation animation) {
                WheelSelectorHelper.hasLauched = false;
                finish();
                overridePendingTransition(0, 0);
            }

            @Override
            public void onAnimationRepeat(Animation animation) {

            }
        });
        contentView.startAnimation(animation);
    }

    private void parseExtras() {
        showDatePickerModel = (ShowDatePickerModel) getIntent().getSerializableExtra(KEY_SHOW_DATE_PICKER_CONTENT);
    }


    private void setUpWheelContent() {
        if (showDatePickerModel == null || showDatePickerModel.showDates == null) {
            return;
        }

        wheelEndView.setLoop(false);
        wheelStartView.setLoop(false);
        wheelStartView.setListener(new OnWheelItemSelectedListener() {
            @Override
            public void onItemSelected(int index) {
                if (index > wheelEndView.getSelectedItem()) {
                    wheelEndView.setCurrentPosition(index);
                }
            }
        });

        wheelEndView.setListener(new OnWheelItemSelectedListener() {
            @Override
            public void onItemSelected(int index) {
                if (index < wheelStartView.getSelectedItem()) {
                    wheelStartView.setCurrentPosition(index);
                }
            }
        });
        wheelStartView.setItems(showDatePickerModel.showDates);
        wheelEndView.setItems(showDatePickerModel.showDates);

        wheelStartView.setInitPosition(showDatePickerModel.startIndex);
        wheelEndView.setInitPosition(showDatePickerModel.endIndex);
    }

    private void callbackResult() {
        int startIndex = wheelStartView.getSelectedItem();
        int endIndex = wheelEndView.getSelectedItem();
        ShowDateResultModel resultModel = new ShowDateResultModel();
        resultModel.startIndex = startIndex;
        resultModel.endIndex = endIndex;
        WheelSelectorHelper.notifyResultListener(resultModel);
        onBackPressed();
        overridePendingTransition(0, 0);
    }

    @Override
    public void onClick(View view) {
        if (view == null) {
            return;
        }

        if (view.getId() == R.id.bottom_container_cancel) {
            finish();
            overridePendingTransition(0, 0);
        } else if (view.getId() == R.id.bottom_container_ok) {
            callbackResult();
        }
    }
}
