//
//  ScheduleTableCellTableViewCell.m
//  UWaterloo
//
//  Created by Jack Zhang on 7/18/14.
//  Copyright (c) 2014 Jack Zhang. All rights reserved.
//

#import "ScheduleTableCellTableViewCell.h"

@implementation ScheduleTableCellTableViewCell
@synthesize courseName=_courseName;
@synthesize countDown=_countDown;
@synthesize Date=_Date;
@synthesize location=_location;
@synthesize unitLabel=_unitLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView clipsToBounds];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
