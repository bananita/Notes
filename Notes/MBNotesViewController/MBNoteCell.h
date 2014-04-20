//
//  MBNoteCell.h
//  Notes
//
//  Created by Michał Banasiak on 20/04/14.
//  Copyright (c) 2014 SO MANY APPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBNoteCell : UITableViewCell

- (void)fillCellWithNotesId:(NSNumber*)anId
                       text:(NSString*)text;

@end
