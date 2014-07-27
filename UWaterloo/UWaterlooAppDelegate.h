//
//  UWaterlooAppDelegate.h
//  UWaterloo
//
//  Created by Jack Zhang on 7/13/14.
//  Copyright (c) 2014 Jack Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UWaterlooAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
