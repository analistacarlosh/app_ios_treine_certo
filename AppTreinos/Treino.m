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
    self.training = [SCSQLite selectRowSQL:@"SELECT * FROM tbl_treinos"];
    NSLog(@"Training ==> %@", self.training);
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

@end
