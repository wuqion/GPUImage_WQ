//
//  tupianViewController.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "tupianViewController.h"
#import "BaseButtoMView.h"
#import <GPUImage.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define imgWidth  ScreenWidth*1/2
#define imgHeight imgWidth

@interface tupianViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIImageView * oldImage;
@property (strong, nonatomic) UIImageView * snewImage;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UIView      * bottomView;
@property (strong, nonatomic) NSMutableArray * soures;


@end

@implementation tupianViewController
{
    CFTimeInterval time;
}
- (void)viewDidAppear:(BOOL)animated
{
    
    NSLog(@"跳转时间:%lf",time - CACurrentMediaTime()) ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    time = CACurrentMediaTime();
    [self addUI];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)addUI{
    [self.view addSubview:self.tableView];
    [self createImage];
    
    [self clearBottomView];
}

- (void)createImage{
    self.snewImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, imgWidth, imgHeight)];
    self.snewImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.snewImage];
    
    self.oldImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.snewImage.frame), imgWidth, imgHeight)];
    self.oldImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.oldImage];
    
    self.oldImage.image = [UIImage imageNamed:@"99.jpg"];
    self.snewImage.image = [UIImage imageNamed:@"99.jpg"];
    
}
//清除下面调节按钮
- (void)clearBottomView
{
    if (self.bottomView) {
        [self.bottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }else{
        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 200, ScreenWidth, 200)];
        self.bottomView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:self.bottomView];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soures.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.soures[section][@"content"] count];
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.soures[indexPath.section][@"content"][indexPath.row][@"title"];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.soures[section][@"title"];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.snewImage.image = self.oldImage.image;
    
    [self clearBottomView];

    NSString * selector = self.soures[indexPath.section][@"content"][indexPath.row][@"function"];
    
    [self reloadBottomView:selector];
    
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(imgWidth+15, 20, ScreenWidth - imgWidth - 10, ScreenHeight - 210) style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 18, 0, 18);
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (NSMutableArray *)soures
{
    if (!_soures) {
        _soures = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"contentList" ofType:@"plist"]];
    }
    return _soures;
}
- (void)reloadBottomView:(NSString *)classString{
    Class class = NSClassFromString(classString);
    if (class) {
        BaseButtoMView * view = [[class alloc]initWithFrame:self.bottomView.bounds];
        view.imageV = self.snewImage;
        [self.bottomView addSubview:view];
    }
}

@end

