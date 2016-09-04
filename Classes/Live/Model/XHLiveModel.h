//
//  XHLiveModel.h
//  XHMiLive
//
//  Created by xiaohui on 16/9/4.
//  Copyright © 2016年 returnoc.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHLiveModel : NSObject


@property (nonatomic, copy) NSString *myname;//用户昵称

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, copy) NSString *smallpic;//图像

@property (nonatomic, copy) NSString * allnum;//观看人数

@property (nonatomic, assign) NSInteger serverid;

@property (nonatomic, assign) NSInteger roomid;

@property (nonatomic, copy) NSString *gps;//位置

@property (nonatomic, assign) NSInteger starlevel;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *signatures;//签名

@property (nonatomic, copy) NSString *bigpic;//直播封面

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger curexp;

@property (nonatomic, assign) NSInteger useridx;

@property (nonatomic, assign) NSInteger grade;

@property (nonatomic, copy) NSString *familyName;

@property (nonatomic, copy) NSString *flv;//播放地址

@end
