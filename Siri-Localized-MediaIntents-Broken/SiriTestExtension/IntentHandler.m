//
//  IntentHandler.m
//  SiriTestExtension
//
//  Created by Dr. Michael Lauer on 17.12.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "IntentHandler.h"

@interface IntentHandler ()

@end

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self;
}

- (void)handlePlayMedia:(INPlayMediaIntent *)intent
             completion:(void (^)(INPlayMediaIntentResponse *response))completion
{
    ;
}

-(void)resolveMediaItemsForPlayMedia:(INPlayMediaIntent *)intent withCompletion:(void (^)(NSArray<INPlayMediaMediaItemResolutionResult *> * _Nonnull))completion
{
    NSArray<NSString*>* names = @[ @"foo", @"bar", @"baz", @"yo", @"kurt" ];
    NSMutableArray<INMediaItem*>* items = [NSMutableArray array];
    for ( NSString* name in names )
    {
        INMediaItem* item = [[INMediaItem alloc] initWithIdentifier:name title:name type:INMediaItemTypeStation artwork:nil];
        [items addObject:item];
    }
    INMediaItemResolutionResult* r = [INMediaItemResolutionResult disambiguationWithMediaItemsToDisambiguate:items];
    INPlayMediaMediaItemResolutionResult* pr = [[INPlayMediaMediaItemResolutionResult alloc] initWithMediaItemResolutionResult:r];
    completion( @[pr] );
}

@end
