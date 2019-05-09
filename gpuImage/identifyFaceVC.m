//
//  identifyFaceVC.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/5/6.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "identifyFaceVC.h"
#import <CoreImage/CoreImage.h>
@interface identifyFaceVC ()

@property (strong, nonatomic) NSMutableDictionary  * featureValues;
@property (strong, nonatomic) NSMutableArray       * values;
@property (copy, nonatomic) void(^cehi)();

@end

@implementation identifyFaceVC
{
    UIImageView * view;
    UILabel     * label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController  .navigationBar.backgroundColor = [UIColor clearColor];
    
    view = [[UIImageView alloc]initWithFrame:self.view.bounds];
    UIImage * image =[UIImage imageNamed:@"99.jpg"];
    view.image = image;
    [self.view addSubview:view];
    [view sizeToFit];
    view.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    
    label = [[UILabel alloc]init];
    label.text = @"提示提示提示提示";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:20];
    label.center = self.view.center;
    [self.view addSubview:label];
    [label sizeToFit];
    
    CIImage * cimage = [CIImage imageWithCGImage:image.CGImage];
    //创建探测针
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:@{}];
    //返回特征
    NSArray<CIFeature *> * features= [faceDetector featuresInImage:cimage];
    for (int i = 0; i < features.count; i++) {
        if (features[i].type == CIFeatureTypeFace) {
            CIFaceFeature * feature = (CIFaceFeature *)features[i];
             NSDictionary * dic = [feature valueForKey:@"landmarks"];
            if (dic) {
                self.featureValues = dic.mutableCopy;
                self.values = [self.featureValues allKeys].mutableCopy;
                NSLog(@"%@",self.values);
                NSLog(@"%@",self.featureValues);
                [self medianLine];
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int num = 0;
    num ++;
    NSString * string = self.values[num % self.values.count];
    if ([self respondsToSelector:NSSelectorFromString(string)]) {
        [self performSelector:NSSelectorFromString(string)];
    }
    
}
- (void) rightEye
{
    label.text = @"右眼";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"rightEye"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) outerLips
{
    label.text = @"外嘴唇";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"outerLips"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) leftEyebrow
{
    
    label.text = @"左眼眉毛";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"leftEyebrow"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) innerLips
{
    label.text = @"内嘴唇";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"innerLips"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) faceContour
{
    label.text = @"面部轮廓";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"faceContour"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) leftEye
{
    label.text = @"左眼";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"leftEye"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) leftPupil
{
    label.text = @"左眼角";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"leftPupil"];
        CGPoint point = [arr[0] CGPointValue];
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
        
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x+10, point.y);
        
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) nose
{
    label.text = @"鼻子";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"nose"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) medianLine
{
    label.text = @"中间线";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"medianLine"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];

}
- (void) rightEyebrow
{
    label.text = @"右眉";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"rightEyebrow"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) noseCrest
{
    label.text = @"鼻嵴";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"noseCrest"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            }
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            //                    NSLog(@"%@",point);
        }
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) rightPupil
{
    label.text = @"右眼角";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"rightPupil"];
        CGPoint point = [arr[0] CGPointValue];
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
        
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), point.x+10, point.y);
        
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}
- (void) allPoints
{
    label.text = @"全部点";
    [self baseFuncation:^{
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        NSArray * arr = self.featureValues[@"allPoints"];
        for (int j = 0; j < arr.count; j++) {
            CGPoint point = [arr[j] CGPointValue];
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);
            CGContextAddArc(UIGraphicsGetCurrentContext(), point.x, point.y, 3, 0, M_PI *2, 0);
        }
        
        CGContextStrokePath(UIGraphicsGetCurrentContext()); //画线
    }];
}

//基础
- (void)baseFuncation:(void(^)())draw
{

    UIGraphicsBeginImageContext(view.bounds.size);
//                    [image drawInRect:view.bounds];
    [self deal];
    if(draw){
        draw();
    }
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = [UIImage imageWithCIImage:[CIImage imageWithCGImage:image.CGImage] scale:image.scale orientation:(UIImageOrientationUpMirrored)];
    view.image = image;
}
//旋转坐标系统
- (void)deal
{
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), view.frame.size.width/2, view.frame.size.height/2);
    CGContextRotateCTM(UIGraphicsGetCurrentContext(), M_PI);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -view.frame.size.width/2,-view.frame.size.height/2);
    //画图片
    UIImage * image = [UIImage imageNamed:@"99.jpg"];
    CGContextDrawImage(UIGraphicsGetCurrentContext(), view.bounds, image.CGImage);

}

@end
//all Points
//face Contour
//inner Lips
//left Eye
//left Eyebrow
//left Pupil
//median Line
//nose
//nose Crest
//outer Lips
//right Eye
//right Eyebrow
//right Pupil
