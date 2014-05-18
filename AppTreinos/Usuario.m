//
//  Usuario.m
//  AppTreinos
//
//  Created by Mac Book Pro on 18/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "Usuario.h"
#import "SBJson.h"
#import "SCSQLite.h"

@implementation Usuario

-(void)showUsers
{
    self.users = [SCSQLite selectRowSQL:@"SELECT * FROM tbl_user"];
    NSLog(@"user ==> %@", self.users);
}

-(void)deleteUser
{
    self.users = [SCSQLite selectRowSQL:@"DELETE FROM tbl_user"];
    NSLog(@"DELETE user ==> %@", self.users);
}

@end
