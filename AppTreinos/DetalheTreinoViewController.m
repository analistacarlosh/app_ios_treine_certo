//
//  DetalheTreinoViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 13/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "DetalheTreinoViewController.h"
#import "Treino.h"
#import "SBJson.h"
#import "Webservice.h"
#import "Alert.h"

@interface DetalheTreinoViewController ()

@end

@implementation DetalheTreinoViewController

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
    NSLog(@" %@ ", self.treino);
    self.treino_nome.text            = [self.treino valueForKey:@"nome"];
    self.treino_horario_inicial.text = [self.treino valueForKey:@"descricao"];
    self.id_treino.text              = [[self.treino valueForKey:@"pk_id_treino"] stringValue];
    
    NSString *treinoObservacaoAlterado = [self.treino valueForKey:@"treino_observacao_alterado"];
    NSString *statustreino             = [self.treino valueForKey:@"treino_status"];
    
    if([treinoObservacaoAlterado isEqual:[NSNull null]]){
    
    } else {
        self.obs_alunos.text            = [self.treino valueForKey:@"treino_observacao_alterado"];
    }
    
    NSLog(@"pause");
    
    if([statustreino isEqualToString:@"1"]){
        self.status_treino.text          = @"Feito";
    } else if ([statustreino isEqualToString:@"2"]){
        self.status_treino.text          = @"Alterado";
    } else if([statustreino isEqualToString:@"3"]){
        self.status_treino.text          = @"Não Feito";
    } 
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:NO];
    
}

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

- (IBAction)btn_training_done:(id)sender {
    
    Treino *treino = [[Treino alloc] init];
    //Alert *alert   = [[Alert alloc ] init];
    
    NSLog(@"btn_training_done");
    NSString *treino_status_text = @"1";
    
    BOOL isUpdate = [treino updateStatusTraining:(_id_treino.text) treino_status:(treino_status_text) treino_observacao:(_obs_alunos.text)];
    
    //NSLog(@"return updateStatusTraining %d", isUpdate);
    
    if(isUpdate == TRUE){
        [self alertStatus:@"Sua observação do treino foi salva com sucesso!" :@"Treino"];
        NSLog(@"Status do treino feito foi salvo!");
    }
    
    //NSArray *datatraining = [treino getTraining:(_id_treino.text)];
    //NSLog(@"datatraining: %@", datatraining);

    // sendDataCheckTraining
    // BOOL returnsendDataCheckTraining = [self sendDataCheckTraining];
    
    // NSArray *dataTraining = [treino getTraining:(_id_treino.text)];
    // NSLog(@"dataTraining: %@", dataTraining);
}

- (IBAction)btn_training_change:(id)sender {
    
    Treino *treino = [[Treino alloc] init];
    //Alert *alert   = [[Alert alloc ] init];
    
    NSLog(@"btn_training_change");
    NSString *treino_status_text = @"2";
    
    BOOL isUpdate = [treino updateStatusTraining:(_id_treino.text) treino_status:(treino_status_text) treino_observacao:(_obs_alunos.text)];
    
    //NSLog(@"return updateStatusTraining %d", isUpdate);
    
    if(isUpdate == TRUE){
        [self alertStatus:@"Sua observação do treino foi salva com sucesso!" :@"Treino"];
        NSLog(@"Status do treino alterado foi salvo!");
    }
}

- (IBAction)btn_training_not:(id)sender {
    
    Treino *treino = [[Treino alloc] init];
    //Alert *alert   = [[Alert alloc ] init];
    
    NSLog(@"btn_training_done");
    NSString *treino_status_text = @"3";
    
    BOOL isUpdate = [treino updateStatusTraining:(_id_treino.text) treino_status:(treino_status_text) treino_observacao:(_obs_alunos.text)];
    
    //NSLog(@"return updateStatusTraining %d", isUpdate);
    
    if(isUpdate == TRUE){
        [self alertStatus:@"Sua observação do treino foi salva com sucesso!" :@"Treino"];
        NSLog(@"Status do treino não feito foi salvo!");
    }
    
}

- (BOOL) sendDataCheckTraining
{
    Treino *treino = [[ Treino alloc] init];
    Webservice *webservice = [[ Webservice alloc] init];
    // Consultar todas os treinos para enviar ao server

    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *where = @" t.status_update_webservice = 1";
    NSArray *dataTraining = [treino getTrainingWhere:(where)];
    NSString *jsonCommand = [writer stringWithObject:dataTraining];
    
    // Enviar ao server
    BOOL returnd = [webservice conectWebService:(@"update-training") parameters:(jsonCommand)];
    
    return true;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTab_detalhe_treino:(id)sender {
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
