//
//  LSLocation.h
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LSLocation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (copy) NSString *title;
@property (copy) NSString *subtitle;
@property (copy) NSString *location;
@property (strong, readonly) NSString *addressOfLocation;

@property CLLocationDegrees longitude;
@property CLLocationDegrees latitude;

@property (strong, readonly) UIImage *annotationImage;

@end
