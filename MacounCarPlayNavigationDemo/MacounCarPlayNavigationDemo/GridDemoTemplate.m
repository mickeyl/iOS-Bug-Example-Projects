//
//  GridDemoTemplate.m
//  MacounCarPlayNavigationDemo
//
//  Created by Dr. Michael Lauer on 17.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "GridDemoTemplate.h"

#import "ListDemoTemplate.h"
#import "MapDemoTemplate.h"
#import "AppDelegate.h"

@implementation GridDemoTemplate

+(CPTemplate*)tp
{
    NSMutableArray<CPGridButton*>* buttons = [NSMutableArray array];
    for ( NSString* name in @[ @"dragon", @"unicorn", @"whale", @"pegasus", @"duck", @"horse", @"sheep", @"ram" ] )
    {
        CPGridButton* b = [[CPGridButton alloc] initWithTitleVariants:@[ name.capitalizedString ] image:[UIImage imageNamed:name] handler:^(CPGridButton * _Nonnull barButton) {

            if ( [name isEqualToString:@"unicorn"] )
            {
                CPTemplate* t = [MapDemoTemplate tp];
                [AppDelegate.delegate.cpInterfaceController pushTemplate:t animated:YES];
            }
            else
            {
                CPTemplate* t = [ListDemoTemplate tp];
                [AppDelegate.delegate.cpInterfaceController pushTemplate:t animated:YES];
            }

        }];
        [buttons addObject:b];
    }

    CPGridTemplate* obj = [[CPGridTemplate alloc] initWithTitle:@"Grid" gridButtons:buttons];
    return obj;
}

@end
