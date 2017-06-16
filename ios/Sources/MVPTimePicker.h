//
//  MVPTimePicker.h
//  MoviePro
//
//  Created by Erik on 17/4/24.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JarvisBasePresenter.h"

@interface MVPTimePickerPresenter : JarvisBasePresenter
@property (nonatomic,strong)NSArray *sections;/*u must set sections before others pro*/
@property (nonatomic,assign)NSInteger selectRowInCpt0;
@property (nonatomic,assign)NSInteger selectRowInCpt2;
- (void)autoLinkCpt:(NSInteger *)autoCpt autoIndex:(NSInteger*)autoIndex whenSelectAtCpt:(NSInteger)cpt index:(NSInteger)index;
@end

typedef void(^MVPSelectionBlock)(int resultType, NSDictionary *result);

@interface MVPTimePicker : UIView
@property (nonatomic, strong) MVPTimePickerPresenter *presenter;
@property (nonatomic, copy) MVPSelectionBlock selectionBlock;
- (instancetype)initWithPresenter:(id)presenter;
- (void)showInView:(UIView *)baseView;
- (void)hidePicker;
@end
