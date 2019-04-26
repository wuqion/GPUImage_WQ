//
//  MovieWriterVC.m
//  gpuImage
//
//  Created by 联创—王增辉 on 2019/4/24.
//  Copyright © 2019年 lcWorld. All rights reserved.
//

#import "MovieWriterVC.h"
#import <GPUImage.h>
#import <AVFoundation/AVFoundation.h>
@interface MovieWriterVC ()<GPUImageMovieDelegate>

@property (strong, nonatomic) AVPlayer      * player;
@property (strong, nonatomic) AVPlayerLayer * playerLayer;
@property (strong, nonatomic) NSURL  * currentUrl;
@property (strong, nonatomic) NSURL  * sampleUrl;

@end

@implementation MovieWriterVC
{
    GPUImageMovie           * _movieFile;
    GPUImagePixellateFilter * _filter;
    GPUImageMovieWriter     * _movieWriter;
//    AVPlayer                * _player;
//    AVPlayerLayer           * _playerLayer;
//    NSURL                   * _currentUrl;
//    NSURL                   * _sampleUrl;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"ceshi" ofType:@"mp4"];
    _sampleUrl = [NSURL fileURLWithPath:filePath];

    _movieFile = [[GPUImageMovie alloc]initWithURL:_sampleUrl];
    _movieFile.delegate = self;

    _filter = [[GPUImagePixellateFilter alloc]init];
    [_movieFile addTarget:_filter];

    NSString * _currentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ccc.mp4"];

    unlink([_currentPath UTF8String]);
    _currentUrl = [NSURL fileURLWithPath:_currentPath];

    _movieWriter = [[GPUImageMovieWriter alloc]initWithMovieURL:_currentUrl size:CGSizeMake(480.0, 640.0)];
    [_filter addTarget:_movieWriter];

    _movieWriter.shouldPassthroughAudio = YES;
    _movieFile.audioEncodingTarget = _movieWriter;
    [_movieFile enableSynchronizedEncodingUsingMovieWriter:_movieWriter];
    [_movieWriter startRecording];
    [_movieFile startProcessing];

    [UIApplication sharedApplication] .networkActivityIndicatorVisible = YES;

    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:_sampleUrl];

    _player = [[AVPlayer alloc]initWithPlayerItem:item];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:_playerLayer];
    [_player play];
}

- (void)didCompletePlayingMovie
{
    [_filter removeTarget:_movieWriter];
    [_movieWriter finishRecording];
    __weak typeof(self) werk = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication] .networkActivityIndicatorVisible = NO;

        AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:werk.currentUrl];
        [werk.player replaceCurrentItemWithPlayerItem:item];
        [werk.player play];
    });

    
}
@end
