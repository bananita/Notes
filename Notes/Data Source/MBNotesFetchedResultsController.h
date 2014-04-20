//
//  MBNotesFetchedResultsController.h
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MBNotesFetchedResultsController : NSFetchedResultsController

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context
                          delegate:(id<NSFetchedResultsControllerDelegate>)delegate;

@end
