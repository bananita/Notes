//
//  MBNoteCell.m
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import "MBNoteCell.h"

@interface MBNoteCell ()
{
    __weak IBOutlet UILabel *idLabel;
    __weak IBOutlet UITextView *textTextView;
}
@end

@implementation MBNoteCell

- (void)fillCellWithNotesId:(NSNumber *)anId
                       text:(NSString *)text
{
    idLabel.text = [anId stringValue];
    textTextView.text = text;
}

@end
