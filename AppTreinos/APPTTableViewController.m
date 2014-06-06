//
//  APPTTableViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 13/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "APPTTableViewController.h"
#import "SCSQLite.h"
#import "DetalheTreinoViewController.h"

@interface APPTTableViewController ()

@end

@implementation APPTTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    results = [SCSQLite selectRowSQL:@"SELECT * FROM tbl_treinos"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*treinos = [[NSMutableArray alloc] init];
    [treinos addObject:@"Lonao"];
    [treinos addObject:@"Fatlek"];
    [treinos addObject:@"Tiros"];
    [treinos addObject:@"Tiross"];*/
    
    
    [self setTitle:@"Treinos"];
}

-(void)viewWillAppear:(BOOL)animated {

    results = [SCSQLite selectRowSQL:@"SELECT * FROM tbl_treinos"];
    [self.tableView reloadData];
    [super viewWillAppear:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // return [treinos count];
    return results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celltraining" forIndexPath:indexPath];
    
    // Configure the cell...
    
    /*if (!CellId) {
        CellId = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"CellIdd"];
    }*/
    
    NSDictionary *treino = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = [treino objectForKey:@"descricao_do_treino"];
    cell.detailTextLabel.text = [treino objectForKey:@"data_do_treino"];
    //CellId.textLabel.text = [treinos objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"detalheTreino"]){
        DetalheTreinoViewController *DetalheTreino = (DetalheTreinoViewController *) segue.destinationViewController;
        
        //NSIndexPath *indexPath = [self. indexPathForSelectedRow];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetalheTreino.treino = [results objectAtIndex:indexPath.row];
        
    }
}

@end
