//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整图像的曝光
//
//曝光：调整曝光（-10.0 - 10.0，默认值为0.0）
@interface ExposureFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageExposureFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
