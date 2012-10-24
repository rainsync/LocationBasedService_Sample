//
//  LSRestaurant.h
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSLocation.h"

@interface LSRestaurant : LSLocation

@property (copy) NSString *restaurantName;
@property BOOL store;

@end
