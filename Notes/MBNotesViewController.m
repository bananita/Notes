//
//  MBNotesViewController.m
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import "MBNotesViewController.h"
#import "MBDatabase.h"
#import "MBNotesImporter.h"
#import "MBNotesProvider.h"

@interface MBNotesViewController ()
{
    MBDatabase* database;
}
@end

@implementation MBNotesViewController

- (void)viewDidLoad
{
    [self createDatabase];
    [self importNotes];
}

- (void)createDatabase
{
    database = [[MBDatabase alloc] initWithDataModelName:@"Notes"];
}

- (void)importNotes
{
    MBNotesImporter* importer = [[MBNotesImporter alloc] initWithMainManagedObjectContext:database.mainManagedObjectContext];
    
    [importer importsNotesFromArray:[MBNotesProvider arrayWithNotes]];
}

@end
