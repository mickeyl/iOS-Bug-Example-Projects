//
//  TreeNode.m
//  MacounCarPlayAudioDemo
//
//  Created by Dr. Michael Lauer on 12.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "TreeNode.h"

#import "NSIndexPath+Utilities.h"

@implementation TreeNode
{
    NSString* _identifier;
}

+(instancetype)nodeWithChildren:(NSArray<TreeNode*>*)children title:(NSString*)title subtitle:(NSString*)subtitle xplicit:(BOOL)xplicit artwork:(NSURL*)artwork;
{
    return [[self alloc] initWithUrl:nil title:title subtitle:subtitle xplicit:xplicit artwork:artwork children:children];
}

+(instancetype)nodeWithURL:(NSURL*)url title:(NSString*)title subtitle:(NSString*)subtitle xplicit:(BOOL)xplicit artwork:(NSURL*)artwork;
{
    return [[self alloc] initWithUrl:url title:title subtitle:subtitle xplicit:xplicit artwork:artwork children:nil];
}

-(id)initWithUrl:(NSURL*)url title:(NSString*)title subtitle:(NSString*)subtitle xplicit:(BOOL)xplicit artwork:(NSURL*)artwork children:(NSArray<TreeNode*>*)children
{
    if ( ! ( self = [super init] ) )
    {
        return nil;
    }

    _identifier = [NSUUID UUID].UUIDString;
    _url = url;
    _title = title;
    _subtitle = subtitle;
    _xplicit = xplicit;
    _artwork = artwork;
    _children = children;

    return self;
}

-(MPContentItem*)contentItem
{
    MPContentItem* item = [[MPContentItem alloc] initWithIdentifier:_identifier];
    item.title = _title;
    item.subtitle = _subtitle;
    item.explicitContent = _xplicit;
    item.container = ( _children.count > 0 );
    item.playable = !!_url;
    item.streamingContent = ! [_url isFileURL];

    CGSize size = (CGSize) { .width = 3000, .height = 3000 };
    MPMediaItemArtwork* artwork = [[MPMediaItemArtwork alloc] initWithBoundsSize:size requestHandler:^UIImage * _Nonnull(CGSize size) {

        NSData* data = [NSData dataWithContentsOfURL:self.artwork];
        if ( data )
        {
            UIImage* image = [UIImage imageWithData:data];
            NSLog( @"Returning %@ for %@", image, self.artwork );
            return image;
        }
        return nil;

    }];

    item.artwork = artwork;

    return item;
}

-(NSInteger)numberOfChildItemsAtIndexPath:(NSIndexPath*)indexPath
{
    switch ( indexPath.length )
    {
        case 0:
            return self.children.count;

        default:
        {
            NSInteger firstIndex = [indexPath indexAtPosition:0];
            TreeNode* child = [self.children objectAtIndex:firstIndex];
            NSIndexPath* nextLevelIndexPath = indexPath.LT_indexPathByRemovingFirstIndex;
            return [child numberOfChildItemsAtIndexPath:nextLevelIndexPath];
        }
    }
}

-(TreeNode*)treeNodeAtIndexPath:(NSIndexPath*)indexPath
{
    switch ( indexPath.length )
    {
        case 0:
            return self;

        default:
        {
            NSInteger firstIndex = [indexPath indexAtPosition:0];
            TreeNode* child = [self.children objectAtIndex:firstIndex];
            NSIndexPath* nextLevelIndexPath = indexPath.LT_indexPathByRemovingFirstIndex;
            return [child treeNodeAtIndexPath:nextLevelIndexPath];
        }
    }
}

-(NSDictionary<NSString*,id>*)nowPlayingInfo
{
    return @{
             MPMediaItemPropertyTitle: _title,
             MPMediaItemPropertyGenre: @"Electronic/Downtempo",
             MPMediaItemPropertyArtwork: self.contentItem.artwork,
             MPMediaItemPropertyArtist: _subtitle
             };
}


#pragma mark -
#pragma mark Debugging

-(NSString*)description
{
    return [NSString stringWithFormat:@"<TreeNode %p: %@|%@ w/ children %@>", self, _title, _subtitle, _children];
}

@end
