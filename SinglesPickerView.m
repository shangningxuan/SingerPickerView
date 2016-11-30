//
//  SinglePickerView.m
//  BFMClientProject
//
//  Created by OceanWang on 16/5/7.
//  Copyright © 2016年 hexingang. All rights reserved.
//

#import "SinglePickerView.h"

@implementation SinglePickerView

{
    UIView *backBlackView;
    UIView *dataPickerBackView;
    UIPickerView *_pickerView;
    NSArray *contentArr;
   
}
- (instancetype)initWithContensArr:(NSArray *)contenArrIn
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        contentArr = contenArrIn;
        [self initViewContianer];
    }
    return self;
}

-(void)initViewContianer{
    backBlackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backBlackView.backgroundColor = [UIColor blackColor];
    backBlackView.alpha = 0.5f;
    backBlackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:backBlackView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backBlackView]|" options:0 metrics:@{} views:@{@"backBlackView":backBlackView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backBlackView]|" options:0 metrics:@{} views:@{@"backBlackView":backBlackView}]];
    
    dataPickerBackView = UIView.new;
    dataPickerBackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:dataPickerBackView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dataPickerBackView]|" options:0 metrics:@{} views:@{@"dataPickerBackView":dataPickerBackView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[dataPickerBackView]|" options:0 metrics:@{} views:@{@"dataPickerBackView":dataPickerBackView}]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerBackView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:259]];
    
    
    UIView *barView = UIView.new;
    barView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    barView.translatesAutoresizingMaskIntoConstraints = NO;
    [dataPickerBackView addSubview:barView];
    [dataPickerBackView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[barView]|" options:0 metrics:@{} views:@{@"barView":barView}]];
    [dataPickerBackView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[barView(44)]" options:0 metrics:@{} views:@{@"barView":barView}]];
    
    //取消按钮
    UIButton *cancelBtn = UIButton.new;
    cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    //确定按钮
    UIButton *OKBtn = UIButton.new;
    OKBtn.translatesAutoresizingMaskIntoConstraints = NO;
    cancelBtn.titleLabel.font  = [UIFont systemFontOfSize:14];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cancelBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    OKBtn.titleLabel.font  = [UIFont systemFontOfSize:14];
    OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    OKBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [OKBtn setTitle:@"确定" forState:UIControlStateNormal];
    [OKBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:160/255.0 blue:233/255.0 alpha:1.0] forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(OKAction:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:cancelBtn];
    [barView addSubview:OKBtn];
    [barView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cancelBtn(60)]" options:0 metrics:@{} views:@{@"cancelBtn":cancelBtn}]];
    [barView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cancelBtn]|" options:0 metrics:@{} views:@{@"cancelBtn":cancelBtn}]];
    [barView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[OKBtn(60)]|" options:0 metrics:@{} views:@{@"OKBtn":OKBtn}]];
    [barView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[OKBtn]|" options:0 metrics:@{} views:@{@"OKBtn":OKBtn}]];
    
    UIView *pickerBakView = UIView.new;
    pickerBakView.backgroundColor = [UIColor whiteColor];
    pickerBakView.translatesAutoresizingMaskIntoConstraints = NO;
    [dataPickerBackView addSubview:pickerBakView];
    [dataPickerBackView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pickerBakView]|" options:0 metrics:@{} views:@{@"pickerBakView":pickerBakView}]];
    [dataPickerBackView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[barView][pickerBakView]|" options:0 metrics:@{} views:@{@"barView":barView,@"pickerBakView":pickerBakView}]];
    
    _pickerView = UIPickerView.new;
    _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [pickerBakView addSubview:_pickerView];
    [pickerBakView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_pickerView]|" options:0 metrics:@{} views:@{@"_pickerView":_pickerView}]];
    [pickerBakView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_pickerView]|" options:0 metrics:@{} views:@{@"_pickerView":_pickerView}]];
}

-(void)cancelAction:(UIButton *)btn{
    [self close];
}

-(void)OKAction:(UIButton *)btn{
    if(_singlePickSelectRow)
    {
        _singlePickSelectRow( [_pickerView selectedRowInComponent:0] , contentArr[[_pickerView selectedRowInComponent:0]]);
    }
    [self close];
}

-(void)show{
    UIWindow *window = ((AppDelegate *) [UIApplication sharedApplication].delegate).window;
    backBlackView.alpha = 0.5f;
    [window addSubview:self];
}
-(void)close{
    //    [UIView animateWithDuration:0.3f animations:^{
    //        [dataPickerBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.leading.equalTo(self.mas_leading);
    //            make.trailing.equalTo(self.mas_trailing);
    //            make.height.equalTo(@259);
    //            make.top.equalTo(self.mas_bottom);
    //            //            make.bottom.equalTo(self.mas_bottom);
    //        }];
    //        [self layoutIfNeeded];
    //    } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:0.3f animations:^{
    //            backBlackView.alpha = 0.0f;
    //        } completion:^(BOOL finished) {
    [self removeFromSuperview];
    //        }];
    //    }];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self close];
}
#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}
#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
    return contentArr.count;
}
#pragma mark - 该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  [contentArr objectAtIndex:row];
}
@end
