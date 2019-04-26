//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整图像的白平衡。
//
//温度：以ºK为单位调整图像的温度。值4000非常酷，7000非常温暖。默认值为5000.请注意，4000到5000之间的比例几乎与5000和7000之间的比例一样重要。
//色调：调整图像的色调。-200的值非常绿，200 非常粉红色。默认值为0。
@interface HighlightShadowFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageHighlightShadowFilter* filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
