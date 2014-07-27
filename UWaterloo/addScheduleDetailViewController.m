//
//  addScheduleDetailViewController.m
//  UWaterloo
//
//  Created by Jack Zhang on 7/24/14.
//  Copyright (c) 2014 Jack Zhang. All rights reserved.
//
#define kDatePickerIndex 2
#define kEndDatePickerIndex 4
#define EndDatePickerHeight 166
#define DatePickerHeight 166
#import "addScheduleDetailViewController.h"

@interface addScheduleDetailViewController ()
{

}

@end

@implementation addScheduleDetailViewController

@synthesize taskTimeLabel=_taskTimeLabel;
@synthesize datePicker=_datePicker;
@synthesize locationLabel=_locationLabel;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    //self.tableView.userInteractionEnabled = YES;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTimeLabel];
    [self signUpForKeyboardNotifications];
    //self.tableView.separatorColor = [UIColor clearColor];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wood2.jpg"]];
    [tempImageView setFrame:self.tableView.frame];

    self.tableView.backgroundView = tempImageView;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)save:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:context];
    [newDevice setValue:self.taskName.text forKey:@"taskName"];
    [newDevice setValue:self.locationLabel.text forKey:@"taskLocation"];
    [newDevice setValue:self.selectedDate forKey:@"taskDate"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupTimeLabel {
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //[self.dateFormatter setTimeFormat:@"HH:mm"];
    //[self.dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *defaultDate = [NSDate date];
    
    self.taskTimeLabel.text = [self.dateFormatter stringFromDate:defaultDate];
    self.endDateLabel.text=[self.dateFormatter stringFromDate:defaultDate];
    //self.taskTimeLabel.textColor = [self.tableView tintColor];
    
    self.selectedDate = defaultDate;
    self.selectedEndDate=defaultDate;
    self.endDatePicker.minimumDate=defaultDate;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = self.tableView.rowHeight;
    
    if (indexPath.row == kDatePickerIndex){
        if (self.datePickerIsShowing==0){
            height=0.0f;
        } else {
            height=DatePickerHeight;
        }
    }
    
    if (indexPath.row == kEndDatePickerIndex){
        if (self.endDatePickerIsShowing==0){
            height=0.0f;
        } else {
            height=EndDatePickerHeight;
        }
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1){
        
        if (self.datePickerIsShowing){
            
            
            [self hideDatePickerCell];
            
        }else {
            
            [self hideEndDatePickerCell];
            [self showDatePickerCell];
        }
    }
    if (indexPath.row == 3){
        
        if (self.endDatePickerIsShowing){
            
            
            [self hideEndDatePickerCell];
            
        }else {
            
            [self hideDatePickerCell];
            [self showEndDatePickerCell];
        }
    }
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)showDatePickerCell {
    self.taskTimeLabel.textColor = [UIColor redColor];
    //[self.activeTextField resignFirstResponder];
    
    self.datePickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    
    [self.tableView endUpdates];
    
    self.datePicker.hidden = NO;
    self.datePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.datePicker.alpha = 1.0f;
        
    }];
}

- (void)hideDatePickerCell {
    self.taskTimeLabel.textColor = [UIColor blackColor];
    self.datePickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.datePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.datePicker.hidden = YES;
                     }];
}

- (void)showEndDatePickerCell {
    //[self.activeTextField resignFirstResponder];
    self.endDateLabel.textColor=[UIColor redColor];
    self.endDatePickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    
    [self.tableView endUpdates];
    
    self.endDatePicker.hidden = NO;
    self.endDatePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.endDatePicker.alpha = 1.0f;
        
    }];
}

- (void)hideEndDatePickerCell {
    self.endDateLabel.textColor=[UIColor blackColor];
    self.endDatePickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.endDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.endDatePicker.hidden = YES;
                     }];
}

- (void)signUpForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
}
- (void)keyboardWillShow {
    
    //if (self.datePickerIsShowing){
        [self hideEndDatePickerCell];
        [self hideDatePickerCell];
    //}
}
- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    self.taskTimeLabel.text=[self.dateFormatter stringFromDate:sender.date];
    self.selectedDate=sender.date;
    if ([self.selectedDate compare:self.selectedEndDate] == NSOrderedDescending) {
        self.endDatePicker.minimumDate=self.selectedDate;
        self.endDatePicker.date=self.selectedDate;
        self.endDateLabel.text=[self.dateFormatter stringFromDate:self.selectedDate];
        self.selectedEndDate=self.selectedDate;
        
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.activeTextField = textField;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.activeTextField isFirstResponder] && [touch view] != self.activeTextField) {
        [self.activeTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void) hideKeyboard {
    [self.taskName resignFirstResponder];
    [self.locationLabel resignFirstResponder];
}
- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
   [[self view] endEditing:YES];
}
- (IBAction)endDatePickerChanged:(UIDatePicker *)sender {
    self.endDateLabel.text=[self.dateFormatter stringFromDate:sender.date];
    self.selectedEndDate=sender.date;
}
@end
