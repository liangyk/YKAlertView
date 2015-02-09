//
//  ViewController.m
//  YKAlertView
//
//  Created by ilyk on 15-2-8.
//  Copyright (c) 2015年 liangxiaoer. All rights reserved.
//

#import "ViewController.h"
#import "YKAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
   YKAlertView * alter = [[YKAlertView alloc]initWithTitle:@"111" contentText:@"11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" oneButtonTitle:@"点解消失" twoButtonTitle:nil threeButtonTitle:nil];
    
    [alter showAlert];
    
    alter.dismissBool = YES;
    
    [alter handleOneButton:^{
        
    }];
}
- (IBAction)twoAction:(id)sender {
    __strong YKAlertView * alter = [[YKAlertView alloc]initWithTitle:@"2222" contentText:@"22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222" oneButtonTitle:@"点解消失" twoButtonTitle:@"点击还在" threeButtonTitle:nil];
    
    [alter showAlert];
    
    
    [alter handleOneButton:^{
        alter.dismissBool = YES;
    }];
    
    
    [alter handleTwoButton:^{
        NSLog(@"!!!");
    }];
    
}

- (IBAction)threeAction:(id)sender {
    YKAlertView * alter = [[YKAlertView alloc]initWithTitle:@"333" contentText:@"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333" oneButtonTitle:@"点解消失" twoButtonTitle:nil threeButtonTitle:nil];
    
    [alter showAlert];
    
    alter.dismissBool = YES;
    
    [alter handleOneButton:^{
        
    }];
    
    
}

@end
