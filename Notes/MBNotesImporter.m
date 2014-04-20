//
//  MBNotesImporter.m
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import "MBNotesImporter.h"
#import "MBDatabase.h"

static NSString* kMBEntityName = @"MBNote";

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

- (void)importsNotesFromArray:(NSArray*)notesToImport
{
    NSManagedObjectContext* context = [self createChildObjectContext];
    
    [context performBlock:^{
        NSDictionary* existingNotes = [self fetchExistingNotesInContext:context];
        
        [notesToImport enumerateObjectsUsingBlock:^(NSDictionary* noteDictionary,
                                                    NSUInteger idx,
                                                    BOOL *stop) {
            id noteId = noteDictionary[@"id"];
            
            MBNote* note = existingNotes[noteId];
            
            if (!note) {
                note = [NSEntityDescription insertNewObjectForEntityForName:kMBEntityName inManagedObjectContext:context];
                note.id = noteId;
            }
            
            id text = noteDictionary[@"text"];
            note.text = [self isObjectNull:text]? nil : text;
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

- (NSDictionary*)fetchExistingNotesInContext:(NSManagedObjectContext*)context
{
    NSFetchRequest* request = [NSFetchRequest new];
    request.entity = [NSEntityDescription entityForName:kMBEntityName
                                 inManagedObjectContext:context];
    
    NSArray* notes = [context executeFetchRequest:request
                                            error:nil];
    
    NSMutableDictionary* existingNotes = [NSMutableDictionary new];
    
    [notes enumerateObjectsUsingBlock:^(MBNote* note,
                                                NSUInteger idx,
                                                BOOL *stop) {
        existingNotes[note.id] = note;
    }];
    
    return existingNotes;
}

- (BOOL)isObjectNull:(id)object
{
    return [object class] == [NSNull class];
}

@end
