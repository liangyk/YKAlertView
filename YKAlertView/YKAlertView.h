//
//  YKAlertView.h
//  YKAlertView
//
//  Created by ilyk on 15-2-8.
//  Copyright (c) 2015年 liangxiaoer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKAlertView : UIView
@property (nonatomic, copy) dispatch_block_t oneBlock;
@property (nonatomic, copy) dispatch_block_t twoBlock;
@property (nonatomic, copy) dispatch_block_t threeBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic,assign) Boolean dismissBool;


-(id)initWithTitle:(NSString *)title
       contentText:(NSString *)content
    oneButtonTitle:(NSString *)oneTitle
    twoButtonTitle:(NSString *)twoTitle
  threeButtonTitle:(NSString *)threeTitle;

- (void)showAlert;

- (void)dismissAlert;

- (void)handleOneButton:(dispatch_block_t)oneBlock;

- (void)handleTwoButton:(dispatch_block_t)twoBlock;

- (void)handleThreeButton:(dispatch_block_t)threeBlock;
@end





@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end


@interface UIView (alertViewAnimation)

+(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur;

@end