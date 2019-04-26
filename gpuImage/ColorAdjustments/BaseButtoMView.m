//
//  BaseButtoMView.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/4.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "BaseButtoMView.h"

@implementation BaseButtoMView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    _slider1 = [[UISlider alloc]initWithFrame:CGRectMake(20, 0, self.bounds.size.width-40, 40)];
    [_slider1 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    _slider1.maximumValue = 1.0;
    _slider1.minimumValue = 0;
    [self addSubview:_slider1];
    _slider1.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - 60);
    
    _slider2 = [[UISlider alloc]initWithFrame:CGRectMake(20, 0, self.bounds.size.width-40, 40)];
    [_slider2 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    _slider2.maximumValue = 1.0;
    _slider2.minimumValue = 0;
    [self addSubview:_slider2];
    _slider2.center = self.center;
    
    _slider3 = [[UISlider alloc]initWithFrame:CGRectMake(20, 0, self.bounds.size.width-40, 40)];
    [_slider3 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    _slider3.maximumValue = 1.0;
    _slider3.minimumValue = 0;
    [self addSubview:_slider3];
    _slider3.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + 60);
}
- (void)valueChanged:(UISlider *)slider{
    NSLog(@"没有实现这个滤镜");
}
@end
