//
//  ViewController.m
//  关键字btn
//
//  Created by BJyhc on 2018/4/25.
//  Copyright © 2018年 com.baojian. All rights reserved.
//

#define screenWidth [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "DFButton.h"
@interface ViewController ()
@property(nonatomic,strong) DFButton *selectedBtn;
@property(nonatomic,strong) NSArray *contentArray;
@end

@implementation ViewController
//+ (CGFloat)widthFromContentArray:(NSArray <NSString*>*)contentArray;
- (NSArray *)contentArray
{
    if (!_contentArray) {
        _contentArray = [NSArray arrayWithObjects:@[@"你的的的",@"(+22)"],@[@"你的你的还是你的",@"(+22)"],@[@"你的你我的的的还是你的",@"(+22)"],@[@"是的哦的",@"(+22)"] ,nil];
    }
    return _contentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self colorFromUint:0xf0f0f0];
    [self test1];
//    CGFloat y = 60;
//    CGFloat x = 10;
//    CGFloat width;
//    CGFloat height = 32;
//    for (int i = 0; i < self.contentArray.count; i ++) {
//        DFButton *btn = [[DFButton alloc]init];
//        btn.contentArray = self.contentArray[i];
//        if (i == 0) {
//            [btn setSelected:YES];
//            _selectedBtn = btn;
//        }
//        width = [DFButton widthFromContentArray:self.contentArray[i]];
//        if ((x + width) > screenWidth) {
//            x = 10;
//            y = y + 32 + 10;
//        }
//        btn.frame = CGRectMake(x, y, width, height);
//        x = x + width + 10;
//        [self.view addSubview:btn];
//        [btn addTarget:self action:@selector(tapDFbtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
}

- (UIColor *)colorFromUint:(uint32_t)uint
{
    CGFloat red = (uint & 0xff0000)>>16;
    CGFloat green = (uint & 0x00ff00)>>8;
    CGFloat blue = (uint & 0x0000ff);
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
}

- (void)tapDFbtn:(DFButton *)sender
{
    _selectedBtn.selected = NO;
    sender.selected = YES;
    _selectedBtn = sender;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self test1];
}

- (void)test
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(5);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(2);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

- (void)test1
{
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    __block int count = 0;
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    
    for (int i=0; i<5; i++) {
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"%d---%d",i,i);
            count++;
            if (count==5) {
                dispatch_semaphore_signal(sem);
                count = 0;
            }
            
        }];
        
        [task resume];
    }
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

@end
