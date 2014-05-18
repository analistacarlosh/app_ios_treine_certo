//
//  APPTViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 11/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "APPTViewController.h"
#import "SBJson.h"
#import "SCSQLite.h"
#import "DetalheTreinoViewController.h"

@interface APPTViewController ()

@end

@implementation APPTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)btnEntrar:(id)sender {
    
    @try {
        
        if([[_txtEmail text] isEqualToString:@""] || [[_txtSenha text] isEqualToString:@""] ) {
            [self alertStatus:@"Por favor informe o e-mail e senha" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"email=%@&password=%@",[_txtEmail text],[_txtSenha text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://www.appsaude.net/admin/rest/login/"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                SBJsonParser *jsonParser = [SBJsonParser new];
                //NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                //NSLog(@"%@",jsonData);
                
                //NSInteger status = [(NSNumber *) [jsonData objectForKey:@"esta_ativo"] integerValue];
                // NSDictionary *msg = [[dict objectForKey:@"M"] objectAtIndex:0];
                
                id jsonData = [jsonParser objectWithString:responseData error:nil];
                
                if([jsonData isKindOfClass:[NSDictionary class]]) {
                    NSLog(@"Dictionary");
                }
                else if([jsonData isKindOfClass:[NSArray class]]) {
                    NSLog(@"Array");
                }
                
                NSInteger status = [(NSNumber *) [[jsonData objectAtIndex:0] objectForKey:@"status"] integerValue];
                
                NSLog(@"status %d", status);
                
                
                if(status == 1) {
                    NSLog(@"Login SUCCESS");
                    [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    
                    /*ListaTreinosViewController *c = [[ListaTreinosViewController alloc] init];
                    c.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    [self presentViewController:c animated:YES completion:nil];*/
                    
                    [self performSegueWithIdentifier:@"listagemTreino" sender:sender];
                    
                    //[self performSegueWithIdentifier:@"listagemTreino" sender:sender];
                    
                } else {
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error"];
                    [self alertStatus:error_msg :@"Falha no login!"];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Falha na conexão" :@"Falha no login 2 !"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed 3." :@"Login Failed!"];
    }
}

- (IBAction)backgroundTab:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)cadTreino:(id)sender {
    
    BOOL isSave = [SCSQLite executeSQL:@"INSERT INTO  tbl_treinos (data_do_treino, hora_inicial_do_treino, hora_final_do_treino, descricao_do_treino, fk_tipo_de_treino, fk_id_treino, dia_da_semana, nome, descricao, fk_id_cliente, treino_status, icone_treino) VALUES ('2014-05-13', '10:10', '10:10', 'LONGO', 1, 1, 'SEGUNDA', 'CARLOS', 'LONGO DE 15 KM PARA PACE DE 4:00', 1, '0', 'teste.png') "];
    
    if(isSave){
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"Sucesso ao salvar");
    } else {
        NSLog(@"Erro ao salvar");
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



@end
