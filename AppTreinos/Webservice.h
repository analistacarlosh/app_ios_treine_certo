//
//  Webservice.h
//  AppTreinos
//
//  Created by Mac Book Pro on 22/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Webservice : NSObject
{
    NSString *urlBaseWebService;
}

- (BOOL) connectedToInternet;

-(NSString*) conectWebService:(NSString*)urlwebservice parameters:(NSString *)parameters;

-(NSString *) getUrlBaseWebService;

@end
