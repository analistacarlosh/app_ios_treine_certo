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
#import "Usuario.h"

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
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320,568)];
    
    self.treino_nome.text            = [self.treino valueForKey:@"nome"];
    self.treino_horario_inicial.text = [self.treino valueForKey:@"descricao"];
    self.id_treino.text              = [[self.treino valueForKey:@"pk_id_treino"] stringValue];

    // self.km_treino.text              = [self.treino valueForKey:@"km_treino"];
    // self.tempo_treino.text           = [self.treino valueForKey:@"tempo_treino"];
    NSString *km_treino              = [self.treino valueForKey:@"km_treino"];
    NSString *tempo_treino           = [self.treino valueForKey:@"tempo_treino"];

    if([km_treino isEqualToString:@"<null>"] == false){
        self.km_treino.text          = km_treino;
    }
    
    if([tempo_treino isEqualToString:@"<null>"] == false){
        self.tempo_treino.text          = tempo_treino;
    }
    
    NSString *treinoObservacaoAlterado = [self.treino valueForKey:@"treino_observacao_alterado"];
    NSString *statustreino             = [self.treino valueForKey:@"treino_status"];
    
    if([treinoObservacaoAlterado isEqual:[NSNull null]] == false){
        self.obs_alunos.text            = [self.treino valueForKey:@"treino_observacao_alterado"];
    }
    
    if([statustreino isEqualToString:@"1"]){
        self.status_treino.text          = @"Feito";
    } else if ([statustreino isEqualToString:@"2"]){
        self.status_treino.text          = @"Alterado";
    } else if([statustreino isEqualToString:@"3"]){
        self.status_treino.text          = @"Não Feito";
    } 
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Setando a mascara no campo de tempo
    self.tempo_treino.delegate      = self;
    self.tempo_treino.type          = @"Time";
    self.tempo_treino.formatPattern = @"xx:xx:xx";
    
    // Setando a mascara no campo de tempo
    self.km_treino.delegate      = self;
    self.km_treino.type          = @"Dynamic";
    self.km_treino.formatPattern = @"xxxxx";
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
    
    NSLog(@"btn_training_done");
    NSString *treino_status_text = @"1";
    
    BOOL isUpdate = [treino updateStatusTraining:(_id_treino.text) treino_status:(treino_status_text) treino_observacao:(_obs_alunos.text) km_treino:(_km_treino.text) tempo_treino:(_tempo_treino.text)];
    
    NSLog(@"return updateStatusTraining %d", isUpdate);

    if(isUpdate == TRUE){
        [self alertStatus:@"Sua observação do treino foi salva com sucesso!" :@"Treino"];
        NSLog(@"Status do treino feito foi salvo!");
    }

    // sendDataCheckTraining
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
	[HUD showAnimated:YES whileExecutingBlock:^{
		BOOL returnSendDataCheckTraining = [self sendDataCheckTraining];
        if(returnSendDataCheckTraining == true){
            [treino updateStatusUpdateWebservice];
        }
	} completionBlock:^{
		[HUD removeFromSuperview];
	}];
    
}

- (IBAction)btn_training_change:(id)sender {
    
    Treino *treino = [[Treino alloc] init];
    
    NSLog(@"btn_training_change");
    NSString *treino_status_text = @"2";
    
    BOOL isUpdate = [treino updateStatusTraining:(_id_treino.text) treino_status:(treino_status_text) treino_observacao:(_obs_alunos.text) km_treino:(_km_treino.text) tempo_treino:(_tempo_treino.text)];
    
    NSLog(@"return updateStatusTraining %d", isUpdate);
    
    if(isUpdate == TRUE){
        [self alertStatus:@"Sua observação do treino foi salva com sucesso!" :@"Treino"];
        NSLog(@"Status do treino alterado foi salvo!");
    }
    
    // sendDataCheckTraining
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
	[HUD showAnimated:YES whileExecutingBlock:^{
		BOOL returnSendDataCheckTraining = [self sendDataCheckTraining];
        if(returnSendDataCheckTraining == true){
            [treino updateStatusUpdateWebservice];
        }
	} completionBlock:^{
		[HUD removeFromSuperview];
	}];
}

