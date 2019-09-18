//
//  AppDelegate.m
//  MacounCarPlayNavigationDemo
//
//  Created by Dr. Michael Lauer on 15.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "AppDelegate.h"

#import "GridDemoTemplate.h"

@implementation AppDelegate
{
    CPNavigationSession* _cpNavigationSession;
}

#pragma mark -
#pragma mark <UIApplicationDelegate>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog( @"I'm running now" );
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark <CPApplicationDelegate>

-(void)application:(UIApplication *)application didConnectCarInterfaceController:(CPInterfaceController *)interfaceController toWindow:(CPWindow *)window
{
    NSLog( @"CarPlay connected %@ to %@", interfaceController, window );
    CPTemplate* grid = [GridDemoTemplate tp];
    [interfaceController setRootTemplate:grid animated:NO];

    window.rootViewController = self.viewController;

    _cpInterfaceController = interfaceController;
    _cpWindow = window;
}

-(void)application:(nonnull UIApplication *)application didDisconnectCarInterfaceController:(nonnull CPInterfaceController *)interfaceController fromWindow:(nonnull CPWindow *)window
{
    NSLog( @"CarPlay disconnected %@ from %@", interfaceController, window );
}

-(void)application:(UIApplication *)application didSelectManeuver:(CPManeuver *)maneuver
{

}

-(void)application:(UIApplication *)application didSelectNavigationAlert:(CPNavigationAlert *)navigationAlert
{

}

#pragma mark -
#pragma mark Helpers

-(UIViewController*)viewController
{
    UIViewController* vc = [[UIViewController alloc] init];
    MKMapView* map = [[MKMapView alloc] initWithFrame:CGRectZero];
    [vc.view addSubview:map];
    map.translatesAutoresizingMaskIntoConstraints = NO;
    [vc.view.topAnchor constraintEqualToAnchor:map.topAnchor].active = YES;
    [vc.view.leftAnchor constraintEqualToAnchor:map.leftAnchor].active = YES;
    [vc.view.bottomAnchor constraintEqualToAnchor:map.bottomAnchor].active = YES;
    [vc.view.rightAnchor constraintEqualToAnchor:map.rightAnchor].active = YES;
    map.showsUserLocation = YES;
    map.showsPointsOfInterest = YES;
    map.showsTraffic = YES;
    map.showsCompass = YES;
    map.showsScale = YES;
    CLLocationCoordinate2D macoun = CLLocationCoordinate2DMake(50.107231, 8.689365);
    MKCoordinateRegion region = MKCoordinateRegionMake( macoun, MKCoordinateSpanMake( 0.005, 0.005 ) );
    [map setRegion:region];

    return vc;
}

#pragma mark -
#pragma mark <API>

+(instancetype)delegate
{
    return (AppDelegate*)UIApplication.sharedApplication.delegate;
}



@end
