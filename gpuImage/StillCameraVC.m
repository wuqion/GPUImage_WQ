//
//  StillCameraVC.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/24.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "StillCameraVC.h"
#import <GPUImage.h>

@interface StillCameraVC ()

@end

@implementation StillCameraVC
{
    GPUImageStillCamera * stillCamera;
    GPUImageGammaFilter * filter;
    UIImageView * capImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    GPUImageView * image = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:image];
    
    stillCamera = [[GPUImageStillCamera alloc]init];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    filter = [[GPUImageGammaFilter alloc]init];
    filter.gamma = 2;
    [stillCamera addTarget:filter];
    [filter addTarget:image];
    [stillCamera startCameraCapture];
   
    capImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:capImage];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [stillCamera capturePhotoAsImageProcessedUpToFilter:filter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        capImage.image = processedImage;
        NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 0.8);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSError *error2 = nil;
        if (![dataForJPEGFile writeToFile:[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"] options:NSAtomicWrite error:&error2])
        {
            return;
        }
    }];
}

@end
