//
//  RedPageAlertView.m
//  myg
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "RedPageAlertView.h"

@interface RedPageAlertView ()
@property (nonatomic,strong)UIButton *closeBtn;
@property (nonatomic,strong)UIImageView *redpageIMG;
@property (nonatomic,strong)UIButton *gainRedPageBtn;
@property (nonatomic,strong)UIButton *checkRedPageBtn;
@property (nonatomic,strong)UILabel *resultLabel;
@end
@implementation RedPageAlertView

static RedPageAlertView *redPageView = nil;
+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        redPageView = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
        redPageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [redPageView setUpUI];
    });
    return redPageView;
}
- (void)setUpUI{
    
    self.redpageIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"null_redpage"]];
    self.redpageIMG.frame = CGRectMake(0, 0, self.redpageIMG.image.size.width, self.redpageIMG.image.size.height);
    self.redpageIMG.center = CGPointMake(redPageView.center.x, redPageView.center.y-75);
    self.redpageIMG.alpha = 1;
    [redPageView addSubview:self.redpageIMG];

    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setImage:[UIImage imageNamed:@"redpage_close_btn"] forState:UIControlStateNormal];
    self.closeBtn.frame = CGRectMake(320, 140+40, self.closeBtn.currentImage.size.width, self.closeBtn.currentImage.size.height);
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [redPageView addSubview:self.closeBtn];
    
    self.resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, 0, 0)];
    self.resultLabel.text = @"恭喜获得新手红包";
    self.resultLabel.font = [UIFont systemFontOfSize:16];
    self.resultLabel.textColor = [UIColor colorWithHexString:@"#fafbcf"];
    [self.resultLabel sizeToFit];
    self.resultLabel.center = CGPointMake(redPageView.center.x, 220);
    [redPageView addSubview:self.resultLabel];
    
    self.checkRedPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkRedPageBtn setImage:[UIImage imageNamed:@"redpage_checkbtn_back"] forState:UIControlStateNormal];
    self.checkRedPageBtn.frame = CGRectMake(self.bounds.size.width*0.5-self.checkRedPageBtn.currentImage.size.width*0.5, self.redpageIMG.frame.origin.y+self.redpageIMG.frame.size.height+50, self.checkRedPageBtn.currentImage.size.width, self.checkRedPageBtn.currentImage.size.height);
    [self.checkRedPageBtn setTitle:@"领取红包" forState:UIControlStateNormal];
    [self.checkRedPageBtn setTitleColor:[UIColor colorWithHexString:@"#fe1602"] forState:UIControlStateNormal];
    self.checkRedPageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [redPageView addSubview:self.checkRedPageBtn];
    
    self.checkRedPageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.checkRedPageBtn.currentImage.size.width, 0, 0);
    self.checkRedPageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.checkRedPageBtn.titleLabel.bounds.size.width);
    self.checkRedPageBtn.adjustsImageWhenHighlighted = NO;
    
    [self.checkRedPageBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)showWithState:(BOOL)state imageName:(NSString *)imageName checkTitle:(NSString *)title{
    redPageView.resultLabel.hidden = state;
    redPageView.redpageIMG.image = [UIImage imageNamed:imageName];
    [redPageView.checkRedPageBtn setTitle:title forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:redPageView];
}
- (void)dismiss{
    [redPageView removeFromSuperview];
}
- (void)closeAction{
    [self dismiss];
}
- (void)checkAction:(UIButton *)sender{
    self.checkBlock(sender.titleLabel.text);
}

@end
