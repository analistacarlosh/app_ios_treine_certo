//
//  Alert.m
//  AppTreinos
//
//  Created by Mac Book Pro on 22/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "Alert.h"

@implementation Alert

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

@end
