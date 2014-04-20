//
//  MBNotesImporter.m
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import "MBNotesImporter.h"
#import "MBDatabase.h"

@interface MBNotesImporter ()
{
    NSManagedObjectContext* mainManagedObjectContext;
}
@end

@implementation MBNotesImporter

- (id)initWithMainManagedObjectContext:(NSManagedObjectContext*)context
{
    self = [super init];
    
    if (!self)
        return nil;
    
    mainManagedObjectContext = context;
    
    return self;
}

- (void)importsNotesFromArray:(NSArray*)array
{
    NSManagedObjectContext* context = [self createChildObjectContext];
    
    [context performBlock:^{
        [array enumerateObjectsUsingBlock:^(NSDictionary* noteDictionary,
                                            NSUInteger idx,
                                            BOOL *stop) {
            MBNote* note = [NSEntityDescription insertNewObjectForEntityForName:@"MBNote" inManagedObjectContext:context];
            
            note.id = noteDictionary[@"id"];
            note.text = noteDictionary[@"text"];
        }];
        
        [context save:nil];
        
        [mainManagedObjectContext performBlock:^{
            [mainManagedObjectContext save:nil];
        }];
    }];
}

- (NSManagedObjectContext*)createChildObjectContext
{
    NSManagedObjectContext* objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    objectContext.parentContext = mainManagedObjectContext;
    
    return objectContext;
}

@end
