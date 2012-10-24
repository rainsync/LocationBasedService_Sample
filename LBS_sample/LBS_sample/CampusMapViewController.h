//
//  CampusMapViewController.h
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h> 

@interface CampusMapViewController : UIViewController
{
    MKMapView *campusMapView;
    UISegmentedControl *poiTypeSegControl;
}
- (IBAction)poiUpdate:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *campusMapView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *poiTypeSegControl;
@end
