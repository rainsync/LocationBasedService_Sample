//
//  LSRestaurant.m
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "LSRestaurant.h"

@implementation LSRestaurant

@synthesize restaurantName = _restaurantName;
@synthesize store = _store;
@synthesize annotationImage = _annotationImage;

- (UIImage *)annotationImage
{
    if (_annotationImage == nil) {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"restaurant_annotation" ofType:@"png"];
        _annotationImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    }
    
    return _annotationImage;
}

- (NSString *)title
{
    return self.restaurantName;
}
@end
