//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//亮度高于阈值的像素将显示为白色，下面的像素将显示为黑色
//
//阈值：亮度阈值，从0.0到1.0，默认值为0.5
@interface LuminanceThresholdFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageLuminanceThresholdFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
