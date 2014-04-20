//
//  MBNotesImporter.m
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import "MBNotesImporter.h"

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
    
}

@end
