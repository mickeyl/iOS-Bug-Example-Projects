//
//  TreeNode.h
//  MacounCarPlayAudioDemo
//
//  Created by Dr. Michael Lauer on 12.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@class TreeNode;

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : NSObject

@property(strong,nonatomic,readonly) NSURL* url;
@property(strong,nonatomic,readonly) NSString* title;
@property(strong,nonatomic,readonly) NSString* subtitle;
@property(assign,nonatomic,readonly) BOOL xplicit;
@property(strong,nonatomic,readonly) NSURL* artwork;
@property(strong,nonatomic,readonly) NSArray<TreeNode*>* children;

+(instancetype)nodeWithChildren:(NSArray<TreeNode*>*)children title:(NSString*)title subtitle:(NSString*)subtitle xplicit:(BOOL)xplicit artwork:(NSURL*)artwork;
+(instancetype)nodeWithURL:(NSURL*)url title:(NSString*)title subtitle:(NSString*)subtitle xplicit:(BOOL)xplicit artwork:(NSURL*)artwork;

-(MPContentItem*)contentItem;
-(NSInteger)numberOfChildItemsAtIndexPath:(NSIndexPath*)indexPath;
-(MPContentItem*)contentItemAtIndexPath:(NSIndexPath*)indexPath;

@end

NS_ASSUME_NONNULL_END
