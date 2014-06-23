//
//  Webservice.m
//  AppTreinos
//
//  Created by Mac Book Pro on 22/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "Webservice.h"
#import "Alert.h"

@implementation Webservice

- (BOOL) connectedToInternet
{
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
    return ( URLString != NULL ) ? YES : NO;
}

-(NSString *) getUrlBaseWebService
{
    return urlBaseWebService = @"http://www.appsaude.net/admin/rest/";
}

-(NSString*) conectWebService:(NSString*)urlwebservice parameters:(NSString *)parameters
{
    Alert *alert = [[ Alert alloc] init];
    
    // @"user=%@", idUser
    NSString *post =[[NSString alloc] initWithFormat:@"%@", parameters];
    
    // url
    //http://www.appsaude.net/admin/rest/get-training-by-user/
    
    NSURL *url = [NSURL URLWithString:urlwebservice];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([response statusCode] >=200 && [response statusCode] <300) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        return responseData;
    } else {
        // NSLog(@"Falha na comunicação com o servidor!");
        [alert alertStatus:@"Falha!" :@"Falha na comunicação com o servidor, tente novamente!"];
        return @"false";
    }
}

@end
