//
//  BrightnessFilter.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "RGBFilter.h"

@implementation RGBFilter

- (void)setImageV:(UIImageView *)imageV
{
    [super setImageV:imageV];
    
    _filter = [[GPUImageRGBFilter alloc]init];
    _picture = [[GPUImagePicture alloc]initWithImage:imageV.image];
    [_picture addTarget:_filter];
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    imageV.image = [_filter imageFromCurrentFramebuffer];
    self.slider1.maximumValue = 1.0;
    self.slider1.minimumValue = 0;
    
    self.slider2.maximumValue = 1.0;
    self.slider2.minimumValue = 0;
    
    self.slider3.maximumValue = 1.0;
    self.slider3.minimumValue = 0;
    
    self.slider1.value = 1.0;
    self.slider2.value = 1.0;
    self.slider3.value = 1.0;
}
- (void)valueChanged:(UISlider *)slider{
    if (self.slider1 == slider) {
        _filter.red = slider.value;
    };
    if (self.slider2 == slider) {
        _filter.green = slider.value;
    };
    if (self.slider3 == slider) {
        _filter.blue = slider.value;
    };
    
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    self.imageV.image = [_filter imageFromCurrentFramebuffer];
    
}
@end
