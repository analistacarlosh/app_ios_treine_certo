//
//  TreinoViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 07/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "TreinoViewController.h"
#import "DetalheTreinoViewController.h"
#import "SCSQLite.h"
#import "Usuario.h"
#import "Treino.h"
#import "SBJson.h"
#import "Webservice.h"
#import "Alert.h"

@interface TreinoViewController ()

@end

@implementation TreinoViewController
@synthesize data;


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
}

-(void) viewWillAppear:(BOOL)animated {

    [self.tabBarController.tabBar setHidden:NO];
    
    results = [SCSQLite selectRowSQL:@"SELECT t.pk_id_treino, t.data_do_treino, t.hora_inicial_do_treino, t.hora_final_do_treino, t.descricao_do_treino, t.observacao, t.fk_tipo_de_treino, t.fk_id_treino, t.dia_da_semana, t.nome, t.descricao, t.fk_id_cliente, t.treino_status, t.treino_observacao_alterado, data_ultimo_update, data_ultimo_update_webservice, status_update_webservice, icone_treino, t.fk_id_exercicio, t.nome_treinamento, t.km_treino, t.tempo_treino FROM tbl_treinos AS t ORDER BY t.data_do_treino DESC "];
    
    // NSLog(@"treino: %@", results);
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    Usuario *usuario  = [[Usuario alloc] init];
    NSArray *dataUser = [usuario getUser];
    
    if(dataUser.count == 0){
        [self performSegueWithIdentifier:@"viewlogin" sender:self];
    }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // return data.count;
    return results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celltreino" forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.textLabel.text = [data objectAtIndex:indexPath.row];
    //return cell;
    
    NSDictionary *treino = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = [treino objectForKey:@"nome"];
    
    NSString *data_do_treino    = [treino objectForKey:@"data_do_treino"];
    NSArray *dateSplit = [data_do_treino componentsSeparatedByString:@"-"];

    NSString *data_exercicio    = [NSString stringWithFormat: @"%@ %@/%@/%@", [treino objectForKey:@"dia_da_semana"], [dateSplit objectAtIndex:2], [dateSplit objectAtIndex:1], [dateSplit objectAtIndex:0]];
    
    cell.detailTextLabel.text = data_exercicio;
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"detalheTreino"]){
        DetalheTreinoViewController *DetalheTreino = (DetalheTreinoViewController *) segue.destinationViewController;
        
        //NSIndexPath *indexPath = [self. indexPathForSelectedRow];
        
        NSIndexPath *indexPath = [self.tableviewtreinos indexPathForSelectedRow];
        DetalheTreino.treino = [results objectAtIndex:indexPath.row];
        
    }
}

