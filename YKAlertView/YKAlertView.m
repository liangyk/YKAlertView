//
//  YKAlertView.m
//  YKAlertView
//
//  Created by ilyk on 15-2-8.
//  Copyright (c) 2015年 liangxiaoer. All rights reserved.
//

#define kAlertWidth 245.0f
#define kAlertHeight 160.0f

#define kTitleYOffset 15.0f
#define kTitleHeight 25.0f

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f

#define kSingleButtonWidth 245.0f
#define kCoupleButtonWidth 122.5f
#define kButtonHeight 40.0f
#define kButtonBottomOffset 0.0f
#define kButtonLineWidth 5.0f

#import "YKAlertView.h"

@interface YKAlertView ()

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *oneButton;
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, strong) UIButton *threeButton;
@property (nonatomic, strong) UIView *backImageView;

@property (nonatomic,assign) CGFloat alertHeight;

@end

@implementation YKAlertView

#pragma mark - LifeCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //视图存在判断
    if (!newSuperview) {
        return;
    }
    
    //添加阴暗背景视图
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];

    
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - _alertHeight) * 0.5, kAlertWidth, _alertHeight);
    self.frame = afterFrame;
    
    [UIView exChangeOut:self dur:0.5f];
}

-(void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    [super removeFromSuperview];
}

