//
//  BrightnessFilter.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "GammaFilter.h"

@implementation GammaFilter

- (void)setImageV:(UIImageView *)imageV
{
    [super setImageV:imageV];
    
    _filter = [[GPUImageGammaFilter alloc]init];
    _picture = [[GPUImagePicture alloc]initWithImage:imageV.image];
    [_picture addTarget:_filter];
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    imageV.image = [_filter imageFromCurrentFramebuffer];
    self.slider2.maximumValue = 3.0;
    self.slider2.minimumValue = 0;
    self.slider2.value = 1.0;
    self.slider1.hidden = YES;
    self.slider3.hidden = YES;
}
- (void)valueChanged:(UISlider *)slider{
    _filter.gamma = slider.value;
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    self.imageV.image = [_filter imageFromCurrentFramebuffer];
    
}
@end
