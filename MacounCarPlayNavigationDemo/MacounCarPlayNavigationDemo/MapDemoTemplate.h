//
//  MapDemoTemplate.h
//  MacounCarPlayNavigationDemo
//
//  Created by Dr. Michael Lauer on 17.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import <CarPlay/CarPlay.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapDemoTemplate : NSObject <CPMapTemplateDelegate>

+(CPTemplate*)tp;

@end

NS_ASSUME_NONNULL_END
