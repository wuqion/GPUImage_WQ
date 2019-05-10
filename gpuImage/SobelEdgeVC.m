//
//  SobelEdgeVC.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/5/10.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "SobelEdgeVC.h"
#import <GPUImage.h>

@interface SobelEdgeVC ()

@property (strong, nonatomic) GPUImageVideoCamera *VideoCamere;
@property (strong, nonatomic) GPUImageView        *ImageView;

@end

@implementation SobelEdgeVC
{
    GPUImageSobelEdgeDetectionFilter * filter;
    int num;
    int numW;
    int numH;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _ImageView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_ImageView];
    
    _VideoCamere = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:(AVCaptureDevicePositionFront)];
    _VideoCamere.outputImageOrientation = UIInterfaceOrientationPortrait;
    _VideoCamere.horizontallyMirrorFrontFacingCamera = YES;
    
    
    filter = [[GPUImageSobelEdgeDetectionFilter alloc]init];
    filter.texelWidth = 2/self.view.bounds.size.width;
    filter.texelHeight = 1/self.view.bounds.size.height;
    filter.edgeStrength = 1;
    [_VideoCamere addTarget:filter];
    [filter addTarget:_ImageView];
    [_VideoCamere startCameraCapture];
    
    num = 1;
    numW = 1;
    numH = 1;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"%ld",event.allTouches.count);
    if (event.allTouches.count == 1) {
        num ++;
        filter.edgeStrength = num;
//        [_VideoCamere addTarget:filter];
    }
    if (event.allTouches.count == 2) {
        numW ++;
        filter.texelWidth = numW/self.view.bounds.size.width;
//        [_VideoCamere addTarget:filter];
    }
    if (event.allTouches.count == 3) {
        numH ++;
        filter.edgeStrength = numH;
        filter.texelWidth = numH/self.view.bounds.size.height;

//        [_VideoCamere addTarget:filter];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_VideoCamere stopCameraCapture];
    _VideoCamere = nil;
}
- (void)dealloc
{
    NSLog(@"销毁");
}
@end
