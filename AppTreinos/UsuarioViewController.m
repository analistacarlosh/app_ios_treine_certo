//
//  UsuarioViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 15/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "UsuarioViewController.h"
#import "Usuario.h"
#import "Treino.h"
#import "APPTViewController.h"
#import "TreinoViewController.h"
#import "Webservice.h"
#import "Alert.h"
#import "Usuario.h"

@interface UsuarioViewController ()

@end

@implementation UsuarioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Usuario *usuario        = [[ Usuario alloc] init];
    
    NSArray *dataUser          = [usuario getUser];
    NSString *altura_usuario   = [[dataUser objectAtIndex:0] objectForKey:@"altura_usuario"];
    NSString *data_nascimento  = [[dataUser objectAtIndex:0] objectForKey:@"data_nascimento"];
    NSString *peso_usuario     = [[dataUser objectAtIndex:0] objectForKey:@"peso_usuario"];
    NSString *sexo_usuario     = [[dataUser objectAtIndex:0] objectForKey:@"sexo_usuario"];
    NSString *telefone_usuario = [[dataUser objectAtIndex:0] objectForKey:@"telefone_usuario"];
    NSString *user_name        = [[dataUser objectAtIndex:0] objectForKey:@"user_name"];
 
    if(data_nascimento != nil && [data_nascimento isEqualToString:@"<null>"] == false){
        self.txt_data_nascimento.text = data_nascimento;
    }
    
    if(sexo_usuario != nil &&  [sexo_usuario isEqualToString:@"<null>"] == false){
        self.txt_sexo_usuario.text = sexo_usuario;
    }

    if(telefone_usuario != nil && [telefone_usuario isEqualToString:@"<null>"] == false && [telefone_usuario isEqualToString:@""] == false){
        self.txt_telefone_usuario.text = telefone_usuario;
    }
    
    if(user_name != nil && [user_name isEqualToString:@"<null>"] == false){
        self.txt_nome_usuario.text = user_name;
    }
    
    if(altura_usuario != nil && [altura_usuario isEqualToString:@"<null>"] == false){
        self.txt_altura_usuario.text = altura_usuario;
    }
    
    if(peso_usuario != nil && [peso_usuario isEqualToString:@"<null>"] == false){
        self.txt_peso_usuario.text = peso_usuario;
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:NO];
    //[self.tabBarController.tabBar setHidden:YES];
}

/*-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logout_user:(id)sender {
    
    // Verificar se existe training sem sincronismo e informar
    
    Treino *training = [[Treino alloc] init];
    BOOL returnDeleteTraining = [training deleteTraining];
    NSLog(@"returnDeleteTraining ==> %d", returnDeleteTraining);
    
    if(returnDeleteTraining == 0){
        NSLog(@"Error ao delete trainign");
        // Exception, alert
    }
    
    Usuario *user = [[Usuario alloc] init];
    BOOL returnDeleteUser = [user deleteUser];
    NSLog(@"returnDeleteUser ==> %d", returnDeleteUser);

    if(returnDeleteUser == 0){
        NSLog(@"Error ao delete user");
        // Exception, alert
    }
    
    if(returnDeleteUser == 1 && returnDeleteTraining == 1){
        [self performSegueWithIdentifier:@"logout_for_login" sender:self];
    }
}

- (IBAction)btnSalveDataUser:(id)sender {
    
    float sysVer   = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSLog(@" sysVer: %f", sysVer);
    NSString *udid = [[NSUUID UUID] UUIDString];
    NSLog(@" udid: %@ ", udid);
    
    Usuario *user = [[Usuario alloc] init];
    [user showUsers];
    
    NSArray *dataUser = [user getUser];
    NSString *token   = [[dataUser objectAtIndex:0] objectForKey:@"token"];
    
    bool returnUpateUser = [user updateDataUser:_txt_nome_usuario.text txt_data_nascimento:_txt_data_nascimento.text txt_altura_usuario:_txt_altura_usuario.text txt_peso_usuario:_txt_peso_usuario.text txt_sexo_usuario:_txt_sexo_usuario.text txt_telefone_usuario:_txt_telefone_usuario.text token:token];

    NSLog(@"returnUpateUser: %d", returnUpateUser);
    // [user showUsers];
    
    // [self sendDataUserForWebService];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    if(returnUpateUser == true){
        [HUD showAnimated:YES whileExecutingBlock:^{
        
            [self sendDataUserForWebService];
        
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
    }
    
    [self alertStatus:@"Seus dados pessoais foram salvos com sucesso!" :@"Dados do Atleta"];
}

- (BOOL) sendDataUserForWebService
{
    Treino *treino          = [[ Treino alloc] init];
    Webservice *webservice  = [[ Webservice alloc] init];
    Usuario *usuario        = [[ Usuario alloc] init];
    
    NSArray *dataUser          = [usuario getUser];
    NSString *token            = [[dataUser objectAtIndex:0] objectForKey:@"token"];
    NSString *altura_usuario   = [[dataUser objectAtIndex:0] objectForKey:@"altura_usuario"];
    NSString *data_nascimento  = [[dataUser objectAtIndex:0] objectForKey:@"data_nascimento"];
    NSString *peso_usuario     = [[dataUser objectAtIndex:0] objectForKey:@"peso_usuario"];
    NSString *sexo_usuario     = [[dataUser objectAtIndex:0] objectForKey:@"sexo_usuario"];
    NSString *telefone_usuario = [[dataUser objectAtIndex:0] objectForKey:@"telefone_usuario"];
    NSString *user_name        = [[dataUser objectAtIndex:0] objectForKey:@"user_name"];
    
    BOOL return_update_training;
    
    BOOL returnConnectedToInternet = [webservice connectedToInternet];
    
    if(returnConnectedToInternet == TRUE){
        
        NSString *jsonDataUser    = [NSString stringWithFormat: @"altura_usuario=%@&data_nascimento=%@&peso_usuario=%@&sexo_usuario=%@&telefone_usuario=%@&user_name=%@&", altura_usuario, data_nascimento, peso_usuario, sexo_usuario, telefone_usuario, user_name];
        
        // Enviar ao webservice
        NSString *returnd = [webservice conectWebService:(@"update-data-user") parameters:(jsonDataUser) token:(token)];
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        id jsonDataupdatetraining = [jsonParser objectWithString:returnd error:nil];
        
        NSInteger *statusi = [(NSNumber *) [jsonDataupdatetraining objectForKey:@"status"] integerValue];
        NSLog(@"statusi: %d", statusi);
        
    } else {
        NSLog(@"sem internet");
        return false;
    }
    
    return return_update_training;
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTab:(id)sender {
    [self.view endEditing:YES];
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
@end
