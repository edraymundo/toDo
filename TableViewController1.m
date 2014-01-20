//
//  TableViewController1.m
//  toDo
//
//  Created by kex on 1/15/14.
//  Copyright (c) 2014 kex. All rights reserved.
//

#import "TableViewController1.h"
#import "CustomCell.h"
#import <objc/runtime.h>

@interface TableViewController1 ()

@property(nonatomic,strong)NSMutableArray *tableData;

@end

@implementation TableViewController1

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"To Do List";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //load data from file
    [self loadData];
    
    //add XIB file
    UINib *customNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"CustomCell"];
    
    //add buttons
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
}

- (void) loadData{
     //get data from file
     self.tableData = [NSMutableArray arrayWithContentsOfFile:@"/tmp/test.data"];
}

- (void) saveData{
    //save data to file
    [self.tableData writeToFile:@"/tmp/test.data" atomically:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //get index of textfield that was edited and save tableData to file
    NSIndexPath *cellPath = objc_getAssociatedObject(textField, "key");
    NSUInteger row = cellPath.row;
    [self.tableData setObject:textField.text atIndexedSubscript:row];
    [self.tableView reloadData];
    [self saveData];
}

//this method gets called when "+" is touched, it pushes new row to tableData
- (void)addItem:sender {
    
    [self.tableData insertObject:@"" atIndex:0];
    
    [self.tableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *tablecell =  [self.tableView cellForRowAtIndexPath:indexPath];
    CustomCell *cell = (CustomCell *)tablecell;
    [cell.todoField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.todoField.delegate = self;
    cell.todoField.text = [self.tableData objectAtIndex:indexPath.row];

    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
         NSLog(@"Delete");
        // Delete the row from the data source
        [self.tableData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
           NSLog(@"Insert");
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [self saveData]; //save data
    [tableView reloadData]; //reload
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


@end
