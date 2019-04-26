//
//  BrightnessFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整图像的对比度
//
//对比度：调整后的对比度（0.0 - 4.0，默认值为1.0）
@interface ContrastFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageContrastFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