-(NSInteger)UpdateExercise:(NSString *)action{

    NSLog(@"UpdateExercise :: action %@", action);
    Treino *treino          = [[ Treino alloc] init];
    Webservice *webservice  = [[ Webservice alloc] init];
    Usuario *usuario        = [[ Usuario alloc] init];
    
    NSArray *dataUser       = [usuario getUser];
    NSString *token         = [[dataUser objectAtIndex:0] objectForKey:@"token"];

    NSArray *dadosTreino    = [treino getTrainingDefault];
    NSString *fk_id_treino  = [[dadosTreino objectAtIndex:0] objectForKey:@"fk_id_treino"];
    NSString *fk_id_user    = [[dadosTreino objectAtIndex:0] objectForKey:@"fk_id_cliente"];
    NSInteger countExercise = 0;
    
    BOOL returnConnectedToInternet = [webservice connectedToInternet];
    
    if(returnConnectedToInternet == TRUE){
        
        // CONSULTAR TREINOS CONFORME ACAO (INCLUIR/ATUALIZAR)
        NSString *jsonDataTraining      = [NSString stringWithFormat: @"treino=%@&fk_id_user=%@&acao=%@", fk_id_treino, fk_id_user, action];
        NSLog(@"get Novos treinos: %@", jsonDataTraining);
        NSString *returnd = [webservice conectWebService:(@"get-update-exercise") parameters:(jsonDataTraining) token:(token)];
        
        // PARSEANDO O RETUR
        SBJsonParser *jsonParser  = [SBJsonParser new];
        id jsonDataTreinosIncluir = [jsonParser objectWithString:returnd error:nil];
         NSLog(@"UpdateExercise:: jsonDataTreinosIncluir: %@", jsonDataTreinosIncluir);
        // NSInteger *statusi = [(NSNumber *) [jsonDataupdatetraining objectForKey:@"status"] integerValue];
        
        NSInteger i = 0;
        NSString *skey;
        NSMutableArray *treinosAtualizados = [NSMutableArray array];
        
        for( i = 0; i < [jsonDataTreinosIncluir count]; i++ ) {
            
            if(i){
                skey = [NSString stringWithFormat:@"%d",i];
            } else {
                skey = @"";
            }
            
            NSDate *data_do_treino = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"data_do_exercicio"];
            NSString *hora_inicial_do_treino = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"horario"];
            NSString *fk_tipo_de_treino = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"fk_tipo_de_exercicio"];
            NSString *fk_id_treino = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"fk_id_treino"];
            NSString *dia_da_semana = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"dia_da_semana"];
            NSString *nome = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"nome_tipo_exercicio"];
            NSString *descricao_exercicio = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"descricao_exercicio"];
            NSString *fk_id_cliente = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"fk_id_cliente"];
            NSString *exercicio_status = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"exercicio_status"];
            
            NSString *fk_id_exercicio = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"pk_id_exercicios"];
            NSString *nome_treinamento = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"nome_treinamento"];
            
            NSString *km_treino = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"km_treino"];
            NSString *tempo_treino = [[jsonDataTreinosIncluir objectAtIndex:i] objectForKey:@"tempo_treino"];
            
            BOOL returnTraining = false;
            
            if([action isEqualToString:@"incluir"]){

                returnTraining = [treino insertTraining:(data_do_treino)
                                 hora_inicial_do_treino:(hora_inicial_do_treino)
                                      fk_tipo_de_treino:(fk_tipo_de_treino)
                                           fk_id_treino:(fk_id_treino)
                                          dia_da_semana:(dia_da_semana)
                                                   nome:(nome)
                                              descricao:(descricao_exercicio)
                                          fk_id_cliente:(fk_id_cliente)
                                          treino_status:(exercicio_status)
                                        fk_id_exercicio:(fk_id_exercicio)
                                       nome_treinamento:(nome_treinamento)
                                              km_treino:(km_treino)
                                           tempo_treino:(tempo_treino)];
                NSLog(@"UpdateExercise :: action atualizar");
                
            } else if ([action isEqualToString:@"atualizar"]){

                returnTraining = [treino updateTraining:(data_do_treino)
                                 hora_inicial_do_treino:(hora_inicial_do_treino)
                                      fk_tipo_de_treino:(fk_tipo_de_treino)
                                           fk_id_treino:(fk_id_treino)
                                          dia_da_semana:(dia_da_semana)
                                                   nome:(nome)
                                              descricao:(descricao_exercicio)
                                        fk_id_exercicio:(fk_id_exercicio)
                                       nome_treinamento:(nome_treinamento)];
                NSLog(@"UpdateExercise :: action atualizar");
            }
            
            NSLog(@"UpdateExercise :: returnTraining: %d", returnTraining);
            
            if(returnTraining == TRUE){
                [treinosAtualizados addObject:fk_id_exercicio];
                countExercise++;
            }
        }
        
        NSLog(@"UpdateExercise ::  array treinosAtualizados: %@", treinosAtualizados);
        
        // Preparando para notificar o webservice quais Ids de exercicios foram atualizados conforme a acao
        SBJsonWriter *writer                = [[SBJsonWriter alloc] init];
        NSString *stringDataTreinosInsert   = [writer stringWithObject:treinosAtualizados];
        NSString *jsonDataTreinosInsert     = [NSString stringWithFormat: @"fk_id_user=%@&acao=%@&treinos_inclusos=%@", fk_id_user, action,stringDataTreinosInsert];
        // Enviando
        NSString *returnSetUpdateDataExercise = [webservice conectWebService:(@"set-update-data-exercise") parameters:(jsonDataTreinosInsert) token:(token)];
        SBJsonParser *jsonParserReturnSetUpdateDataExercise = [SBJsonParser new];
        id idjsonParserReturnSetUpdateDataExercise = [jsonParserReturnSetUpdateDataExercise objectWithString:returnSetUpdateDataExercise error:nil];
        
        NSLog(@"UpdateExercise :: idjsonParserReturnSetUpdateDataExercise %@", idjsonParserReturnSetUpdateDataExercise);
    }
    
    return countExercise;
}

- (IBAction)btnUpdateTraining:(id)sender {
    
    // sendDataCheckTraining
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
  
    
	[HUD showAnimated:YES whileExecutingBlock:^{
        
        countExerciseincluir = [self UpdateExercise:(@"incluir")];
        NSLog(@"btnUpdateTraining :: countExerciseInserts: %ld", countExerciseincluir);
        
        countExerciseatualizar = [self UpdateExercise:(@"atualizar")];
        NSLog(@"btnUpdateTraining :: countExerciseatualizar: %ld", countExerciseatualizar);
        
        results = [SCSQLite selectRowSQL:@"SELECT t.pk_id_treino, t.data_do_treino, t.hora_inicial_do_treino, t.hora_final_do_treino, t.descricao_do_treino, t.observacao, t.fk_tipo_de_treino, t.fk_id_treino, t.dia_da_semana, t.nome, t.descricao, t.fk_id_cliente, t.treino_status, t.treino_observacao_alterado, data_ultimo_update, data_ultimo_update_webservice, status_update_webservice, icone_treino, t.fk_id_exercicio, t.nome_treinamento, t.km_treino, t.tempo_treino FROM tbl_treinos AS t ORDER BY t.data_do_treino DESC "];
        
        // NSLog(@"treino: %@", results);
        [self.tableviewtreinos reloadData];
        
	} completionBlock:^{
		[HUD removeFromSuperview];
        
        if(countExerciseincluir > 0 || countExerciseatualizar > 0){
            [self alertStatus:@"Você recebeu atualização da planilha!" :@"Atualização"];
            NSLog(@"btnUpdateTraining :: Você recebeu atualização da planilha!");
            
        } else {
            [self alertStatus:@"Nenhuma atualização da planilha!" :@"Atualização"];
            NSLog(@"btnUpdateTraining :: Nenhuma atualização da planilha!");
        }
	}];
    
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
