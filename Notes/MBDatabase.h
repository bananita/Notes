//
//  MBDatabase.h
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBNote.h"

@interface MBDatabase : NSObject

- (id)initWithDataModelName:(NSString*)name;

@property(readonly) NSManagedObjectContext* mainManagedObjectContext;

@end
