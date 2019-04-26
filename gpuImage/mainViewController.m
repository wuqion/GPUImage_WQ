
//  mainViewController.m
//  ceshi
//
//  Created by 联创—王增辉 on 2019/1/8.
//  Copyright © 2019年 lcWorld. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define TabBar_Height 49.0
#define Nav_StatusBar_Height [UIApplication sharedApplication].statusBarFrame.size.height
#define SEPARATELINE_COLOR [UIColor redColor]

#import "mainViewController.h"
#import "tupianViewController.h"//处理图片
#import "sheixiangtouViewController.h"//摄像头加滤镜
#import "StillCameraVC.h"//拍照加滤镜
#import "MovieWriterVC.h"//视频转码
#import "FilterGroupVC.h"//组合滤镜
#import "RecordingViewController.h"//录制视频


@interface mainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *soures;


@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
    [self setViewFrame];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addUI{
    [self.view addSubview:self.tableView];
}
- (void)setViewFrame
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.soures.count;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.soures[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[tupianViewController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[sheixiangtouViewController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[StillCameraVC new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[MovieWriterVC new] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[FilterGroupVC new] animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:[RecordingViewController new] animated:YES];
            break;
            
        default:
            
            break;
    }
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav_StatusBar_Height, ScreenWidth, ScreenHeight - Nav_StatusBar_Height - TabBar_Height) style:UITableViewStylePlain];
        _tableView.separatorColor = SEPARATELINE_COLOR;
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
        _soures = [NSMutableArray new];
        [_soures addObject:@"GPUImage给图片加滤镜"];
        [_soures addObject:@"GPUImage给摄像头加滤镜"];
        [_soures addObject:@"(拍照)捕获和过滤静态照片"];
        [_soures addObject:@"视频加滤镜"];
        [_soures addObject:@"组合滤镜"];
        [_soures addObject:@"录制视频"];
        
    }
    return _soures;
}

@end

