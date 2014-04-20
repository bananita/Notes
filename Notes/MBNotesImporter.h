//
//  MBNotesImporter.h
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBNotesImporter : NSObject

- (id)initWithMainManagedObjectContext:(NSManagedObjectContext*)context;

- (void)importsNotesFromArray:(NSArray*)array;

@end
