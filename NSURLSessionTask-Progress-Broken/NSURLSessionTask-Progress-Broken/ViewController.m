//
//  ViewController.m
//  NSURLSessionTask-Progress-Broken
//
//  Created by Dr. Michael Lauer on 14.06.18.
//  Copyright © 2018 Dr. Lauer Information Technology. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
{
    NSURLSession* _session;
    NSURLSessionDataTask* _task;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _progressView.progress = 0;
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startDownloading:(id)sender
{
    NSURL* url = [NSURL URLWithString:_textField.text];
    if ( !url )
    {
        return;
    }

    _task = [_session dataTaskWithURL:url];
    _progressView.observedProgress = _task.progress;
    [_task resume];

    [_task.progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog( @"Progress = %@", _task.progress );
}

@end
