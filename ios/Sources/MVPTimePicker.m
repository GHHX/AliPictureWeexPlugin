//
//  MVPTimePicker.m
//  MoviePro
//
//  Created by Erik on 17/4/24.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPTimePicker.h"
@implementation MVPTimePickerPresenter
- (void)setSelectRowInCpt0:(NSInteger)selectRowInCpt0{
    if(!_sections || _sections.count<=0){
        _selectRowInCpt0 = 0;
    }
    NSArray *rows = _sections[0];
    _selectRowInCpt0 = MAX(selectRowInCpt0, 0);
    _selectRowInCpt0 = MIN(_selectRowInCpt0, rows.count-1);
}
- (void)setSelectRowInCpt2:(NSInteger)selectRowInCpt2{
    if(!_sections || _sections.count<=0){
        _selectRowInCpt2 = 0;
    }
    NSArray *rows = _sections[2];
    _selectRowInCpt2 = MAX(selectRowInCpt2, 0);
    _selectRowInCpt2 = MIN(_selectRowInCpt2, rows.count-1);
}
- (void)autoLinkCpt:(NSInteger *)autoCpt autoIndex:(NSInteger*)autoIndex whenSelectAtCpt:(NSInteger)cpt index:(NSInteger)index{
    if(index<0 || cpt<0){
        return;
    }
    if(cpt==0){
        *autoCpt = 2;
        *autoIndex = MAX(*autoIndex, index);
        self.selectRowInCpt0 = index;
        self.selectRowInCpt2 = *autoIndex;
        return;
    }
    if(cpt==2){
        *autoCpt = 0;
        *autoIndex = MIN(*autoIndex, index);
        self.selectRowInCpt2 = index;
        self.selectRowInCpt0 = *autoIndex;
        return;
    }
    *autoCpt = -1;
    *autoIndex = -1;
}
@end

#define PICKER_HEIGHT 265
#define Btn_width 30
@interface MVPTimePicker ()<UIPickerViewDelegate,UIPickerViewDataSource,JarvisViewDelegate>
{
    NSInteger _selectCpt;
    NSInteger _selectRow;
}
@property (nonatomic, strong) UIView *lightBackView;
@property (nonatomic, strong) UIView *pickerView;
@property (nonatomic, strong) UIPickerView *timePicker;
@property (nonatomic, weak) UIView *baseView;
@end
@implementation MVPTimePicker

- (void)dealloc{
    
}
- (UIPickerView *)timePicker{
    if(!_timePicker){
        _timePicker  = [[UIPickerView alloc] init];
        _timePicker.showsSelectionIndicator = YES;
        _timePicker.delegate = self;
        _timePicker.dataSource = self;
        _timePicker.showsSelectionIndicator = YES;

    }
    return _timePicker;
}
- (void)setPresenter:(MVPTimePickerPresenter *)presenter{
    _presenter = presenter;
    [_presenter attachViewDelegate:self];
}

