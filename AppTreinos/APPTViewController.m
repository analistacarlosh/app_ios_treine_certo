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
#import "Usuario.h"
#import "Treino.h"
#import "TreinoViewController.h"

@interface APPTViewController ()

@end

@implementation APPTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    Usuario *usuario = [[Usuario alloc] init];
    NSArray *dataUser = [usuario getUser];
    
    if(dataUser.count > 0){
        [self performSegueWithIdentifier:@"listagemtreinos" sender:self];
    }
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
            
            //  LOGIN
            BOOL returnLoginUser = [self loginUser:(_txtEmail.text) senha_user:(_txtSenha.text)];

            if(returnLoginUser == TRUE){

                Usuario *usuario = [[Usuario alloc] init];
                NSArray *dataUser = [usuario getUser];
                
                NSString *pk_id_usuario = [[dataUser objectAtIndex:0] objectForKey:@"user_id"];
                
                // Consulta training no webservice e importa para SQLite
                BOOL returnImportTraining = [self importTraining:(pk_id_usuario)];
                
                if(returnImportTraining == TRUE){
                    
                    //TreinoViewController *c = [[TreinoViewController alloc] init];
                    //c.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    //[self presentViewController:c animated:YES completion:nil];
                    
                    [self performSegueWithIdentifier:@"listagemtreinos" sender:self];
                }
                
            } else {
                [self alertStatus:@"Login Failed 4." :@"Login Failed!"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed 3." :@"Login Failed!"];
    }
}

- (BOOL)loginUser:(NSString *)email
                senha_user:(NSString *)senha {

    NSString *post =[[NSString alloc] initWithFormat:@"email=%@&password=%@",[_txtEmail text],[_txtSenha text]];
    
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
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // NSLog(@"Response code: %d", [response statusCode]);
    if ([response statusCode] >=200 && [response statusCode] <300) {
        
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        id jsonData = [jsonParser objectWithString:responseData error:nil];
        
        NSInteger status = [(NSNumber *) [[jsonData objectAtIndex:0] objectForKey:@"status"] integerValue];
        
        if(status == 1) {
            
            // Save Data User
            NSString *login = [[jsonData objectAtIndex:0] objectForKey:@"email"];
            NSString *senha = [[jsonData objectAtIndex:0] objectForKey:@"senha"];
            NSString *pk_id_usuario = [[jsonData objectAtIndex:0] objectForKey:@"pk_id_usuario"];
            NSString *user_name = [[jsonData objectAtIndex:0] objectForKey:@"user_name"];
            NSString *fk_tipo_de_usuario = [[jsonData objectAtIndex:0] objectForKey:@"fk_tipo_de_usuario"];
            
            // Cadastrando dados do login do usuario
            Usuario *users = [[Usuario alloc] init];
            BOOL returnInsertUsers = [users insertUsers:(login) str_senha:(senha) str_pk_id_usuario:(pk_id_usuario) str_user_name:(user_name) str_fk_tipo_de_usuario:(fk_tipo_de_usuario)];
            NSLog(@"returnInsertUsers: %d", returnInsertUsers);
            
            [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
            
            return TRUE;
            
        } else {
            NSString *error_msg = (NSString *) [jsonData objectForKey:@"error"];
            [self alertStatus:error_msg :@"Falha no login!"];
            return FALSE;
        }
        
    } else {
        if (error) NSLog(@"Error: %@", error);
        [self alertStatus:@"Falha na conexão" :@"Falha no login 2 !"];
        return FALSE;
    }
}

- (BOOL)importTraining:(NSString *)idUser{

    NSString *post =[[NSString alloc] initWithFormat:@"user=%@", idUser];
    
    NSURL *url = [NSURL URLWithString:@"http://desenv.appsaude.admin/admin/rest/get-training-by-user/"];
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
        // NSLog(@"Response ==> %@", responseData);
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        id jsonData = [jsonParser objectWithString:responseData error:nil];
        
        NSInteger i = 0;
        NSString *skey;
        
        for( i = 0; i < [jsonData count]; i++ ) {
            
            if(i){
                skey = [NSString stringWithFormat:@"%d",i];
            } else {
                skey = @"";
            }
            
            NSDate *data_do_treino = [[jsonData objectAtIndex:i] objectForKey:@"data_do_exercicio"];
            NSString *hora_inicial_do_treino = [[jsonData objectAtIndex:i] objectForKey:@"horario"];
            NSString *fk_tipo_de_treino = [[jsonData objectAtIndex:i] objectForKey:@"fk_tipo_de_exercicio"];
            NSString *fk_id_treino = [[jsonData objectAtIndex:i] objectForKey:@"fk_id_treino"];
            NSString *dia_da_semana = [[jsonData objectAtIndex:i] objectForKey:@"dia_da_semana"];
            NSString *nome = [[jsonData objectAtIndex:i] objectForKey:@"nome_tipo_exercicio"];
            NSString *descricao_exercicio = [[jsonData objectAtIndex:i] objectForKey:@"descricao_exercicio"];
            NSString *fk_id_cliente = [[jsonData objectAtIndex:i] objectForKey:@"fk_id_cliente"];
            NSString *exercicio_status = [[jsonData objectAtIndex:i] objectForKey:@"exercicio_status"];
            
             NSLog(@" Before insert Training ");
            
            // Salvando Treino
            Treino *training = [[Treino alloc] init];
            BOOL returnTraining = [training insertTraining:(data_do_treino) hora_inicial_do_treino:(hora_inicial_do_treino)
                                         fk_tipo_de_treino:(fk_tipo_de_treino) fk_id_treino:(fk_id_treino)
                                             dia_da_semana:(dia_da_semana) nome:(nome) descricao:(descricao_exercicio)
                                             fk_id_cliente:(fk_id_cliente) treino_status:(exercicio_status)];

            NSLog(@"returnTraining: %d", returnTraining);
        }
        
        return true;
    } else {
         NSLog(@"Sem conexão!");
        return false;
    }
}

- (IBAction)backgroundTab:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)viewUsers:(id)sender {
    Usuario *users = [[Usuario alloc] init];
    [users showUsers];
    //NSLog(@"showUsers");
}

- (IBAction)viewTraining:(id)sender {
    Treino *treino = [[Treino alloc] init];
    [treino showTraining];
    //NSLog(@"showTraining");
}

- (IBAction)deleteUsers:(id)sender {
    Usuario *users = [[Usuario alloc] init];
    [users deleteUser];
    //NSLog(@"deleteUser");
}

- (IBAction)deleteTraining:(id)sender {
    Treino *treino = [[Treino alloc] init];
    [treino deleteTraining];
    //NSLog(@"deleteTraining");
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
