//
//  AppDelegate.h
//  MacounCarPlayNavigationDemo
//
//  Created by Dr. Michael Lauer on 15.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import <CarPlay/CarPlay.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CPApplicationDelegate, CPMapTemplateDelegate>

+(instancetype)delegate;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) CPWindow* cpWindow;
@property (strong, nonatomic, readonly) CPInterfaceController* cpInterfaceController;

@end

