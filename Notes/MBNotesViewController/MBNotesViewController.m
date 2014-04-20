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
#import "MBNotesFetchedResultsController.h"
#import "MBNoteCell.h"

@interface MBNotesViewController () <NSFetchedResultsControllerDelegate>
{
    MBDatabase* database;
    MBNotesFetchedResultsController* fetchedResultsController;
}
@end

@implementation MBNotesViewController

- (void)viewDidLoad
{
    [self createDatabase];
    [self importNotes];
    [self createFetchedResultsController];
    [self performFetch];
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

- (void)createFetchedResultsController
{
    fetchedResultsController = [[MBNotesFetchedResultsController alloc]
                                initWithManagedObjectContext:database.mainManagedObjectContext
                                delegate:self];
}

- (void)performFetch
{
    [fetchedResultsController performFetch:nil];
}

- (void)fillNoteCell:(MBNoteCell*)cell
 withNoteAtIndexPath:(NSIndexPath*)indexPath
{
    MBNote* note = [fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell fillCellWithNotesId:note.id
                         text:note.text];
}

#pragma mark UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    id sectionInfo = [fetchedResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBNoteCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MBNoteCell"];
    
    [self fillNoteCell:cell
   withNoteAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark NSFetchedResultsController delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self fillNoteCell:(MBNoteCell*)[self.tableView cellForRowAtIndexPath:indexPath]
           withNoteAtIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
