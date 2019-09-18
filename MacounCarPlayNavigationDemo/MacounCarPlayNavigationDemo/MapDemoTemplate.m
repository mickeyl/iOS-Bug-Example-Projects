//
//  MapDemoTemplate.m
//  MacounCarPlayNavigationDemo
//
//  Created by Dr. Michael Lauer on 17.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "MapDemoTemplate.h"

static id instance;

@implementation MapDemoTemplate

+(CPTemplate*)tp
{
    CPMapTemplate* map = [[CPMapTemplate alloc] init];
    map.mapDelegate = instance = [[self alloc] init];
    map.automaticallyHidesNavigationBar = NO;

    CPBarButton* left = [[CPBarButton alloc] initWithType:CPBarButtonTypeText handler:^(CPBarButton * _Nonnull barButton) {

    }];
    left.title = @"Left Button";

    CPBarButton* right = [[CPBarButton alloc] initWithType:CPBarButtonTypeText handler:^(CPBarButton * _Nonnull barButton) {

        NSArray<NSString*>* titles = @[ @"Nach Hause!", @"Heim" ];
        NSArray<NSString*>* subtitles = @[ @"Möchten Sie nach Hause navigiert werden?", @"Jetzt nach Hause?" ];
        CPAlertAction* action = [[CPAlertAction alloc] initWithTitle:@"Yo!" style:CPAlertActionStyleDefault handler:^(CPAlertAction * _Nonnull a) {

            [instance carplayNavigateTo:@"Mittlerer Schafhofweg 28, 60598 Frankfurt"];

        }];
        CPAlertAction* cancel = [[CPAlertAction alloc] initWithTitle:@"Jetzt nicht!" style:CPAlertActionStyleCancel handler:^(CPAlertAction * _Nonnull a) {

        }];

        CPNavigationAlert* alert = [[CPNavigationAlert alloc] initWithTitleVariants:titles subtitleVariants:subtitles imageSet:nil primaryAction:action secondaryAction:cancel duration:10];
        [map presentNavigationAlert:alert animated:YES];

    }];
    right.title = @"Nach Hause 🏡";

    map.leadingNavigationBarButtons = @[ left ];
    map.trailingNavigationBarButtons = @[ right ];

    return map;
}

-(void)carplayNavigateTo:(NSString*)address
{
    CLLocationCoordinate2D macoun = CLLocationCoordinate2DMake(50.107231, 8.689365);
    MKPlacemark* macounPlacemark = [[MKPlacemark alloc] initWithCoordinate:macoun];
    CLLocationCoordinate2D home = CLLocationCoordinate2DMake(50.090517, 8.679889);
    MKPlacemark* homePlacemark = [[MKPlacemark alloc] initWithCoordinate:home];

    MKDirectionsRequest* request = [[MKDirectionsRequest alloc] init];
    request.source = [[MKMapItem alloc] initWithPlacemark:macounPlacemark];
    request.destination = [[MKMapItem alloc] initWithPlacemark:homePlacemark];

    CPRouteChoice* fastChoice = [[CPRouteChoice alloc] initWithSummaryVariants:@[ @"Standard" ] additionalInformationVariants:@[ @"Der schnellste Weg" ] selectionSummaryVariants:@[ @"Echt ruckzuck!" ]];
    CPRouteChoice* slowChoice = [[CPRouteChoice alloc] initWithSummaryVariants:@[ @"Rundfahrt" ] additionalInformationVariants:@[ @"Der langsamste Weg" ] selectionSummaryVariants:@[ @"Echt Landschaft!" ]];
    CPTrip* trip = [[CPTrip alloc] initWithOrigin:request.source destination:request.destination routeChoices:@[ fastChoice, slowChoice ]];

#if 0
    CPMapTemplate* map = (CPMapTemplate*)_cpInterfaceController.rootTemplate;
    _cpNavigationSession = [map startNavigationSessionForTrip:trip];

    [map showRouteChoicesPreviewForTrip:trip textConfiguration:nil];
#endif
}


@end
