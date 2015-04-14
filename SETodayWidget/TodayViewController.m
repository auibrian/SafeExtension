//
//  TodayViewController.m
//  SETodayWidget
//
//  Created by Anluan O'Brien on 4/14/15.
//  Copyright (c) 2015 Anluan O'Brien. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property UIBackgroundTaskIdentifier taskIdentifier;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Class clazz = NSClassFromString(@"UIApplication");
    if ([clazz respondsToSelector:@selector(sharedApplication)]) {
        id sharedApp = [clazz performSelector:@selector(sharedApplication)];
        NSLog(@"sharedapp: %@",sharedApp);
        
        self.taskIdentifier = [(UIApplication*)sharedApp beginBackgroundTaskWithExpirationHandler:^{
            [self endBackgroundTask];
        }];
        NSLog(@"task: %@",@(self.taskIdentifier));
        
        [self endBackgroundTask];
    }
}

-(void)endBackgroundTask
{
    NSLog(@"Ending");
    Class clazz = NSClassFromString(@"UIApplication");
    id sharedApp = [clazz performSelector:@selector(sharedApplication)];
    [(UIApplication*)sharedApp endBackgroundTask: self.taskIdentifier];
    self.taskIdentifier = UIBackgroundTaskInvalid;
    NSLog(@"taskIdPostEnd:%@",@(self.taskIdentifier));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
