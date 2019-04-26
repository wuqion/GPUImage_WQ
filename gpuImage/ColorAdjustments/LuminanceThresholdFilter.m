//
//  BrightnessFilter.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "LuminanceThresholdFilter.h"

@implementation LuminanceThresholdFilter

- (void)setImageV:(UIImageView *)imageV
{
    [super setImageV:imageV];
    
    _filter = [[GPUImageLuminanceThresholdFilter alloc]init];
    _picture = [[GPUImagePicture alloc]initWithImage:imageV.image];
    [_picture addTarget:_filter];
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    imageV.image = [_filter imageFromCurrentFramebuffer];
    self.slider2.maximumValue = 1.0;
    self.slider2.minimumValue = 0;
    self.slider2.value = .5;
    self.slider1.hidden = YES;
    self.slider3.hidden = YES;
}
- (void)valueChanged:(UISlider *)slider{
    _filter.threshold = slider.value;
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    self.imageV.image = [_filter imageFromCurrentFramebuffer];
    
}
@end
