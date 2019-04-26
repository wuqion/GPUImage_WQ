//
//  BrightnessFilter.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "HighlightShadowFilter.h"

@implementation HighlightShadowFilter

- (void)setImageV:(UIImageView *)imageV
{
    [super setImageV:imageV];
    
    _filter = [[GPUImageHighlightShadowFilter alloc]init];
    _picture = [[GPUImagePicture alloc]initWithImage:imageV.image];
    [_picture addTarget:_filter];
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    self.imageV.image = [_filter imageFromCurrentFramebuffer];

    self.slider1.maximumValue = 1;
    self.slider1.minimumValue = 0;
    self.slider1.value = 1;
    
    self.slider2.maximumValue = 1;
    self.slider2.minimumValue = 0;
    self.slider2.value = 0;
    
    self.slider2.hidden = YES;
}
- (void)valueChanged:(UISlider *)slider{
    if (self.slider1 == slider) {
        _filter.shadows = slider.value;
    }
    if (self.slider3 == slider) {
        _filter.highlights = slider.value;
    }
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    self.imageV.image = [_filter imageFromCurrentFramebuffer];
    
}

@end