- (IBAction)btn_training_not:(id)sender {
    
    Treino *treino = [[Treino alloc] init];
    //Alert *alert   = [[Alert alloc ] init];
    
    NSLog(@"btn_training_not");
    NSString *treino_status_text = @"3";
    
    BOOL isUpdate = [treino updateStatusTraining:(_id_treino.text) treino_status:(treino_status_text) treino_observacao:(_obs_alunos.text) km_treino:(_km_treino.text) tempo_treino:(_tempo_treino.text)];
    
    NSLog(@"return updateStatusTraining %d", isUpdate);
    
     NSArray *datatraining = [treino getTraining:(_id_treino.text)];
     NSLog(@"datatraining: %@", datatraining);
    
    if(isUpdate == TRUE){
        [self alertStatus:@"Sua observação do treino foi salva com sucesso!" :@"Treino"];
        NSLog(@"Status do treino não feito foi salvo!");
    }
    
    // sendDataCheckTraining
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
	[HUD showAnimated:YES whileExecutingBlock:^{
		BOOL returnSendDataCheckTraining = [self sendDataCheckTraining];
        NSLog(@"return returnSendDataCheckTraining: %d", returnSendDataCheckTraining);
	} completionBlock:^{
		[HUD removeFromSuperview];
	}];
}

- (BOOL) sendDataCheckTraining
{
    Treino *treino          = [[ Treino alloc] init];
    Webservice *webservice  = [[ Webservice alloc] init];
    Usuario *usuario        = [[ Usuario alloc] init];

    NSArray *dataUser       = [usuario getUser];
    NSString *token         = [[dataUser objectAtIndex:0] objectForKey:@"token"];
    //NSString returnd;
    BOOL return_update_training;
    
    BOOL returnConnectedToInternet = [webservice connectedToInternet];
    
    if(returnConnectedToInternet == TRUE){
    
        // Consultar todas os treinos para enviar ao server
        SBJsonWriter *writer            = [[SBJsonWriter alloc] init];
        NSArray *dataTrainingCheck      = [treino getTrainingWhere:(@" t.status_update_webservice = 0")];
        NSString *stringDataTraining    = [writer stringWithObject:dataTrainingCheck];
        NSString *jsonDataTraining      = [NSString stringWithFormat: @"training=%@", stringDataTraining];
        
        // showTraining
        [treino showTraining];
        
        // [NSThread sleepForTimeInterval:1.0f];
        NSLog(@"update jsonDataTraining: %@", jsonDataTraining  );
         // Enviar ao webservice
         NSString *returnd = [webservice conectWebService:(@"update-training") parameters:(jsonDataTraining) token:(token)];
        
         SBJsonParser *jsonParser = [SBJsonParser new];
         id jsonDataupdatetraining = [jsonParser objectWithString:returnd error:nil];

        // NSInteger status = [(NSNumber *) [[jsonDataupdatetraining objectAtIndex:0] objectForKey:@"status"] integerValue];
        // NSInteger *status = [(NSNumber *) [jsonDataupdatetraining objectForKey:@"status"] integerValue];
        // NSString *statuss = [jsonDataupdatetraining objectForKey:@"status"];
        NSInteger *statusi = [(NSNumber *) [jsonDataupdatetraining objectForKey:@"status"] integerValue];

        if(statusi == 1){
            return_update_training = [treino updateStatusUpdateWebservice];
            NSLog(@"returnUpdateStatusUpdateWebservice: %d", return_update_training);
        }
        
        return return_update_training;
         // Update treinos atualizados
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

//show loading activity.
- (void)startSpinner:(NSString *)message :(NSString *)title{
    alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    [indicator startAnimating];
    [alert addSubview:indicator];
    //[indicator release];
}

//hide loading activity.
- (void)stopSpinner {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        alert = nil;
    // [self performSelector:@selector(showBadNews:) withObject:error afterDelay:0.1];
}

-(BOOL)textField:(UIFormattedTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [textField shouldChangeCharactersInRange:range replacementString:string];
}

@end
