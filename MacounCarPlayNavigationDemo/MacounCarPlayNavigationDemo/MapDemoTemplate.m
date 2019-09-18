//
//  MapDemoTemplate.m
//  MacounCarPlayNavigationDemo
//
//  Created by Dr. Michael Lauer on 17.09.19.
//  Copyright © 2019 Vanille-Media. All rights reserved.
//

#import "MapDemoTemplate.h"

static id instance;
static CPMapTemplate* map;

@implementation MapDemoTemplate
{
    CPNavigationSession* _session;
}

+(CPTemplate*)tp
{
    map = [[CPMapTemplate alloc] init];
    map.mapDelegate = instance = [[self alloc] init];
    map.automaticallyHidesNavigationBar = NO;

    CPBarButton* panButton = [[CPBarButton alloc] initWithType:CPBarButtonTypeText handler:^(CPBarButton * _Nonnull barButton) {

        if ( map.panningInterfaceVisible )
        {
            map.leadingNavigationBarButtons.firstObject.title = @"Pan";
            [map dismissPanningInterfaceAnimated:YES];
        }
        else
        {
            map.leadingNavigationBarButtons.firstObject.title = @"Exit";
            [map showPanningInterfaceAnimated:YES];
        }

    }];
    panButton.title = @"Pan";

    CPBarButton* right = [[CPBarButton alloc] initWithType:CPBarButtonTypeText handler:^(CPBarButton * _Nonnull barButton) {

        NSArray<NSString*>* titles = @[ @"Nach Hause!", @"Heim" ];
        NSArray<NSString*>* subtitles = @[ @"Möchten Sie nach Hause navigiert werden?", @"Jetzt nach Hause?" ];
        CPAlertAction* action = [[CPAlertAction alloc] initWithTitle:@"Yo!" style:CPAlertActionStyleDefault handler:^(CPAlertAction * _Nonnull a) {

            [instance carplayNavigate];

        }];
        CPAlertAction* cancel = [[CPAlertAction alloc] initWithTitle:@"Jetzt nicht!" style:CPAlertActionStyleCancel handler:^(CPAlertAction * _Nonnull a) {

        }];

        CPNavigationAlert* alert = [[CPNavigationAlert alloc] initWithTitleVariants:titles subtitleVariants:subtitles imageSet:nil primaryAction:action secondaryAction:cancel duration:10];
        [map presentNavigationAlert:alert animated:YES];

    }];
    right.title = @"Nach Hause 🏡";

    map.leadingNavigationBarButtons = @[ panButton ];
    map.trailingNavigationBarButtons = @[ right ];

    return map;
}

#pragma mark -
#pragma mark <CPMapTemplateDelegate>

-(BOOL)mapTemplate:(CPMapTemplate *)mapTemplate shouldShowNotificationForManeuver:(CPManeuver *)maneuver
{
    return YES;
}

-(BOOL)mapTemplate:(CPMapTemplate *)mapTemplate shouldUpdateNotificationForManeuver:(CPManeuver *)maneuver withTravelEstimates:(CPTravelEstimates *)travelEstimates
{
    return YES;
}

-(BOOL)mapTemplate:(CPMapTemplate *)mapTemplate shouldShowNotificationForNavigationAlert:(CPNavigationAlert *)navigationAlert
{
    return YES;
}

#pragma mark - Panning

-(void)mapTemplateDidShowPanningInterface:(CPMapTemplate *)mapTemplate
{

}

-(void)mapTemplateWillDismissPanningInterface:(CPMapTemplate *)mapTemplate
{

}

-(void)mapTemplateDidDismissPanningInterface:(CPMapTemplate *)mapTemplate
{

}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate panBeganWithDirection:(CPPanDirection)direction
{

}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate panEndedWithDirection:(CPPanDirection)direction
{

}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate panWithDirection:(CPPanDirection)direction
{

}

-(void)mapTemplateDidBeginPanGesture:(CPMapTemplate *)mapTemplate
{

}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate didUpdatePanGestureWithTranslation:(CGPoint)translation velocity:(CGPoint)velocity
{

}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate didEndPanGestureWithVelocity:(CGPoint)velocity
{

}

#pragma mark - Alerts

-(void)mapTemplate:(CPMapTemplate *)mapTemplate willShowNavigationAlert:(CPNavigationAlert *)navigationAlert
{
    NSLog( @"Will show alert %@", navigationAlert );
}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate didShowNavigationAlert:(CPNavigationAlert *)navigationAlert
{
    NSLog( @"Did show alert %@", navigationAlert );
}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate willDismissNavigationAlert:(CPNavigationAlert *)navigationAlert dismissalContext:(CPNavigationAlertDismissalContext)dismissalContext
{

}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate didDismissNavigationAlert:(CPNavigationAlert *)navigationAlert dismissalContext:(CPNavigationAlertDismissalContext)dismissalContext
{

}

#pragma mark - Trips

-(void)mapTemplate:(CPMapTemplate *)mapTemplate selectedPreviewForTrip:(CPTrip *)trip usingRouteChoice:(CPRouteChoice *)routeChoice
{
    NSLog( @"Selected preview %@ using route choice %@", trip, routeChoice );
}

-(void)mapTemplate:(CPMapTemplate *)mapTemplate startedTrip:(CPTrip *)trip usingRouteChoice:(CPRouteChoice *)routeChoice
{
    NSLog( @"Started trip %@ using route choice %@", trip, routeChoice );

    [mapTemplate hideTripPreviews];
    NSUnit* length = [[NSUnit alloc] initWithSymbol:@"km"];
    NSMeasurement* measurement = [[NSMeasurement alloc] initWithDoubleValue:12.0 unit:length];
    CPTravelEstimates* estimates = [[CPTravelEstimates alloc] initWithDistanceRemaining:measurement timeRemaining:25*60];
    [mapTemplate updateTravelEstimates:estimates forTrip:trip withTimeRemainingColor:CPTimeRemainingColorOrange];

    NSMutableArray<CPManeuver*>* maneuvers = [NSMutableArray array];
    CPManeuver* m1 = [[CPManeuver alloc] init];
    m1.attributedInstructionVariants = @[ [[NSAttributedString alloc] initWithString:@"Biegen Sie auf das Sachsenhäuser Ufer ein, sobald sie dieses Schild sehen!"] ];
    m1.junctionImage = [UIImage imageNamed:@"rosalie"];
    [maneuvers addObject:m1];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _session.upcomingManeuvers = maneuvers;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _session.upcomingManeuvers = @[];
        });

    });
}

-(void)mapTemplateDidCancelNavigation:(CPMapTemplate *)mapTemplate
{

}

#pragma mark - Display Style

-(CPManeuverDisplayStyle)mapTemplate:(CPMapTemplate *)mapTemplate displayStyleForManeuver:(CPManeuver *)maneuver
{
    return CPManeuverDisplayStyleDefault;
}

#pragma mark -
#pragma mark Helpers

-(void)carplayNavigate
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

    _session = [map startNavigationSessionForTrip:trip];

    [map showRouteChoicesPreviewForTrip:trip textConfiguration:nil];
}


@end
