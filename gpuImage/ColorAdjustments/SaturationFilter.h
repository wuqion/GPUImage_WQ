//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整图像的饱和度
//
//饱和度：应用于图像的饱和度或去饱和度（0.0 - 2.0，默认值为1.0）
@interface SaturationFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageSaturationFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
