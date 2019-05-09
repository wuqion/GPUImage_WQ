//
//  faceVC.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/5/6.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "faceVC.h"
#import <GPUImage.h>


@interface faceVC ()<GPUImageVideoCameraDelegate>

@property (strong, nonatomic) GPUImageVideoCamera *videoCamera;
@property (strong, nonatomic) GPUImageView        *imageView;
@property (strong, nonatomic) UIImageView         *decoration;
@property (strong, nonatomic) GPUImageUIElement * element;


@end

@implementation faceVC
{
    CGPoint point;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    UIView * bgView = [[UIView alloc]initWithFrame:self.view.bounds];

    _decoration = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 20, 20)];
    _decoration.image = [UIImage imageNamed:@"99.jpg"];
    _decoration.contentMode = UIViewContentModeScaleAspectFit;
    _decoration.backgroundColor = [UIColor redColor];
    [bgView addSubview:_decoration];
    
    _videoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:(AVCaptureDevicePositionFront)];
    _videoCamera.delegate = self;
    _videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    GPUImageAddBlendFilter * blendFilter = [[GPUImageAddBlendFilter alloc]init];
    
    GPUImageFilter * filter = [[GPUImageFilter alloc]init];
    [_videoCamera addTarget:filter];
    
    self.element = [[GPUImageUIElement alloc]initWithView:bgView];
    
    [self.element addTarget:blendFilter];
    [filter  addTarget:blendFilter];

    [blendFilter addTarget:_imageView];
    
    [_videoCamera startCameraCapture];

//
    [filter setFrameProcessingCompletionBlock:^(GPUImageOutput *ImageOutput, CMTime time) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //修正坐标,设备的坐标原点在左上角,ciimage的坐标在左下角
            self->_decoration.center = CGPointMake(self->point.x/2, self.view.bounds.size.height-(self->point.y )/2);
        });
        [self->_element updateWithTimestamp:time];
    }];

}
//GPUImageVideoCameraDelegate
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    [self performSelectorInBackground:@selector(MYwillOutputSampleBuffer:) withObject:(__bridge id _Nullable)(sampleBuffer)];
    
   
}
- (void)MYwillOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    //获取灰度图像数据
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    uint8_t *lumaBuffer  = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    
    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer,0);
    size_t width  = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    
    CGColorSpaceRef grayColorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context=CGBitmapContextCreate(lumaBuffer, width, height, 8, bytesPerRow, grayColorSpace,0);
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    
    if (cgImage == nil) {
        return;
    }

//    CIImage *wImage = [ciimage imageByApplyingCGOrientation:kCGImagePropertyOrientationLeft];

    CIImage * cimage = [CIImage imageWithCGImage:cgImage];
    cimage = [cimage imageByApplyingCGOrientation:kCGImagePropertyOrientationLeftMirrored];
    
    UIImage * imaged = [UIImage imageWithCIImage:cimage];
    self.decoration.image = imaged;
    
    
    //这个一定要设置低识别,不然巨卡
    NSDictionary *opts = @{ CIDetectorAccuracy : CIDetectorAccuracyLow };      // 2

    //创建探测针
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:opts];
        //返回特征
    NSDictionary * imageOptions =[NSDictionary dictionaryWithObject:@(kCGImagePropertyOrientationUp) forKey:CIDetectorImageOrientation];

        NSArray<CIFeature *> * features= [faceDetector featuresInImage:cimage options:imageOptions];
        for (int i = 0; i < features.count; i++) {
            NSLog(@"----");

            if (features[i].type == CIFeatureTypeFace) {
                CIFaceFeature * feature = (CIFaceFeature *)features[i];
                if (feature.hasLeftEyePosition) {
                    self->point = CGPointMake(ceil(feature.leftEyePosition.x), ceil(feature.leftEyePosition.y));
                    NSLog(@"%@",NSStringFromCGPoint(self->point));
                }else{
                    self->point = CGPointMake(0, 0);
                }
//                NSDictionary * dic = [feature valueForKey:@"landmarks"];
//                if (dic) {
//                    NSArray * arr = dic[@"rightEye"];
//                    self->point = [arr[0] CGPointValue];
//                }
            }
        }
    
    CGImageRelease(cgImage);
    CGContextRelease(context);
    CGColorSpaceRelease(grayColorSpace);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_videoCamera stopCameraCapture];
}
@end
