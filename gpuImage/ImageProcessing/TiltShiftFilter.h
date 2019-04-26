//
//  TiltShiftFilter.h
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

NS_ASSUME_NONNULL_BEGIN
//调整图像的亮度
//
//亮度：调整后的亮度（-1.0 - 1.0，默认值为0.0）
@interface TiltShiftFilter : BaseButtoMView

@property (strong, nonatomic) GPUImageTiltShiftFilter * filter;
@property (strong, nonatomic) GPUImagePicture * picture;

@end

NS_ASSUME_NONNULL_END
