//
//  AppDelegate.h
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

- (NSDictionary *)readPOIList;

@property (strong, nonatomic) UIWindow *window;

@property (strong, readonly) NSDictionary *poiDictionary;
@property (weak, readonly) NSArray *allPOIs;
@property (weak, readonly) NSArray *libraryPOIs;
@property (weak, readonly) NSArray *restaurantPOIs;
@property (weak, readonly) NSArray *printerPOIs;

@end
