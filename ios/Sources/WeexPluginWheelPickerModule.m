//
//  WeexPluginWheelPickerModule.m
//  WeexPluginTemp
//
//  Created by  on 17/3/14.
//  Copyright © 2017年 . All rights reserved.
//

#import "WeexPluginWheelPickerModule.h"
#import "MVPTimePicker.h"
#import <WeexPluginLoader/WeexPluginLoader.h>

@interface WeexPluginWheelPickerModule()

@property (strong, nonatomic) MVPTimePicker *timePicker;

@end

@implementation WeexPluginWheelPickerModule

WX_PlUGIN_EXPORT_MODULE(weexPluginWheelPicker, WeexPluginWheelPickerModule)
WX_EXPORT_METHOD(@selector(showPicker:callback:))


- (void)showPicker:(NSDictionary *)data callback:(WXModuleCallback)callback{
    NSArray *sArray = (NSArray *)[data objectForKey:@"showDates"];
    NSInteger startIndex = [[data objectForKey:@"startIndex"] integerValue];
    NSInteger endIndex = [[data objectForKey:@"endIndex"] integerValue];
    if (sArray && sArray.count > 0) {
        self.timePicker.presenter.sections =  @[sArray,@[@"至"],sArray];
        self.timePicker.presenter.selectRowInCpt0 = startIndex;
        self.timePicker.presenter.selectRowInCpt2 = endIndex;
        self.timePicker.selectionBlock = ^(int resultType, NSDictionary *result) {
            callback(@{@"resultType":@(resultType),@"data":result?result:@{}});
        };
        [self.timePicker showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (MVPTimePicker *)timePicker{
    if(!_timePicker){
        _timePicker = [MVPTimePicker new];
        _timePicker.presenter = [MVPTimePickerPresenter new];
    }
    return _timePicker;
}

@end
