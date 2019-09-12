//
//  NSIndexPath+Utilities.m
//  MacounCarPlayAudioDemo
//
//  Created by Dr. Michael Lauer on 12.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "NSIndexPath+Utilities.h"

@implementation NSIndexPath (LTUtilities)

-(NSUInteger)LT_firstIndex
{
    return [self indexAtPosition:0];
}

-(NSIndexPath*)LT_indexPathByRemovingFirstIndex
{
    NSUInteger* indexes = calloc( sizeof(NSUInteger), self.length );
    [self getIndexes: indexes];

    NSUInteger* buffer = calloc( sizeof(NSUInteger), self.length - 1);
    buffer = memcpy( buffer, &indexes[1], sizeof(NSUInteger) * (self.length - 1 ) );
    free(indexes);
    NSIndexPath* thePath = [NSIndexPath indexPathWithIndexes:buffer length:self.length - 1];
    free(buffer);

    return thePath;
}

@end
