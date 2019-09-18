//
//  ListDemoTemplate.m
//  MacounCarPlayNavigationDemo
//
//  Created by Dr. Michael Lauer on 17.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "ListDemoTemplate.h"

#import "SearchDemoTemplate.h"

#import "AppDelegate.h"

static id instance;

@implementation ListDemoTemplate

+(CPTemplate*)tp
{
    NSMutableArray<CPListItem*>* fantasyCreatures = [NSMutableArray array];
    for ( NSString* name in @[ @"dragon", @"unicorn", @"whale", @"pegasus", @"duck", @"horse", @"sheep", @"ram" ] )
    {
        NSString* detailText = [NSString stringWithFormat:@"A sweet %@", name.capitalizedString];
        CPListItem* creature = [[CPListItem alloc] initWithText:name.capitalizedString detailText:detailText image:[UIImage imageNamed:@"rosalie"]];
        creature.userInfo = @0;
        [fantasyCreatures addObject:creature];
    }
    CPListSection* fantasySection = [[CPListSection alloc] initWithItems:fantasyCreatures header:@"Fantasy Creatures" sectionIndexTitle:nil];

    NSMutableArray<CPListItem*>* realCreatures = [NSMutableArray array];
    for ( NSString* name in @[ @"dragon", @"unicorn", @"whale", @"pegasus", @"duck", @"horse", @"sheep", @"ram" ] )
    {
        NSString* detailText = [NSString stringWithFormat:@"A sweet %@", name.capitalizedString];
        CPListItem* creature = [[CPListItem alloc] initWithText:name.capitalizedString detailText:detailText image:[UIImage imageNamed:name]];
        creature.userInfo = @1;
        [realCreatures addObject:creature];
    }
    CPListSection* realSection = [[CPListSection alloc] initWithItems:realCreatures header:@"Real Creatures" sectionIndexTitle:nil];

    CPListTemplate* obj = [[CPListTemplate alloc] initWithTitle:@"List" sections:@[ fantasySection, realSection ]];
    obj.delegate = instance = [[self alloc] init];
    return obj;
}

#pragma mark -
#pragma mark <CPListTemplateDelegate>

-(void)listTemplate:(CPListTemplate *)listTemplate didSelectListItem:(CPListItem *)item completionHandler:(void (^)(void))completionHandler
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if ( [item.userInfo isEqual:@0] )
        {
            [AppDelegate.delegate.cpInterfaceController popTemplateAnimated:YES];
        }
        else
        {
            CPTemplate* tp = [SearchDemoTemplate tp];
            [AppDelegate.delegate.cpInterfaceController pushTemplate:tp animated:YES];
        }

        completionHandler();
    });
}

@end
