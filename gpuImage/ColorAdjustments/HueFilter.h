//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整图像的色调
//
//色调：色调角度，以度为单位。默认为90度
@interface HueFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageHueFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
