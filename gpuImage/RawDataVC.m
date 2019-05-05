//
//  RawDataVC.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/5/5.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "RawDataVC.h"
#import <GPUImage.h>

@interface RawDataVC ()


@property (strong, nonatomic) GPUImageView *filterView;
@property (strong, nonatomic) UIImageView  *mImageView;
@property (strong, nonatomic) UILabel      *mLabel;


@property (strong, nonatomic) GPUImageRawDataOutput *mOutput;




@end

@implementation RawDataVC
{
    GPUImageVideoCamera *videoCamera;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    GPUImageView *filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = filterView;
    
    self.mImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mImageView];
    
    self.mLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 100)];
    self.mLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.mLabel];
    
    //初始化摄像头
    videoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:(AVCaptureDevicePositionFront)];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    //
    self.mOutput = [[GPUImageRawDataOutput alloc]initWithImageSize:CGSizeMake(640, 480) resultsInBGRAFormat:YES];
    
    [videoCamera addTarget:_mOutput];
    
    __weak typeof(self) wself = self;
    __weak typeof(self.mOutput) weakOutput = self.mOutput;
    
    [_mOutput setNewFrameAvailableBlock:^{
        NSLog(@"----");

        __strong GPUImageRawDataOutput *strongOutput = weakOutput;
        __strong typeof(wself) strongSelf = wself;
        
        [strongOutput lockFramebufferForReading];
        GLubyte *outputBytes = [strongOutput rawBytesForImage];
        NSInteger bytesPerRow = [strongOutput bytesPerRowInOutput];
        CVPixelBufferRef pixelBuffer = NULL;
        CVReturn ret = CVPixelBufferCreateWithBytes(kCFAllocatorDefault, 640, 480, kCVPixelFormatType_32BGRA, outputBytes, bytesPerRow, nil, nil, nil, &pixelBuffer);
        if (ret != kCVReturnSuccess) {
            NSLog(@"status %d", ret);
        }

        [strongOutput unlockFramebufferAfterReading];
        if (pixelBuffer == NULL) {
            return ;
        }
        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, strongOutput.rawBytesForImage, bytesPerRow * 480, NULL);
        
        CGImageRef cgImage = CGImageCreate(640, 480, 8, 32, bytesPerRow, rgbColorSpace, kCGImageAlphaPremultipliedFirst|kCGBitmapByteOrder32Little, provider, NULL, true, kCGRenderingIntentDefault);
        
        UIImage * image = [UIImage imageWithCGImage:cgImage];
        [strongSelf updataWithImage:image];
        
        CGImageRelease(cgImage);
//        CFRelease(pixelBuffer);
    }];
    [videoCamera startCameraCapture];
    CADisplayLink * dlink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
    [dlink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [dlink setPaused:NO];

}
- (void)updateProgress
{
    self.mLabel.text = [[NSDate dateWithTimeIntervalSinceNow:0] description];
    [self.mLabel sizeToFit];
}
- (void)updataWithImage:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mImageView.image = image;
    });
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [videoCamera stopCameraCapture];
}

@end
