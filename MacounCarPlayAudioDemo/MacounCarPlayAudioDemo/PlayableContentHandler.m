//
//  PlayableContentHandler.m
//  MacounCarPlayAudioDemo
//
//  Created by Dr. Michael Lauer on 11.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "PlayableContentHandler.h"

@implementation PlayableContentHandler

+(instancetype)playableContentHandler
{
    return [[self alloc] init];
}

-(id)init
{
    if ( ! ( self = [super init] ) )
    {
        return nil;
    }

    [self registerWithCarPlay];

    return self;
}

-(void)registerWithCarPlay
{
    [[MPRemoteCommandCenter sharedCommandCenter].playCommand addTarget:self action:@selector(onPlayCommand:)];
    [[MPRemoteCommandCenter sharedCommandCenter].pauseCommand addTarget:self action:@selector(onPauseCommand:)];
    [[MPRemoteCommandCenter sharedCommandCenter].togglePlayPauseCommand addTarget:self action:@selector(onTogglePlayPauseCommand:)];

    MPNowPlayingInfoCenter.defaultCenter.nowPlayingInfo = @{

                                                            };

    MPPlayableContentManager.sharedContentManager.dataSource = self;
    MPPlayableContentManager.sharedContentManager.delegate = self;
    [MPPlayableContentManager.sharedContentManager beginUpdates];
    [MPPlayableContentManager.sharedContentManager endUpdates];
}

#pragma mark -
#pragma mark Target/Action for MPRemoteCommandCenter

-(void)onPlayCommand:(id)sender
{

}

-(void)onPauseCommand:(id)sender
{

}

-(void)onTogglePlayPauseCommand:(id)sender
{

}

#pragma mark -
#pragma mark <MPPlayableContentDataSource>

-(MPContentItem*)contentItemAtIndexPath:(NSIndexPath *)indexPath
{
    MPContentItem* item = [[MPContentItem alloc] initWithIdentifier:@"foo"];
    item.title = @"Title";
    item.subtitle = @"Subtitle";
    return item;
}

-(NSInteger)numberOfChildItemsAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"numberOfChildItemsAtIndexPath: %@", indexPath );
    return 1;
}

#pragma mark -
#pragma mark <MPPlayableContentDelegate>

-(void)playableContentManager:(MPPlayableContentManager *)contentManager didUpdateContext:(MPPlayableContentManagerContext *)context
{
    [MPPlayableContentManager.sharedContentManager reloadData];
}

-(void)playableContentManager:(MPPlayableContentManager *)contentManager initiatePlaybackOfContentItemAtIndexPath:(NSIndexPath *)indexPath completionHandler:(void(^)(NSError * __nullable))completionHandler
{
    NSLog( @"initiatePlaybackOfContentItemAtIndexPath: %@", indexPath );
}

@end
