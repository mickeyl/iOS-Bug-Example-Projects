//
//  SearchDemoTemplate.m
//  MacounCarPlayNavigationDemo
//
//  Created by Dr. Michael Lauer on 17.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "SearchDemoTemplate.h"

#import "AppDelegate.h"

static id instance;
static NSArray<CPListItem*>* allItems;

@implementation SearchDemoTemplate

+(CPTemplate*)tp
{
    CPSearchTemplate* obj = [[CPSearchTemplate alloc] init];
    obj.delegate = instance = [[self alloc] init];
    return obj;
}

#pragma mark -
#pragma mark Constructor

-(id)init
{
    if ( ! ( self = [super init] ) )
    {
        return nil;
    }

    NSMutableArray<CPListItem*>* fantasyCreatures = [NSMutableArray array];
    for ( NSString* name in @[ @"dragon", @"unicorn", @"whale", @"pegasus", @"duck", @"horse", @"sheep", @"ram" ] )
    {
        NSString* detailText = [NSString stringWithFormat:@"A sweet %@", name.capitalizedString];
        CPListItem* creature = [[CPListItem alloc] initWithText:name.capitalizedString detailText:detailText image:[UIImage imageNamed:@"rosalie"]];
        creature.userInfo = @0;
        [fantasyCreatures addObject:creature];
    }
    allItems = fantasyCreatures;

    return self;

}

#pragma mark -
#pragma mark <CPSearchTemplateDelegate>

-(void)searchTemplate:(nonnull CPSearchTemplate *)searchTemplate selectedResult:(nonnull CPListItem *)item completionHandler:(nonnull void (^)(void))completionHandler
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSString* title = [NSString stringWithFormat:@"Really adopt a %@?", item.text];
        NSArray<CPAlertAction*>* actions = @[
                                             [[CPAlertAction alloc] initWithTitle:@"Yo!" style:CPAlertActionStyleDefault handler:^(CPAlertAction * _Nonnull action) {
                                                 [AppDelegate.delegate.cpInterfaceController dismissTemplateAnimated:YES];
                                             }],
                                             [[CPAlertAction alloc] initWithTitle:@"Neva!" style:CPAlertActionStyleCancel handler:^(CPAlertAction * _Nonnull action) {
                                                 [AppDelegate.delegate.cpInterfaceController dismissTemplateAnimated:YES];
                                             }],
                                             [[CPAlertAction alloc] initWithTitle:@"Nuke 'em!" style:CPAlertActionStyleDestructive handler:^(CPAlertAction * _Nonnull action) {
                                                 [AppDelegate.delegate.cpInterfaceController dismissTemplateAnimated:YES];
                                             }],
                                             ];

        if ( [item.text hasPrefix:@"Drag"] )
        {
            CPAlertTemplate* alert = [[CPAlertTemplate alloc] initWithTitleVariants:@[ title ] actions:actions];
            [AppDelegate.delegate.cpInterfaceController presentTemplate:alert animated:YES];
        }
        else
        {
            CPActionSheetTemplate* sheet = [[CPActionSheetTemplate alloc] initWithTitle:@"Please confirm" message:title actions:actions];
            [AppDelegate.delegate.cpInterfaceController presentTemplate:sheet animated:YES];
        }

    });
}

-(void)searchTemplate:(nonnull CPSearchTemplate *)searchTemplate updatedSearchText:(nonnull NSString *)searchText completionHandler:(nonnull void (^)(NSArray<CPListItem *> * _Nonnull))completionHandler
{
    NSLog( @"searchText: %@", searchText );

    NSMutableArray<CPListItem*>* searchResults = [NSMutableArray array];
    [allItems enumerateObjectsUsingBlock:^(CPListItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {

        if ( [item.text hasPrefix:searchText] )
        {
            [searchResults addObject:item];
        }

    }];

    completionHandler( [NSArray arrayWithArray:searchResults] );
}


@end
