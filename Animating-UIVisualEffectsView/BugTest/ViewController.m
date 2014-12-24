//
//  ViewController.m
//  UIActionSheetTest
//
//  Created by Dr. Michael Lauer on 24.12.14.
//  Copyright (c) 2014 Dr. Michael Lauer. All rights reserved.
//

#import "ViewController.h"

#define TAG 0xdeadbeef


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    UIVisualEffectView* blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    blurView.frame = CGRectMake(0, 300, 300, 0);
    blurView.tag = TAG;
    [self.view addSubview:blurView];
    
    [UIView animateWithDuration:2.0 animations:^{
        
        blurView.frame = CGRectMake(0, 0, 300, 300);
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:2.0 animations:^{
            
            blurView.frame = CGRectMake(0, 300, 300, 0);
            
        } completion:^(BOOL finished) {
            
            [blurView removeFromSuperview];
    
        }];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
