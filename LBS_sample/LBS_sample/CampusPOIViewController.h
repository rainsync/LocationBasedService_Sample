//
//  CampusPOIViewController.h
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusPOIViewController : UITableViewController {
    int _titleRow[3];
}

@property BOOL libraryExpanded;
@property BOOL restaurantExpanded;
@property BOOL printerExpanded;

@property (readonly) int numOfLibrary;
@property (readonly) int numOfRestaurant;
@property (readonly) int numOfPrinter;

@end
