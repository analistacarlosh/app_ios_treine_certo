//
//  Treino.m
//  AppTreinos
//
//  Created by Mac Book Pro on 18/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "Treino.h"

@implementation Treino

- (void)showTraining
{
    self.training = [SCSQLite selectRowSQL:@"SELECT t.pk_id_treino, t.data_do_treino, t.hora_inicial_do_treino, t.hora_final_do_treino, t.descricao_do_treino, t.observacao, t.fk_tipo_de_treino, t.fk_id_treino, t.dia_da_semana, t.nome, t.descricao, t.fk_id_cliente, t.treino_status, t.treino_observacao_alterado, data_ultimo_update, data_ultimo_update_webservice, status_update_webservice, icone_treino FROM tbl_treinos AS t"];
    //NSLog(@"Training ==> %@", self.training);
}

- (NSArray *)getTraining:(NSString *)id_treino
{
    int pk_id_treino = [id_treino intValue];
    
    self.training = [SCSQLite selectRowSQL:@"SELECT t.pk_id_treino, t.data_do_treino, t.hora_inicial_do_treino, t.hora_final_do_treino, t.descricao_do_treino, t.observacao, t.fk_tipo_de_treino, t.fk_id_treino, t.dia_da_semana, t.nome, t.descricao, t.fk_id_cliente, t.treino_status, t.treino_observacao_alterado, data_ultimo_update, data_ultimo_update_webservice, status_update_webservice, icone_treino FROM tbl_treinos AS t WHERE t.pk_id_treino = '%d' ", pk_id_treino];
    
    //NSLog(@"self.training: %@", self.training);
    
    return self.training;
}

- (NSArray *)getTrainingWhere:(NSString *)where
{
    self.training = [SCSQLite selectRowSQL:@"SELECT t.pk_id_treino, t.data_do_treino, t.hora_inicial_do_treino, t.hora_final_do_treino, t.descricao_do_treino, t.observacao, t.fk_tipo_de_treino, t.fk_id_treino, t.dia_da_semana, t.nome, t.descricao, t.fk_id_cliente, t.treino_status, t.treino_observacao_alterado, data_ultimo_update, data_ultimo_update_webservice, status_update_webservice, icone_treino FROM tbl_treinos AS t WHERE t.status_update_webservice = 1 "];
    
    return self.training;
}

- (BOOL)deleteTraining
{
    BOOL delete = [SCSQLite executeSQL:@"DELETE FROM tbl_treinos"];
    return delete;
}

-(BOOL)insertTraining:(NSDate *)data_do_treino
    hora_inicial_do_treino:(NSString *)hora_inicial_do_treino
    fk_tipo_de_treino:(NSString *)fk_tipo_de_treino
    fk_id_treino:(NSString *)fk_id_treino
    dia_da_semana:(NSString *)dia_da_semana
    nome:(NSString *)nome_tipo_exercicio
    descricao:(NSString *)descricao_exercicio
    fk_id_cliente:(NSString *)fk_id_cliente
    treino_status:(NSString *)exercicio_status {
    
    int fktipodetreino = [fk_tipo_de_treino intValue];
    int fkidtreino     = [fk_id_treino intValue];
    int fkidcliente    = [fk_id_cliente intValue];
    
    BOOL isSave = [SCSQLite executeSQL:@"INSERT INTO  tbl_treinos (data_do_treino, hora_inicial_do_treino, fk_tipo_de_treino, fk_id_treino, dia_da_semana, nome, descricao, fk_id_cliente, treino_status) VALUES ('%@', '%@', '%d', '%d', '%@', '%@', '%@', '%d', '%@')",
                   data_do_treino, hora_inicial_do_treino, fktipodetreino, fkidtreino, dia_da_semana, nome_tipo_exercicio, descricao_exercicio,
                   fkidcliente, exercicio_status];
    
    return isSave;
}

-(BOOL)updateStatusTraining:(NSString *)id_treino
        treino_status:(NSString *)treino_status
        treino_observacao:(NSString *)treino_observacao {
    
    int pk_id_treino = [id_treino intValue];
    NSDate *data_ultimo_update = [NSDate date];

    
    NSLog(@"antes UPDAte");
    
    BOOL isUpdate = [SCSQLite executeSQL:@"UPDATE tbl_treinos SET treino_status = '%@', treino_observacao_alterado = '%@', data_ultimo_update = '%@', status_update_webservice = 1 WHERE pk_id_treino = '%d'", treino_status, treino_observacao, data_ultimo_update, pk_id_treino];
    
    return isUpdate;
}

/*-(BOOL) sendCheckTrainingForWebservice():dataTraining{

    
    
    return true;
} */

@end
