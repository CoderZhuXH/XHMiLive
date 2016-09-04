//
//  XHPlayerViewController.m
//  XHMiLive
//
//  Created by xiaohui on 16/9/4.
//  Copyright © 2016年 returnoc.com. All rights reserved.
//

#import "XHPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import <UIImageView+WebCache.h>
#import <Accelerate/Accelerate.h>
#import "XHLiveModel.h"
#import "UIView+MBProgressHUD.h"

@interface XHPlayerViewController ()

@property (atomic, retain) id <IJKMediaPlayback> player;
@property(nonatomic,strong)UIView *palyerView;

@property (weak, nonatomic) IBOutlet UIImageView *liveImgView;


@end

@implementation XHPlayerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initPlayer];
    // 开启通知
    [self installMovieNotificationObservers];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    if (![self.player isPlaying]) {
        //准备播放
        [self.player prepareToPlay];
    }
    
    self.navigationController.navigationBarHidden = YES;
}
-(void)initUI{

    //加载中...
    [self  setupLoadView];
    

}
-(void)setupLoadView
{
    self.liveImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.liveImgView sd_setImageWithURL:[NSURL URLWithString:self.model.bigpic]];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = [[UIScreen mainScreen] bounds];
    visualEffectView.alpha = 0.8;
    [self.liveImgView addSubview:visualEffectView];
    
    [self.view showText:@"请稍后..."];
}
-(void)hideLoadView{

    [UIView animateWithDuration:0.3 animations:^{
       
        self.liveImgView.alpha = 0.1;
        
    } completion:^(BOOL finished) {
        
        [self.view hideHUD];
        self.liveImgView.hidden = YES;

    }];

}
-(void)initPlayer
{
    //设置ijkPlayer控制器
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.model.flv] withOptions:nil];
    //用ijkPlayer控制器 创建一个视图播放器
    UIView *playerView = [self.player view];
    
    playerView.frame = [[UIScreen mainScreen] bounds];
    
    playerView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //把播放器视图插入到view上
    [self.view insertSubview:playerView atIndex:0];
    
    //设置播放器的填充模式
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    
}

#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}
#pragma Selector func

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    
    [self hideLoadView];

    switch (_player.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

- (void)removeMovieNotificationObservers {
    
    NSLog(@"remove");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}

- (IBAction)closeAction:(UIButton *)sender {
    
    [self.player shutdown];
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)dealloc
{
    [self removeMovieNotificationObservers];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
