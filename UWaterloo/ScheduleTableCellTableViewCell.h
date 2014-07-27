//
//  ScheduleTableCellTableViewCell.h
//  UWaterloo
//
//  Created by Jack Zhang on 7/18/14.
//  Copyright (c) 2014 Jack Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *unitLabel;
@property (strong, nonatomic) IBOutlet UIButton *Edit;
@property (strong, nonatomic) IBOutlet UILabel *courseName;
@property (strong, nonatomic) IBOutlet UILabel *Date;
@property (strong, nonatomic) IBOutlet UILabel *countDown;
@property (strong, nonatomic) IBOutlet UILabel *location;

@end
