//
//  BaseViewController.m
//  DropMe
//
//  Created by Perry on 14-9-12.
//  Copyright (c) 2014年 Razeware LLC. All rights reserved.
//

#import "BaseViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setObjectsToShare:(NSArray *)objectsToShare
{
    _objectsToShare = [objectsToShare copy];
    if ([objectsToShare count]) {
        [self displayActionButton];
    } else {
        [self hideActionButton];
    }
}

- (void)presentActivityViewControllerWithObjects:(NSArray *)objects
{
    // 1 - Create an instance of UIActivityViewController with the object.
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objects applicationActivities:nil];
    
    // 2 - Exclude all activities except AirDrop
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook, UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypePrint,
                                    UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList,
                                    UIActivityTypePostToFlickr, UIActivityTypePostToVimeo,
                                    UIActivityTypePostToTencentWeibo];
    
    controller.excludedActivityTypes = excludedActivities;
    controller.completionHandler = ^(NSString *activityType, BOOL completed){
        NSLog(@"activity type is %@",activityType);
        if ([activityType isEqualToString:@"com.apple.UIKit.activity.AirDrop"]) {
//            if (completed == YES) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//            }
        }
    };
    // 3 - Present it.
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)actionButtonTapped:(id)sender
{
    [self presentActivityViewControllerWithObjects:self.objectsToShare];
}

// create a UIBarButton item with UIBarButtonSystemItemAction and display it in the navigation bar
- (void)displayActionButton
{
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonTapped:)];
    [self.navigationItem setLeftBarButtonItem:actionButton animated:YES];
}

- (void)hideActionButton
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
