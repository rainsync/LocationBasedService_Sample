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
@synthesize poiTypeSegControl;

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
    self.poiTypeSegControl.selectedSegmentIndex = 0;
    [self.poiTypeSegControl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = self.poiTypeSegControl;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCampusMapView:nil];
    poiTypeSegControl = nil;
    [super viewDidUnload];
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
    } else if ([annotation isKindOfClass:[LSPrinter class]]) {
        LocationAnnotationIdentifier = @"PrinterAnnotation";
    } else {
        return nil;
    }
    
    MKAnnotationView *annotationView = [campusMapView dequeueReusableAnnotationViewWithIdentifier:LocationAnnotationIdentifier];
    if (!annotationView) {
        MKAnnotationView *customAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:LocationAnnotationIdentifier];
        customAnnotationView.centerOffset = CGPointMake(0, -10);
        customAnnotationView.canShowCallout = YES;
        customAnnotationView.image = [(LSLocation *)annotation annotationImage];
        
        UIButton *rightDetailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        customAnnotationView.rightCalloutAccessoryView = rightDetailButton;
        return customAnnotationView;
    } else {
        annotationView.annotation = annotation;
    }
    return annotationView;
}

//하늘에서 핀이 떨어지는 애니메이션 구현
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView;
    float animationDelay = 0.0;
    for (annotationView in views) {
        CGRect endFrame = annotationView.frame;
        
        annotationView.frame = CGRectMake(annotationView.frame.origin.x,
                                          annotationView.frame.origin.y - 400.0,
                                          annotationView.frame.size.width,
                                          annotationView.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationDelay:animationDelay];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [annotationView setFrame:endFrame];
        [UIView commitAnimations];
        animationDelay = animationDelay + 0.02;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
}

- (IBAction)poiUpdate:(id)sender {
    [campusMapView removeAnnotations:campusMapView.annotations];
    int poiType = self.poiTypeSegControl.selectedSegmentIndex;
    NSArray *selectedPOIs;
    switch (poiType) {
        case 0:
            selectedPOIs = [self appDelegate].libraryPOIs;
            break;
        case 1:
            selectedPOIs = [self appDelegate].restaurantPOIs;
            break;
        case 2:
            selectedPOIs = [self appDelegate].printerPOIs;
            break;
    }
    [campusMapView addAnnotations:selectedPOIs];
}
@end
