//
//  TreinoViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 07/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "TreinoViewController.h"
#import "DetalheTreinoViewController.h"
#import "SCSQLite.h"

@interface TreinoViewController ()

@end

@implementation TreinoViewController
@synthesize data;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // data = [[NSMutableArray alloc]initWithObjects:@"Tiro", @"Logno", @"Rodagem", nil];
    results = [SCSQLite selectRowSQL:@"SELECT * FROM tbl_treinos"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // return data.count;
    return results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celltreino" forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.textLabel.text = [data objectAtIndex:indexPath.row];
    //return cell;
    
    NSDictionary *treino = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = [treino objectForKey:@"nome"];
    //cell.detailTextLabel.text = [treino objectForKey:@"data_do_treino"];
    //CellId.textLabel.text = [treinos objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"detalheTreino"]){
        DetalheTreinoViewController *DetalheTreino = (DetalheTreinoViewController *) segue.destinationViewController;
        
        //NSIndexPath *indexPath = [self. indexPathForSelectedRow];
        
        NSIndexPath *indexPath = [self.tableviewtreinos indexPathForSelectedRow];
        DetalheTreino.treino = [results objectAtIndex:indexPath.row];
        
    }
}


@end
