//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGJsonController.h"
@interface YZGJsonController ()
@property (strong, nonatomic) UIImageView *imgView;

@end

@implementation YZGJsonController

#pragma mark ************** 懒加载控件

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"新建/编辑收货地址";
    self.view.backgroundColor = RGB(235, 235, 241);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self selectPath];
    
    [self getData];
}
- (void)selectPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSLog(@"------------------%@",plistPath1);  //得到完整的路径名
}
#pragma mark ************** 获取数据
- (void)getData
{
    NSString *url = @"http://app.95e.com/vm/getCategories2.aspx";
    
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
     [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    [[SVHTTPClient sharedClient] GET:url parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
           
        }
        else
        {
            
            NSDictionary *dic = JSON_TO_DICT(response);
            [self saveData:dic];
           
            
        }
    }];
    
 
}
- (void)saveData:(NSDictionary *)dic
{
    NSDictionary *cityDic = @{ @"data":dic[@"data"]};
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"------------------%@",plistPath1);  //得到完整的路径名
    
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"footData.plist"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES)
    {
        
        [cityDic writeToFile:fileName atomically:YES];
        
        NSLog(@"文件写入完成");
    }
     NSLog(@"------------------%@",dic[@"data"]);

}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    
    self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, SCREEN_WIDTH/2.0, SCREEN_WIDTH/2.0)];
    self.imgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_imgView];
  

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
}
@end
