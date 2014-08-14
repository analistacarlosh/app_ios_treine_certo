//
//  TreinoViewController.h
//  AppTreinos
//
//  Created by Mac Book Pro on 07/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class MBProgressHUD;

@interface TreinoViewController : UIViewController
{
   NSArray *results;
   NSInteger *countExerciseincluir;
   NSInteger *countExerciseatualizar;
    
   MBProgressHUD *HUD;
}

@property (strong, nonatomic) IBOutlet UITableView *tableviewtreinos;
@property (strong, nonatomic) NSMutableArray *data;

- (IBAction)btnUpdateTraining:(id)sender;

@end
