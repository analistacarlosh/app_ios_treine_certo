//
//  Treino.m
//  AppTreinos
//
//  Created by Mac Book Pro on 18/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "Treino.h"

@implementation Treino

- (void)showTraining
{
    self.training = [SCSQLite selectRowSQL:@"SELECT * FROM tbl_treinos"];
    NSLog(@"Training ==> %@", self.training);
}

- (void)deleteTraining
{
    self.training = [SCSQLite selectRowSQL:@"DELETE FROM tbl_treinos"];
    NSLog(@"DELETE Training ==> %@", self.training);
}

@end
