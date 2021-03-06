//
//  FilterGroupVC.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/25.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "FilterGroupVC.h"
#import <GPUImage.h>
@interface FilterGroupVC ()

@end

@implementation FilterGroupVC
{
    GPUImageVideoCamera * videoCamera;
    GPUImageView * imageView;
    BOOL isFilter;//是否添加滤镜
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    imageView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    //初始化摄像头
    videoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    //设置手机垂直方向///横向.纵向
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    //1.建立滤镜


    
    GPUImageFilterGroup * filterGroup = [[GPUImageFilterGroup alloc]init];

    GPUImageBrightnessFilter * filter = [[GPUImageBrightnessFilter alloc]init];
    filter.brightness = .1;
    [filterGroup addFilter:filter];

    GPUImagePixellateFilter *  PixellateFilter = [[GPUImagePixellateFilter alloc]init];
    [filterGroup addFilter:PixellateFilter];
    [filter addTarget:PixellateFilter];
    
    filterGroup.initialFilters = @[filter];
    filterGroup.terminalFilter = PixellateFilter;
    
    [videoCamera addTarget:filterGroup];
    [filterGroup addTarget:imageView];
    
    
    //2.不加h滤镜
    //    [videoCamera addTarget:imageView];
    
    [videoCamera startCameraCapture];
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    isFilter = !isFilter;
//    [videoCamera removeAllTargets];
//    if (isFilter) {
//
//        GPUImageBrightnessFilter * filter = [[GPUImageBrightnessFilter alloc]init];
//        filter.brightness = .6;
//        [videoCamera addTarget:filter];
//        [filter addTarget:imageView];
//    }else{
//        [videoCamera addTarget:imageView];
//    }
//}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [videoCamera stopCameraCapture];
    [videoCamera removeAllTargets];
    videoCamera = nil;
}

- (void)dealloc
{
    NSLog(@"结束");
}

@end