-(id)initWithTitle:(NSString *)title
       contentText:(NSString *)content
    oneButtonTitle:(NSString *)oneTitle
    twoButtonTitle:(NSString *)twoTitle
  threeButtonTitle:(NSString *)threeTitle
{
    if (self = [super init]) {
        
        //计算alert的content所占的位置
        CGRect rect = [content boundingRectWithSize:CGSizeMake(kAlertWidth - 16, [UIScreen mainScreen].bounds.size.height/3*2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        self.layer.cornerRadius = 5.0;//alertView圆角
        self.backgroundColor = [UIColor whiteColor];
        
        
        //alert的标题
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        [self addSubview:self.alertTitleLabel];
        
        //alert的内容
        CGFloat contentLabelWidth = kAlertWidth - 16;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame), contentLabelWidth, rect.size.height)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.alertContentLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:self.alertContentLabel];
        
        
        CGRect oneButtonFrame;
        CGRect twoButtonFrame;
        CGRect threeButtonFrame;
        if (threeTitle&& twoTitle &&oneTitle) {
            //alertHeight的计算
            _alertHeight = rect.size.height + kTitleHeight +kTitleYOffset +kButtonHeight*3 +kButtonBottomOffset + kButtonLineWidth*2;
            
            oneButtonFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, _alertHeight - kButtonBottomOffset - kButtonHeight*3 -kButtonLineWidth*2, kSingleButtonWidth, kButtonHeight);
            self.oneButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.oneButton.frame = oneButtonFrame;
            [self.oneButton addTarget:self action:@selector(oneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.oneButton];
            
            
            twoButtonFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, _alertHeight - kButtonBottomOffset - kButtonHeight*2 -kButtonLineWidth, kSingleButtonWidth, kButtonHeight);
            self.twoButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.twoButton.frame = twoButtonFrame;
            [self.twoButton addTarget:self action:@selector(twoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.twoButton];
            
            
            threeButtonFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, _alertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.threeButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.threeButton.frame = threeButtonFrame;
            [self.threeButton addTarget:self action:@selector(threeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.threeButton];
            
            
            //添加分割线
            UIView * divisionLine = [[UIView alloc]init];
            divisionLine.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            divisionLine.frame = CGRectMake(oneButtonFrame.origin.x, oneButtonFrame.origin.y, oneButtonFrame.size.width, 0.5);
            [self addSubview:divisionLine];
            
            
            //添加分割线
            UIView * divisionLine1 = [[UIView alloc]init];
            divisionLine1.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            divisionLine1.frame = CGRectMake(twoButtonFrame.origin.x, twoButtonFrame.origin.y, twoButtonFrame.size.width, 0.5);
            [self addSubview:divisionLine1];
            
            
            //添加分割线
            UIView * divisionLine2 = [[UIView alloc]init];
            divisionLine2.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            divisionLine2.frame = CGRectMake(threeButtonFrame.origin.x, threeButtonFrame.origin.y, threeButtonFrame.size.width, 0.5);
            [self addSubview:divisionLine2];
            
        }
        else if (twoTitle&& oneTitle)
        {
            //alertHeight的计算
            _alertHeight = rect.size.height + kTitleHeight +kTitleYOffset +kButtonHeight +kButtonBottomOffset;
            
            oneButtonFrame = CGRectMake((kAlertWidth - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5, _alertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            twoButtonFrame = CGRectMake(CGRectGetMaxX(oneButtonFrame) + kButtonBottomOffset, _alertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            self.oneButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.twoButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.oneButton.frame = oneButtonFrame;
            self.twoButton.frame = twoButtonFrame;
            
            
            [self.oneButton addTarget:self action:@selector(oneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.twoButton addTarget:self action:@selector(twoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:self.oneButton];
            [self addSubview:self.twoButton];
            
            //添加分割线
            UIView * divisionLine = [[UIView alloc]init];
            divisionLine.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            divisionLine.frame = CGRectMake(oneButtonFrame.origin.x, oneButtonFrame.origin.y, oneButtonFrame.size.width, 0.5);
            [self addSubview:divisionLine];
            
            //添加分割线
            UIView * divisionLine1 = [[UIView alloc]init];
            divisionLine1.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            divisionLine1.frame = CGRectMake(twoButtonFrame.origin.x, twoButtonFrame.origin.y, twoButtonFrame.size.width, 0.5);
            [self addSubview:divisionLine1];
            
            //添加分割线
            UIView * divisionLine2 = [[UIView alloc]init];
            divisionLine2.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            divisionLine2.frame = CGRectMake(twoButtonFrame.origin.x, twoButtonFrame.origin.y, 0.5, twoButtonFrame.size.height);
            [self addSubview:divisionLine2];
            
        }else
        {
            //alertHeight的计算
            _alertHeight = rect.size.height + kTitleHeight +kTitleYOffset +kButtonHeight +kButtonBottomOffset;
            
            oneButtonFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, _alertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.oneButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.oneButton.frame = oneButtonFrame;
            
            [self.oneButton addTarget:self action:@selector(oneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.oneButton];
            
            //添加分割线
            UIView * divisionLine = [[UIView alloc]init];
            divisionLine.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            divisionLine.frame = CGRectMake(oneButtonFrame.origin.x, oneButtonFrame.origin.y, oneButtonFrame.size.width, 0.5);
            [self addSubview:divisionLine];
        }

        [self.oneButton setTitle:oneTitle forState:UIControlStateNormal];
        [self.twoButton setTitle:twoTitle forState:UIControlStateNormal];
        [self.threeButton setTitle:threeTitle forState:UIControlStateNormal];
        
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

#pragma mark - Event
-(void)oneButtonAction:(id)sender
{
    if (_oneBlock) {
        _oneBlock();
        if (_dismissBool) {
            [self dismissAlert];
        }
    }
}

-(void)twoButtonAction:(id)sender
{
    if (_twoBlock) {
        _twoBlock();
        if (_dismissBool) {
            [self dismissAlert];
        }
    }
}

-(void)threeButtonAction:(id)sender
{
    if (_threeBlock) {
        _threeBlock();
        if (_dismissBool) {
            [self dismissAlert];
        }
    }
}

#pragma mark - Function
//#pragma mark HandleModal
#pragma mark HandleView
- (void)showAlert
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    [self removeFromSuperview];
}

- (void)handleOneButton:(dispatch_block_t)oneBlock
{
    self.oneBlock = oneBlock;
}

- (void)handleTwoButton:(dispatch_block_t)twoBlock
{
    self.twoBlock = twoBlock;
}

- (void)handleThreeButton:(dispatch_block_t)threeBlock
{
    self.threeBlock= threeBlock;
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end


@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end


@implementation UIView (alertViewAnimation)

+(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}
@end
