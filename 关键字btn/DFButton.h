//
//  DFButton.h
//  关键字btn
//
//  Created by BJyhc on 2018/4/25.
//  Copyright © 2018年 com.baojian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFButton : UIControl

@property(nonatomic,strong) NSArray<NSString*> *contentArray;
+ (CGFloat)widthFromContentArray:(NSArray <NSString*>*)contentArray;
@end
