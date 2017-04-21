//
//  InterfaceController.h
//  watchOS Extension
//
//  Created by Dr. Michael Lauer on 21.04.17.
//  Copyright © 2017 Dr. Lauer Information Technology. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *image;

@end
