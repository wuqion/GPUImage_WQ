//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整传入图像的Alpha通道
//
//不透明度：将每个像素的传入Alpha通道乘以（0.0 - 1.0，默认值为1.0）的值
@interface OpacityFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageOpacityFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
