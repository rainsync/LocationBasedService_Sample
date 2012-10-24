//
//  CampusMapViewController.m
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "CampusMapViewController.h"
#import "AppDelegate.h"
#import "LSLibrary.h"
#import "LSRestaurant.h"
#import "LSPrinter.h"

@interface CampusMapViewController (Private)
- (AppDelegate *)appDelegate;
@end

@implementation CampusMapViewController
@synthesize campusMapView;

- (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Campus Map";
        self.tabBarItem.image = [UIImage imageNamed:@"map_view_tab_icon"];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(37.558, 127.000);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.003, 0.003);
    MKCoordinateRegion initialRegion = MKCoordinateRegionMake(center, span);
    
    campusMapView.region = initialRegion;
    
    [campusMapView addAnnotations:[self appDelegate].allPOIs];
}

#pragma mark -
#pragma mark MapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *LocationAnnotationIdentifier;
    if ([annotation isKindOfClass:[LSLibrary class]]) {
        LocationAnnotationIdentifier = @"LibraryAnnotation";
    } else if ([annotation isKindOfClass:[LSRestaurant class]]) {
        LocationAnnotationIdentifier = @"RestaurantAnnotation";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCampusMapView:nil];
    [super viewDidUnload];
}
@end
