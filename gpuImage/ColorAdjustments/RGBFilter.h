//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整图像的各个RGB通道
//
//红色：每个颜色通道乘以的标准化值。范围从0.0开始，默认值为1.0。
//绿色：
//蓝色
@interface RGBFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageRGBFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
