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
    
    NSLog(@"treino: %@", results);
    
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

- (IBAction)update_training:(id)sender {
    
    
}
@end
