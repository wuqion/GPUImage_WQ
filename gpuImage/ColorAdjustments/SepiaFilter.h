//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//简单的棕褐色调滤波器
//
//强度：棕褐色调替换正常图像颜色的程度（0.0 - 1.0，默认值为1.0）
@interface SepiaFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageSepiaFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
