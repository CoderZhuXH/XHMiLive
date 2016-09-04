//
//  UIView+MBProgressHUD.h
//  Logistics
//
//  Created by xiaohui on 16/4/13.
//  Copyright © 2016年 qiantou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MBProgressHUD)

/**
 *  showHUD
 */
-(void)showHUD;

/**
 *  showHUD+Text
 */
-(void)showHUDAndText:(NSString *)text;

/**
 *  showText
 */
-(void)showText:(NSString *)text;

/**
 *  移除HUD(该界面所有)
 */
-(void)hideHUD;

@end
