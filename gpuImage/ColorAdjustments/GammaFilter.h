//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整图像的灰度系数
//
//gamma：要应用的伽玛调整（0.0 - 3.0，默认值为1.0）
@interface GammaFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageGammaFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
