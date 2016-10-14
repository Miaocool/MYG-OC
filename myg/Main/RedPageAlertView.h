//
//  RedPageAlertView.h
//  myg
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CheckBlock)(NSString *);
@interface RedPageAlertView : UIView
- (void)showWithState:(BOOL)state imageName:(NSString *)imageName checkTitle:(NSString *)title;
@property (nonatomic,copy)CheckBlock checkBlock;
+ (instancetype)shareInstance;
@end
