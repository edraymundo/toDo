//
//  TableViewController1.m
//  toDo
//
//  Created by kex on 1/15/14.
//  Copyright (c) 2014 kex. All rights reserved.
//

#import "TableViewController1.h"
#import "CustomCell.h"

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
    
    //self.tableData = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    //[self.tableData writeToFile:@"/tmp/test.data" atomically:YES];
    
    [self loadData];
    
    NSLog(@"%@",self.tableData);
    
    //self.tableData = [NSMutableArray arrayWithObjects:@" ",nil];
    //[self.tableData insertObject:@"" atIndex:0];
    
    
    UINib *customNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"CustomCell"];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
}

- (void) loadData{
     self.tableData = [NSMutableArray arrayWithContentsOfFile:@"/tmp/test.data"];
}

- (void) saveData{
    [self.tableData writeToFile:@"/tmp/test.data" atomically:YES];
}


//this method gets called when "+" is touched
- (void)addItem:sender {
    
    [self.tableData insertObject:@"" atIndex:0];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)onEditButton {
  //  NSLog(@"test");
// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//}

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
    
   // NSLog(@"%@",retArray);
    cell.todoField.text = [self.tableData objectAtIndex:indexPath.row];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSLog(@"im in1");
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
/*
- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    if(editing)
    {
        NSLog(@"editMode on");
    }
    else
    {
        NSLog(@"Done leave editmode");
        //NSLog(@"%@",self.tableData);
        [self saveData];
    }
}
 */

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
    
  //  [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

   // if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
     //   NSLog(@"im in2");
      //  [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //}
    //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}

/*

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
