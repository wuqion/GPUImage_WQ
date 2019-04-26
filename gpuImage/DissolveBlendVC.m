//
//  DissolveBlendVC.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/26.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "DissolveBlendVC.h"
#import <GPUImage.h>
@interface DissolveBlendVC ()<GPUImageMovieWriterDelegate>

@property (strong, nonatomic) NSURL                 * navitionUrl;
@property (strong, nonatomic) GPUImageMovieWriter   * movieWriter;
@property (strong, nonatomic) GPUImageMovie         * movie;
@property (strong, nonatomic) GPUImageVideoCamera   * videoCamera;

@property (strong, nonatomic) AVPlayer      * player;
@property (strong, nonatomic) AVPlayerLayer * playerLayer;



@end

@implementation DissolveBlendVC
{
    bool isRecoding;
    GPUImageView * imageV;
    GPUImageDissolveBlendFilter * _filter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageV =[[GPUImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imageV];
    
    //初始化摄像头
    _videoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:(AVCaptureDevicePositionBack)];
    //设置显示方向
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [_videoCamera addAudioInputsAndOutputs];
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"ceshi" ofType:@"mp4"];
    NSURL * _sampleUrl = [NSURL fileURLWithPath:filePath];
    
    //加入滤镜
    _filter = [[GPUImageDissolveBlendFilter alloc]init];
    
    _movie = [[GPUImageMovie alloc]initWithURL:_sampleUrl];
    _movie.shouldRepeat = YES;
    _movie.runBenchmark = YES;
    _movie.playAtActualSpeed = YES;
    [_movie addTarget:_filter];
    
    [_videoCamera addTarget:_filter];
    
    [_filter addTarget:imageV];
//    [_videoCamera addTarget:imageV];
    [_videoCamera startCameraCapture];
    [_movie startProcessing];
    
    //初始化一个视频播放器
    _player = [[AVPlayer alloc]init];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(100, 100, 100, 100);
    _playerLayer.backgroundColor = [UIColor redColor].CGColor;
    [imageV.layer addSublayer:_playerLayer];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (isRecoding) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //这三句不能换位置.不然第二次录制就崩溃
        [_filter removeTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = nil;
        [_movieWriter finishRecording];
        
    }else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //设置录制视频的存储位置
        NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/luzhi.mp4"];
        unlink([path UTF8String]);
        
        _navitionUrl = [NSURL fileURLWithPath:path];
        unlink([path UTF8String]);
        //开始录制
        _movieWriter = [[GPUImageMovieWriter alloc]initWithMovieURL:_navitionUrl size:CGSizeMake(480.0, 640.0)];
        _movieWriter.delegate = self;
        //encodingLiveVideo影响的其实是expectsMediaDataInRealTime属性，YES时用于输入流是实时的，比如说摄像头。
        _movieWriter.encodingLiveVideo = YES;
        //将声音录制到视频文件里面
        _movieWriter.shouldPassthroughAudio = YES;
        [_filter addTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = _movieWriter;
        [_movieWriter startRecording];
    }
    isRecoding = !isRecoding;
}
- (void)movieRecordingCompleted
{
    __weak typeof(self) weakSelf = self;
    //要有个延时才能播放,0.1秒是不行的
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:weakSelf.navitionUrl];
        [weakSelf.player replaceCurrentItemWithPlayerItem:item];
        [weakSelf.player play];
    });
    
}
- (void)movieRecordingFailedWithError:(NSError*)error
{
    NSLog(@"播放错了");
}

@end