- (void)initialize{
    self.lightBackView = [UIView new];
    _lightBackView.backgroundColor = [UIColor colorWithWhite:.0 alpha:.2];
    _lightBackView.alpha = .0f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap:)];
    [_lightBackView addGestureRecognizer:tap];
    _lightBackView.userInteractionEnabled = YES;
    [self addSubview:_lightBackView];
    
    self.pickerView = [UIView new];
    _pickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickerView];
    [_pickerView setFrame:CGRectMake(0,self.frame.size.height-PICKER_HEIGHT,[[UIScreen mainScreen] bounds].size.width,PICKER_HEIGHT)];
    
    [_pickerView addSubview:self.timePicker];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    doneBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [doneBtn setTitleColor:[UIColor colorWithRed:32/255.0 green:165/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneCheck:) forControlEvents:UIControlEventTouchUpInside];
    [_pickerView addSubview:doneBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    cancelBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [cancelBtn setTitleColor:[UIColor colorWithRed:101/255.0 green:119/255.0 blue:134/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_pickerView addSubview:cancelBtn];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
    [_pickerView addSubview:lineView];
    
    [doneBtn setFrame:CGRectMake(15, 0, Btn_width, 50)];
    [cancelBtn setFrame:CGRectMake(_pickerView.frame.size.width-Btn_width-15, 0, Btn_width, 50)];
    NSLog(@"%f",_pickerView.frame.size.width);
    [lineView setFrame:CGRectMake(0, 50, _pickerView.frame.size.width, 0.5)];
    [self.timePicker setFrame:CGRectMake(0, 50, _pickerView.frame.size.width, _pickerView.frame.size.height-50)];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (instancetype)initWithPresenter:(id)presenter{
    self = [super init];
    if (self) {
        [self initialize];
        self.presenter = presenter;
    }
    return self;
}
- (void)showInView:(UIView *)baseView{
    if(self.superview){
        return;
    }
    self.baseView = baseView;
    [baseView addSubview:self];
    [self setFrame:baseView.frame];
    [self initShowCons];
    [self layoutIfNeeded];
    
    
    [self resetData];
    [self.timePicker selectRow:self.presenter.selectRowInCpt0 inComponent:0 animated:YES];
    [self.timePicker selectRow:self.presenter.selectRowInCpt2 inComponent:2 animated:YES];
    [self.timePicker reloadAllComponents];
    
    [self showCons];

}
- (void)hidePicker{
    [self hideCons];
    
    if (_selectionBlock) {
        _selectionBlock(0,nil);
    }
}
#pragma mark ======  picker delegate  ======
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.presenter.sections.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *rows = self.presenter.sections[component];
    return rows.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if(self.presenter.sections.count>0){
        return [[UIScreen mainScreen] bounds].size.width/self.presenter.sections.count;
    }
    return [[UIScreen mainScreen] bounds].size.width/3.0;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44.0f;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *rows = self.presenter.sections[component];
    NSString *title = rows[row];
    return title;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    UILabel *pLB = nil;
    if(view){
        pLB = [view viewWithTag:100];
    }else{
        UIView *pView = [UIView new];
        CGSize rowSize = [pickerView rowSizeForComponent:component];
        pView.frame = CGRectMake(0, 0, rowSize.width, rowSize.height);
        pLB = [[UILabel alloc]initWithFrame:pView.bounds];
        pLB.tag = 100;
        pLB.textAlignment = NSTextAlignmentCenter;
        pLB.font = [UIFont systemFontOfSize:18];
        pLB.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [pView addSubview:pLB];
        pLB.backgroundColor = [UIColor clearColor];
        view = pView;
        pView.backgroundColor = [UIColor clearColor];
    }
    NSArray *rows = self.presenter.sections[component];
    NSString *title = rows[row];
    pLB.text = title;
    [self clearSpearatorLine];
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectRow = row;
    _selectCpt = component;
    
    
    NSInteger autoCpt = -1;
    NSInteger anotherCpt = _selectCpt==0 ? 2:0;
    NSInteger autoRow = [pickerView selectedRowInComponent:anotherCpt];
    [self.presenter autoLinkCpt:&autoCpt autoIndex:&autoRow whenSelectAtCpt:_selectCpt index:_selectRow];
    if(autoCpt==-1 || autoRow==-1){
        return;
    }
    [pickerView selectRow:autoRow inComponent:autoCpt animated:YES];
}

#pragma mark ======  action  ======
- (void)backTap:(UITapGestureRecognizer *)tap{
    [self hidePicker];
}
- (void)doneCheck:(UIButton *)btn{
    [self hideCons];
    //selectionBlock
    if (_selectionBlock) {
        NSDictionary *result = @{@"startIndex":@(_presenter.selectRowInCpt0),@"endIndex":@(_presenter.selectRowInCpt2)};
        _selectionBlock(1,result);
    }
}
- (void)dismissBtn:(UIButton *)btn{
    [self hidePicker];
}
#pragma mark ======  private  ======
- (void)initShowCons{
    
    [self.lightBackView setFrame:self.frame];
    _lightBackView.alpha = .0f;
    [self.pickerView setFrame:CGRectMake(0, self.frame.size.height-PICKER_HEIGHT, [[UIScreen mainScreen] bounds].size.width, PICKER_HEIGHT)];
    
}
- (void)showCons{
    [self.pickerView setFrame:CGRectMake(0, self.frame.size.height-PICKER_HEIGHT, [[UIScreen mainScreen] bounds].size.width, PICKER_HEIGHT)];
    [UIView animateWithDuration:.4 animations:^{
        self.lightBackView.alpha = 1.0f;
        [self layoutIfNeeded];
    }];
}
- (void)hideCons{
    [self.pickerView setFrame:CGRectMake(0, self.frame.size.height, [[UIScreen mainScreen] bounds].size.width, PICKER_HEIGHT)];
    [UIView animateWithDuration:.4 animations:^{
        self.lightBackView.alpha = .0f;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)resetData{
    _selectCpt = -1;
    _selectRow = -1;
}
- (void)clearSpearatorLine
{
    [self.timePicker.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height < 1 && obj.tag!=1000)
        {
            [obj setBackgroundColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1]];
        }
    }];
}
@end
