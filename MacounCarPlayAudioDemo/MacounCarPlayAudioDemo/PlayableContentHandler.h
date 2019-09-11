//
//  PlayableContentHandler.h
//  MacounCarPlayAudioDemo
//
//  Created by Dr. Michael Lauer on 11.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MediaPlayer/MediaPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayableContentHandler : NSObject <MPPlayableContentDataSource, MPPlayableContentDelegate>

+(instancetype)playableContentHandler;

@end

NS_ASSUME_NONNULL_END
