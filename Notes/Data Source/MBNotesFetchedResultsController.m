//
//  MBNotesFetchedResultsController.m
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import "MBNotesFetchedResultsController.h"

@implementation MBNotesFetchedResultsController

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context
                          delegate:(id<NSFetchedResultsControllerDelegate>)delegate;
{
    self = [super initWithFetchRequest:[self createFetchRequestInContext:context]
                  managedObjectContext:context
                    sectionNameKeyPath:nil
                             cacheName:@"Root"];
    
    if (!self)
        return nil;
    
    self.delegate = delegate;
    
    return self;
}

- (NSFetchRequest*)createFetchRequestInContext:(NSManagedObjectContext*)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MBNote"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"id"
                              ascending:YES];
    [fetchRequest setSortDescriptors:@[sort]];
    
    [fetchRequest setFetchBatchSize:20];

    return fetchRequest;
}

@end
