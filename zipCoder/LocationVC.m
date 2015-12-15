//
//  LocationVC.m
//  zipCoder
//
//  Created by Pradip Moradiya on 9/10/15.
//  Copyright (c) 2015 Pradip Moradiya. All rights reserved.
//

#import "LocationVC.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationVC ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    BOOL isFirstTime;
}
@end

@implementation LocationVC

#pragma mark - Initial loading methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view endEditing:YES];
    
    isFirstTime = YES;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    //Initialize code for location manager will check location at some time of interval automaically
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    
    if ((currentLocation.coordinate.latitude != newLocation.coordinate.latitude) && (currentLocation.coordinate.longitude != newLocation.coordinate.longitude))
    {
        NSLog(@"New location updated!!!");
        currentLocation = newLocation;
        
        if (currentLocation != nil)
        {
            NSLog(@"%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
            NSLog(@"%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        }
        [self strtFetchingZipcode];
    }
    else
    {
        if (isFirstTime) {
            isFirstTime=NO;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES ];
        }
        
        NSLog(@"Location same!!!");
    }
}

#pragma mark - this method will get zipcode base on location

-(void)strtFetchingZipcode
{
    CLLocationCoordinate2D coord;
    coord.longitude = currentLocation.coordinate.longitude;
    coord.latitude = currentLocation.coordinate.latitude;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:currentLocation // You can pass aLocation here instead
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       dispatch_async(dispatch_get_main_queue(),^ {
                           // do stuff with placemarks on the main thread
                           
                           if (placemarks.count == 1) {
                               
                               CLPlacemark *place = [placemarks objectAtIndex:0];
                               
                               //NSString *zipString = [place.addressDictionary valueForKey:@"ZIP"];
                               [_btnAddress setTitle:[NSString stringWithFormat:@"%@, %@",[place administrativeArea],[place subLocality]] forState:UIControlStateNormal];
                               
                               if ([place postalCode] != nil)
                               {
                                   [_btnZipcode setTitle:[NSString stringWithFormat:@"%@",[place postalCode]] forState:UIControlStateNormal];
                               }
                               else
                               {
                                   UIAlertView *errorAlert = [[UIAlertView alloc]
                                                              initWithTitle:@"Error" message:@"Failed to Get Zip Code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                   [errorAlert show];
                               }
                               
                               if (isFirstTime) {
                                   isFirstTime=NO;
                                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES ];
                               }
                           }
                       });
                   }
     ];
}

- (NSString *)deviceLocation
{
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
}

-(IBAction)btnZipcodeClicked:(id)sender
{
    isFirstTime = YES;
    
//    [_btnAddress setTitle:@"" forState:UIControlStateNormal];
//    [_btnZipcode setTitle:@"" forState:UIControlStateNormal];

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Do any additional setup after loading the view.
    NSLog(@"%@", [self deviceLocation]);
    NSLog(@"%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
    NSLog(@"%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
    [locationManager startUpdatingLocation];
}

@end
