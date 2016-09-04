//
//  Defines.h
//  TabBar_demo
//
//  Created by xiaohui on 15-5-18.
//  Copyright (c) 2015年 qiwo. All rights reserved.
//

#ifndef TabBar_demo_Defines_h
#define TabBar_demo_Defines_h

//获取屏幕/宽/高
#define MainScreen [[UIScreen mainScreen] bounds]
#define MWIDTH MainScreen.size.width
#define MHEIGHT MainScreen.size.height

//RGB 颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//16进制颜色
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//随机色
#define Color_Other  RGBCOLOR(arc4random()%255, arc4random()%255, arc4random()%255)
//界面主色
//#define Color_Main  RGBCOLOR(59, 62, 73)//黑灰色
//#define Color_Main  RGBCOLOR(213,8,4)//大红色
#define Color_Red  RGBCOLOR(234,74, 37)
#define Color_Main  RGBCOLOR(53,157, 245)
#define Color_Bule  RGBCOLOR(22, 131, 251)//蓝色

#define Color_SegmentedCtl  RGBCOLOR(60, 60, 60)//SegmentedCtl 淡黑色
//按钮颜色
#define Color_Btn  Color_Main
//界面绿色
#define Color_Green  RGBCOLOR(31, 189, 34);
//textFiled 暗纹颜色
#define Color_Placeholder RGBCOLOR(153, 153, 153);
//轮廓颜色
#define Color_Border [RGBCOLOR(215, 215, 215) CGColor]



//字体大小
//cell
#define Font_Cell [UIFont systemFontOfSize:15]
//基于iphone5 比例高度
#define ScaleH(height) [[UIScreen mainScreen] bounds].size.width/320.00*(height)

//系统版本
#define SYSTEM_VERSION [[[UIDevice currentDevice]systemVersion]floatValue]
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f

// 是否为高清屏
#define isRetina ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&([UIScreen mainScreen].scale == 2.0))

// 判断设备类型
#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)
#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)
#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)
#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f)

//自定义打印
#ifdef DEBUG  // 调试阶段
#define DLog(...) NSLog(__VA_ARGS__)
#else // 发布阶段
#define DLog(...)
#endif

#endif
