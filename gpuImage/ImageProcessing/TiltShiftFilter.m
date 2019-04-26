//
//  TiltShiftFilter.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "TiltShiftFilter.h"

@implementation TiltShiftFilter

- (void)setImageV:(UIImageView *)imageV
{
    [super setImageV:imageV];
    
    _filter = [[GPUImageTiltShiftFilter alloc]init];
    _picture = [[GPUImagePicture alloc]initWithImage:imageV.image];
    [_picture addTarget:_filter];
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    imageV.image = [_filter imageFromCurrentFramebuffer];
    
    self.slider1.minimumValue = 0;
    self.slider1.maximumValue = 100.0;
    self.slider1.value = 0;
    
    self.slider2.minimumValue = 0;
    self.slider2.maximumValue = 1.0;
    self.slider2.value = 0.4;
    
    self.slider3.minimumValue = 0;
    self.slider3.maximumValue = 1.0;
    self.slider3.value = .2;
}
- (void)valueChanged:(UISlider *)slider{
    if (slider == self.slider1) {
        _filter.blurRadiusInPixels = slider.value;
    }
    if (slider == self.slider2) {
        _filter.topFocusLevel = slider.value;
    }
    if (slider == self.slider3) {
        _filter.focusFallOffRate = slider.value;
    }
    [_filter useNextFrameForImageCapture];
    [_picture processImage];
    self.imageV.image = [_filter imageFromCurrentFramebuffer];
    
}

@end
