//
//  aeflash_AppDelegate.h
//  aeflash
//
//  Created by Stephen Baker on 6/7/09.
//  Copyright America 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface aeflash_AppDelegate : NSObject 
{
    IBOutlet NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;

@end
