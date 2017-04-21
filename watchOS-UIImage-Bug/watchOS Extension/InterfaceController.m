//
//  InterfaceController.m
//  watchOS Extension
//
//  Created by Dr. Michael Lauer on 21.04.17.
//  Copyright © 2017 Dr. Lauer Information Technology. All rights reserved.
//

#import "InterfaceController.h"

@interface ImageSubclass : UIImage
@end

@implementation ImageSubclass

-(instancetype)initWithContentsOfFile:(NSString *)path
{
    return [super initWithContentsOfFile:path];
}

@end

@implementation InterfaceController

-(void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    NSString* path = [[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"jpg"];

    // this works
    //UIImage* image = [[UIImage alloc] initWithContentsOfFile:path];

    // this doesn't
    UIImage* image = [[ImageSubclass alloc] initWithContentsOfFile:path];

    _image.image = image;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



