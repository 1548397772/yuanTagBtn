//
//  DFButton.m
//  关键字btn
//
//  Created by BJyhc on 2018/4/25.
//  Copyright © 2018年 com.baojian. All rights reserved.
//

#import "DFButton.h"

@interface DFButton()
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *countLabel;
@end
static CGFloat DFHeight = 32;
@implementation DFButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc]init];
        _countLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:12];
        _countLabel.font = [UIFont boldSystemFontOfSize:9];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        [self addSubview:_countLabel];
    }
    return self;
}


- (void)setContentArray:(NSArray<NSString *> *)contentArray
{
    _contentArray = contentArray;
    NSString *titleString = contentArray.firstObject;
    NSString *countString = contentArray.lastObject;
    _titleLabel.text = titleString;
    _countLabel.text = countString;
    _countLabel.textColor = [self colorFromUint:0xf4470b];
    _titleLabel.textColor = [self colorFromUint:0x74a118];
    CGFloat titleWidth = [titleString boundingRectWithSize:CGSizeMake(MAXFLOAT, 12) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} context:nil].size.width;
    CGFloat countWidth = [countString boundingRectWithSize:CGSizeMake(MAXFLOAT, 9) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:9]} context:nil].size.width;
    _titleLabel.frame = CGRectMake(10, 0, titleWidth, DFHeight);
    _countLabel.frame = CGRectMake(10 + titleWidth + 5, 0,countWidth , DFHeight);
    [self setFrame:CGRectMake(0, 0, titleWidth + countWidth + 10 + 10 + 5, DFHeight)];
    self.layer.cornerRadius = 16;
    self.clipsToBounds = YES;
}

+ (CGFloat)widthFromContentArray:(NSArray <NSString*>*)contentArray
{
    NSString *titleString = contentArray.firstObject;
    NSString *countString = contentArray.lastObject;
    CGFloat titleWidth = [titleString boundingRectWithSize:CGSizeMake(MAXFLOAT, 12) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} context:nil].size.width;
    CGFloat contentWidth = [countString boundingRectWithSize:CGSizeMake(MAXFLOAT, 9) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:9]} context:nil].size.width;
    return titleWidth + contentWidth + 10 + 10 + 5;
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.backgroundColor = [self colorFromUint:0x74a118];
        self.titleLabel.textColor = [UIColor whiteColor];
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [self colorFromUint:0x74a118];
    }
}
- (UIColor *)colorFromUint:(uint32_t)uint
{
    CGFloat red = (uint & 0xff0000)>>16;
    CGFloat green = (uint & 0x00ff00)>>8;
    CGFloat blue = (uint & 0x0000ff);
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
}
@end
