//
//  DetalheTreinoViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 13/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "DetalheTreinoViewController.h"
#import "Treino.h"

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
    // NSLog(@" %@ ", self.treino);
    self.treino_nome.text            = [self.treino valueForKey:@"nome"];
    self.treino_horario_inicial.text = [self.treino valueForKey:@"descricao"];
    self.id_treino.text              = [[self.treino valueForKey:@"pk_id_treino"] stringValue];

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
    
    NSLog(@"btn_training_done");
    NSString *treino_status_text = @"1";
    
    BOOL isUpdate = [treino updateStatusTraining:(_id_treino.text) treino_status:(treino_status_text) treino_observacao:(_obs_alunos.text)];
    
    NSLog(@"return updateStatusTraining %d", isUpdate);
    
    // Verificar conexao
    
    // Consultar todas as transacoes para enviar ao server
    
    // Enviar ao server
    
    // Exibir msg
    
    // NSArray *dataTraining = [treino getTraining:(_id_treino.text)];
    // NSLog(@"dataTraining: %@", dataTraining);
}

- (IBAction)btn_training_change:(id)sender {
    
}

- (IBAction)btn_training_not:(id)sender {
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTab_detalhe_treino:(id)sender {
    [self.view endEditing:YES];
}
@end
