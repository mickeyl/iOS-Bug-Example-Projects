//
//  PlayableContentHandler.m
//  MacounCarPlayAudioDemo
//
//  Created by Dr. Michael Lauer on 11.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "PlayableContentHandler.h"

#import <AVFoundation/AVFoundation.h>

#import "TreeNode.h"
#import "NSIndexPath+Utilities.h"

@implementation PlayableContentHandler
{
    TreeNode* _rootNode;
    AVPlayer* _player;
}

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

    [self createElements];
    [self registerWithCarPlay];

    return self;
}

#pragma mark -
#pragma mark Helpers

-(void)createElements
{
    TreeNode* oxygen = [TreeNode nodeWithChildren:@[] title:@"Oxygen" subtitle:@"1976" xplicit:NO artwork:nil];
    TreeNode* equinoxe = [TreeNode nodeWithChildren:@[] title:@"Equinoxe" subtitle:@"1978" xplicit:NO artwork:nil];
    TreeNode* magneticFields = [TreeNode nodeWithChildren:@[] title:@"Magnetic Fields" subtitle:@"1981" xplicit:NO artwork:nil];
    TreeNode* zoolook = [TreeNode nodeWithChildren:@[] title:@"Zoolook" subtitle:@"1984" xplicit:NO artwork:nil];
    TreeNode* rendezVous = [TreeNode nodeWithChildren:@[] title:@"Rendez-Vous" subtitle:@"1986" xplicit:NO artwork:nil];
    TreeNode* metamorphoses = [TreeNode nodeWithChildren:@[] title:@"Métamorphoses" subtitle:@"2000" xplicit:NO artwork:nil];
    TreeNode* jmj = [TreeNode nodeWithChildren:@[ oxygen, equinoxe, magneticFields, zoolook, rendezVous, metamorphoses] title:@"Jean-Michael Jarre" subtitle:@"The Electronic Pioneer" xplicit:NO artwork:[NSURL URLWithString:@"https://www.metal1.info/wordpress/wp-content/uploads/reviews/2015/11/Electronica-I-The-Time-Machine-Cover-200x200.jpg.pagespeed.ce.6L0lg9qrC5.jpg"]];

    NSURL* url;
    TreeNode* song1 = [TreeNode nodeWithURL:url title:@"Sputnik (Gaming Mix)" subtitle:nil xplicit:YES artwork:nil];
    TreeNode* song2 = [TreeNode nodeWithURL:url title:@"JFK" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song3 = [TreeNode nodeWithURL:url title:@"Liftoff" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song4 = [TreeNode nodeWithURL:url title:@"In Orbit" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song5 = [TreeNode nodeWithURL:url title:@"Touchdown (Excerpt)" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song6 = [TreeNode nodeWithURL:url title:@"Space Debris (80s Mix)" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song7 = [TreeNode nodeWithURL:url title:@"NGC 891 (Lounge Mix)" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song8 = [TreeNode nodeWithURL:url title:@"STS-51-L" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* spaceTravel = [TreeNode nodeWithChildren:@[ song1, song2, song3, song4, song5, song6, song7, song8 ] title:@"Space Travel" subtitle:@"Radio Transmissions and Cosmic Bubbles" xplicit:YES artwork:[NSURL URLWithString:@"https://f4.bcbits.com/img/a1054835159_16.jpg"]];

    TreeNode* song21 = [TreeNode nodeWithURL:url title:@"Touchdown" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song22 = [TreeNode nodeWithURL:url title:@"Touchdown (Bobby-Eats-Baklava-In-Space Mix)" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song23 = [TreeNode nodeWithURL:url title:@"Touchdown (Funky Planet Mix)" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* song24 = [TreeNode nodeWithURL:url title:@"Touchdown (Time & Space Mix)" subtitle:nil xplicit:NO artwork:nil];
    TreeNode* touchdown = [TreeNode nodeWithChildren:@[ song21, song22, song23, song24] title:@"Touchdown EP" subtitle:@"Touchdown Remixes" xplicit:NO artwork:[NSURL URLWithString:@"https://img.discogs.com/ukz4zGQfHQpy5rGA4MfMWq3zg-U=/fit-in/600x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-188446-1186768939.jpeg.jpg"]];

    TreeNode* fabriqueNoir = [TreeNode nodeWithChildren:@[ spaceTravel, touchdown ] title:@"Fabrique Noir" subtitle:@"Contemporary Electronic Music from N.I." xplicit:NO artwork:[NSURL URLWithString:@"https://f4.bcbits.com/img/0017006541_10.jpg"]];
    TreeNode* tabernaMercurio = [TreeNode nodeWithChildren:@[] title:@"Taberna Mercurio" subtitle:@"Modern Fusion with Guests" xplicit:NO artwork:[NSURL URLWithString:@"https://www.likealocalguide.com/media/cache/6f/3b/6f3b5a22f0ba65e8a43a25a4ad82d7d0.jpg"]];

    NSArray<TreeNode*>* children = @[ jmj, fabriqueNoir, tabernaMercurio ];

    NSURL* boxUrl = nil; //[NSURL URLWithString:@"https://image.flaticon.com/icons/png/128/65/65916.png"];
    TreeNode* hot = [TreeNode nodeWithChildren:@[ fabriqueNoir ] title:@"🕺 What's Hot" subtitle:@"Da Hottest Funk in da Town 💃 " xplicit:NO artwork:boxUrl];
    TreeNode* new = [TreeNode nodeWithChildren:@[ tabernaMercurio ] title:@"🕺 New Releases" subtitle:@"New Stuff in da House 💃 " xplicit:NO artwork:boxUrl];
    TreeNode* fav = [TreeNode nodeWithChildren:children title:@"🕺 Favorites" subtitle:@"Your Personal Hitz 💃 " xplicit:NO artwork:boxUrl];

    NSURL* remoteURL = [NSBundle.mainBundle URLForResource:@"dummyAudio" withExtension:@"aac"];
    TreeNode* rnd = [TreeNode nodeWithURL:remoteURL title:@"🕺 Random" subtitle:@"I'm feeling lucky… 💃 " xplicit:NO artwork:nil];

    _rootNode = [TreeNode nodeWithChildren:@[ hot, new, fav, rnd ] title:nil subtitle:nil xplicit:NO artwork:nil];
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

-(MPRemoteCommandHandlerStatus)onPlayCommand:(id)sender
{
    [_player play];
    return MPRemoteCommandHandlerStatusSuccess;
}

-(MPRemoteCommandHandlerStatus)onPauseCommand:(id)sender
{
    [_player pause];
    return MPRemoteCommandHandlerStatusSuccess;
}

-(MPRemoteCommandHandlerStatus)onTogglePlayPauseCommand:(id)sender
{
    return MPRemoteCommandHandlerStatusCommandFailed;
}

#pragma mark -
#pragma mark <MPPlayableContentDataSource>

-(MPContentItem*)contentItemAtIndexPath:(NSIndexPath *)indexPath
{
    TreeNode* node = [_rootNode treeNodeAtIndexPath:indexPath];
    return node.contentItem;
}

-(NSInteger)numberOfChildItemsAtIndexPath:(NSIndexPath *)indexPath
{
    return [_rootNode numberOfChildItemsAtIndexPath:indexPath];
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

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TreeNode* node = [self->_rootNode treeNodeAtIndexPath:indexPath];
        if ( node.url )
        {
            self->_player = [AVPlayer playerWithURL:node.url];
            [self->_player play];

            MPPlayableContentManager.sharedContentManager.nowPlayingIdentifiers = @[ node.contentItem.identifier ];
            MPNowPlayingInfoCenter.defaultCenter.nowPlayingInfo = node.nowPlayingInfo;
            [UIApplication.sharedApplication beginReceivingRemoteControlEvents];
#if TARGET_OS_SIMULATOR // strange, but true – you must actually call 'endReceiving' otherwise the simulator won't transition to the NowPlaying screen
            [UIApplication.sharedApplication endReceivingRemoteControlEvents];
            [UIApplication.sharedApplication beginReceivingRemoteControlEvents];
#endif
            NSError* e;
            [[AVAudioSession sharedInstance] setActive:YES error:&e];
            if ( e )
            {
                NSLog( @"Can't activate audio session: %@", e );
            }
        }
        completionHandler( nil );
    });
}

@end
