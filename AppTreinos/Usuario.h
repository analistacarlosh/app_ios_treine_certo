//
//  Usuario.h
//  AppTreinos
//
//  Created by Mac Book Pro on 18/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "SCSQLite.h"

@interface Usuario : NSObject

@property (nonatomic, retain) NSArray *users;
- (void)showUsers;
- (void)deleteUser;

@end
