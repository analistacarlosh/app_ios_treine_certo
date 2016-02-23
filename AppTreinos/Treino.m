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
    self.training = [SCSQLite selectRowSQL:@"SELECT t.pk_id_treino, t.data_do_treino, t.hora_inicial_do_treino, t.hora_final_do_treino, t.descricao_do_treino, t.observacao, t.fk_tipo_de_treino, t.fk_id_treino, t.dia_da_semana, t.nome, t.descricao, t.fk_id_cliente, t.treino_status, t.treino_observacao_alterado, t.data_ultimo_update, data_ultimo_update_webservice, status_update_webservice, t.icone_treino, t.fk_id_exercicio, t.nome_treinamento FROM tbl_treinos AS t"];
    NSLog(@"Training ==> %@", self.training);
}

- (NSArray *)getTraining:(NSString *)id_treino
{
    int pk_id_treino = [id_treino intValue];
    
    self.training = [SCSQLite selectRowSQL:@"SELECT t.pk_id_treino, t.data_do_treino, t.hora_inicial_do_treino, t.hora_final_do_treino, t.descricao_do_treino, t.observacao, t.fk_tipo_de_treino, t.fk_id_treino, t.dia_da_semana, t.nome, t.descricao, t.fk_id_cliente, t.treino_status, t.treino_observacao_alterado, data_ultimo_update, data_ultimo_update_webservice, status_update_webservice, icone_treino, t.fk_id_exercicio, t.nome_treinamento, t.km_treino, t.tempo_treino FROM tbl_treinos AS t WHERE t.pk_id_treino = '%d' ", pk_id_treino];
    
    NSLog(@"self.training: %@", self.training);
    
    return self.training;
}

- (NSArray *)getTrainingWhere:(NSString *)where
{
    self.training = [SCSQLite selectRowSQL:@"SELECT t.fk_id_treino, t.treino_status, t.treino_observacao_alterado, data_ultimo_update, data_ultimo_update_webservice, status_update_webservice, t.fk_id_exercicio, t.nome_treinamento, t.km_treino, t.tempo_treino, t.fk_id_cliente FROM tbl_treinos AS t WHERE t.status_update_webservice = 0 "];
    
    return self.training;
}

- (NSArray *)getTrainingDefault
{
    self.training = [SCSQLite selectRowSQL:@"SELECT t.fk_id_treino, t.fk_id_cliente FROM tbl_treinos AS t LIMIT 1"];
    
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
    treino_status:(NSString *)exercicio_status
    fk_id_exercicio:(NSString *)fk_id_exercicio
    nome_treinamento:(NSString *)nome_treinamento
    km_treino:(NSString *)km_treino
    tempo_treino:(NSString *)tempo_treino
{
    
    int fktipodetreino = [fk_tipo_de_treino intValue];
    int fkidtreino     = [fk_id_treino intValue];
    int fkidcliente    = [fk_id_cliente intValue];
    int fkidexercicio    = [fk_id_exercicio intValue];
    
    [self showTraining];
    
    BOOL isSave = [SCSQLite executeSQL:@"INSERT INTO  tbl_treinos (data_do_treino, hora_inicial_do_treino, fk_tipo_de_treino, fk_id_treino, dia_da_semana, nome, descricao, fk_id_cliente, treino_status, nome_treinamento, fk_id_exercicio, km_treino, tempo_treino) VALUES ('%@', '%@', '%d', '%d', '%@', '%@', '%@', '%d', '%@', '%@', '%d', '%@', '%@')",
                   data_do_treino, hora_inicial_do_treino, fktipodetreino, fkidtreino, dia_da_semana,nome_tipo_exercicio, descricao_exercicio,
                   fkidcliente, exercicio_status,
                   nome_treinamento, fkidexercicio,
                   km_treino, tempo_treino];
    
    return isSave;
}

-(BOOL)updateTraining:(NSString *)data_do_treino
     hora_inicial_do_treino:(NSString *)hora_inicial_do_treino
          fk_tipo_de_treino:(NSString *)fk_tipo_de_treino
               fk_id_treino:(NSString *)fk_id_treino
              dia_da_semana:(NSString *)dia_da_semana
                       nome:(NSString *)nome_tipo_exercicio
                  descricao:(NSString *)descricao_exercicio
            fk_id_exercicio:(NSString *)fk_id_exercicio
           nome_treinamento:(NSString *)nome_treinamento{
    
    int fktipodetreino = [fk_tipo_de_treino intValue];
    int fkidtreino     = [fk_id_treino intValue];
    int fkidexercicio    = [fk_id_exercicio intValue];
    
     BOOL isUpdate = [SCSQLite executeSQL:@"UPDATE tbl_treinos SET data_do_treino = '%@', hora_inicial_do_treino = '%@',fk_tipo_de_treino = '%d', fk_id_treino = '%d', dia_da_semana = '%@', nome = '%@', descricao = '%@', nome_treinamento = '%@' WHERE fk_id_exercicio = '%d'", data_do_treino, hora_inicial_do_treino, fktipodetreino, fkidtreino, dia_da_semana, nome_tipo_exercicio, descricao_exercicio, nome_treinamento, fkidexercicio];
    
    return isUpdate;
}

-(BOOL)updateStatusTraining:(NSString *)id_treino
        treino_status:(NSString *)treino_status
        treino_observacao:(NSString *)treino_observacao
        km_treino:(NSString *)km_treino
        tempo_treino:(NSString *)tempo_treino{
    
    int pk_id_treino = [id_treino intValue];
    NSDate *data_ultimo_update = [NSDate date];
    
    NSLog(@"pk_id_treino: %d", pk_id_treino);
    
    BOOL isUpdate = [SCSQLite executeSQL:@"UPDATE tbl_treinos SET treino_status = '%@', treino_observacao_alterado = '%@', data_ultimo_update = '%@', km_treino = '%@', tempo_treino = '%@',  status_update_webservice = 0 WHERE pk_id_treino = '%d'", treino_status, treino_observacao, data_ultimo_update, km_treino, tempo_treino, pk_id_treino];
    
    return isUpdate;
}

-(BOOL)updateStatusUpdateWebservice {
    
    BOOL isUpdate = [SCSQLite executeSQL:@"UPDATE tbl_treinos SET status_update_webservice = 1 WHERE status_update_webservice = 0"];
    
    return isUpdate;
}

@end
