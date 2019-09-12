//
//  NSIndexPath+Utilities.h
//  MacounCarPlayAudioDemo
//
//  Created by Dr. Michael Lauer on 12.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (Utilities)

-(NSUInteger)LT_firstIndex;
-(NSIndexPath*)LT_indexPathByRemovingFirstIndex;

@end

NS_ASSUME_NONNULL_END
