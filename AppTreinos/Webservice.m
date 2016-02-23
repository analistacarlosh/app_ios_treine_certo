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
    // return urlBaseWebService = @"http://www.appsaude.net/admin/rest/";
}

-(NSString*) conectWebService:(NSString*)urlwebservice parameters:(NSString *)parameters token:(NSString *)token
{
    Alert *alert = [[ Alert alloc] init];
    NSString *responseData;
    
    BOOL returnConnectedToInternet = [self connectedToInternet];
    
    if(returnConnectedToInternet == TRUE){
        
        NSString *post =[[NSString alloc] initWithFormat:@"token=%@&%@", token, parameters];
        NSString *urlfull    = [NSString stringWithFormat: @"http://www.appsaude.net/admin/rest/%@", urlwebservice];
        NSURL *url = [NSURL URLWithString:urlfull];
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
            responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            return responseData;
        } else {
            // NSLog(@"Falha na comunicação com o servidor!");
            [alert alertStatus:@"Falha!" :@"Falha na comunicação com o servidor, tente novamente!"];
            responseData = @"false";
        }
        
    } else {
        [alert alertStatus:@"Sem conexão com a internet" :@"Login"];
    }
    
    return responseData;
}

@end
