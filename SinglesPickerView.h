//
//  SinglePickerView.h
//  BFMClientProject
//
//  Created by OceanWang on 16/5/7.
//  Copyright © 2016年 hexingang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SinglePickerSelectRow) (NSInteger row,NSString *rowText);


@interface SinglePickerView : UIView<UIPickerViewDataSource , UIPickerViewDelegate>

- (instancetype)initWithContensArr:(NSArray *)contenArrIn;
@property (readwrite, nonatomic, copy) SinglePickerSelectRow singlePickSelectRow;
-(void)show;


@end
