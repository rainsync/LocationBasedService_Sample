//
//  LSLocation.m
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "LSLocation.h"

@implementation LSLocation
@synthesize title = _title, subtitle = _subtitle;
@synthesize latitude = _latitude, longitude = _longitude;
@synthesize location = _location;
@synthesize addressOfLocation = _addressOfLocation;

- (id)init
{
    self = [super init];
    if (self != nil ) {
        _latitude = 37.558;
        _longitude = 123.000;
        [self addObserver:self forKeyPath:@"latitude" options:0 context:nil];
        [self addObserver:self forKeyPath:@"longitude" options:0 context:nil];
        self.title = @"POI";
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_latitude != 0 && _longitude != 0 ) {
        CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
        CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:_latitude longitude:_longitude];
        [reverseGeocoder reverseGeocodeLocation:coordinate completionHandler:^(NSArray* placemarks, NSError* error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                _addressOfLocation = [[NSString alloc] initWithFormat:@"%@, %@, %@, %@", placemark.locality, placemark.subLocality, placemark.thoroughfare, placemark.subThoroughfare];
            }
        }];
    }
}

#pragma mark MKAnnotation Protocol
- (CLLocationCoordinate2D) coordinate
{
    CLLocationCoordinate2D theCoordinate = CLLocationCoordinate2DMake(_latitude, _longitude);
    return theCoordinate;
}

- (NSString *)subtitle
{
    NSString *subtitleString;
    if (_location != nil) {
        subtitleString = _location;
    }
    else {
        subtitleString = @"No Address";
    }
    
    return subtitleString;
}
@end
