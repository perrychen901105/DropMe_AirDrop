//
//  BaseViewController.h
//  DropMe
//
//  Created by Perry on 14-9-12.
//  Copyright (c) 2014年 Razeware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  @property objectsToShare
 *  @brief An array of objects that will be shared via AirDrop when the avtivity view controller is presented
 */

@property (nonatomic, strong) NSArray *objectsToShare;

@end
