//
//  RGAppDelegate.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 28.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGAppDelegate.h"

@implementation RGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    NSString* correctURL = @"http://s7.pikabu.ru/images/previews_comm/2014-06_6/14037819436158.jpg";
//    NSString* incorrectURL = @"http://s7.pikabu.ru/images/previews_comm/2014-06_6/14037819436158|eououe";
//    [NSURLConnection GET:correctURL query:nil]
//    .then(^id<NSObject>(UIImage* data){
//        NSLog(@"data: %@",data);
//        if ([data isKindOfClass:[UIImage class]]) {
//            return [NSError errorWithDomain:@"blabla" code:3 userInfo:nil];
//        }
//        return data;
//    })
//    .catch(^(NSError* error){
//        NSLog(@"Error: %@",error);
//    }).then(^(NSData* d){
//        return [NSError errorWithDomain:@"blabla" code:3 userInfo:nil];
//    });
    self.rootViewController = (PBRRootViewController*)self.window.rootViewController;
    NSLog(@"controller: %@",self.window.rootViewController);
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
