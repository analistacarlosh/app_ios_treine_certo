//
//  TreinoViewController.h
//  AppTreinos
//
//  Created by Mac Book Pro on 07/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreinoViewController : UIViewController
{
   NSArray *results;
}

@property (strong, nonatomic) IBOutlet UITableView *tableviewtreinos;
@property (strong, nonatomic) NSMutableArray *data;

@end
