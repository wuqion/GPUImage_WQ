//
//  BrightnessFilter.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "WhiteBalanceFilter.h"

@implementation WhiteBalanceFilter

- (void)setImageV:(UIImageView *)imageV
{
    [super setImageV:imageV];
    
    _filter = [[GPUImageWhiteBalanceFilter alloc]init];
    _picture = [[GPUImagePicture alloc]initWithImage:imageV.image];
    [_picture addTarget:_filter];
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    imageV.image = [_filter imageFromCurrentFramebuffer];
    self.slider1.maximumValue = 7000;
    self.slider1.minimumValue = 4000;
    self.slider1.value = 5000.0;
    
    self.slider3.maximumValue = 200;
    self.slider3.minimumValue = -200;
    self.slider3.value = 0;
    
    self.slider2.hidden = YES;
}
- (void)valueChanged:(UISlider *)slider{
    if (self.slider1 == slider) {
        _filter.temperature = slider.value;
    }
    if (self.slider3 == slider) {
        _filter.tint = slider.value;
    }
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    self.imageV.image = [_filter imageFromCurrentFramebuffer];
    
}
@end
