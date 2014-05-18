//
//  Treino.h
//  AppTreinos
//
//  Created by Mac Book Pro on 18/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "SCSQLite.h"

@interface Treino : NSObject

@property (nonatomic, retain) NSArray *training;

- (void)showTraining;
- (void)deleteTraining;

@end
