//
//  Treino.h
//  AppTreinos
//
//  Created by Mac Book Pro on 18/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "SCSQLite.h"

@interface Treino : NSObject 

@property (nonatomic, retain) NSArray *training;

- (void)showTraining;

- (BOOL)deleteTraining;

- (BOOL)insertTraining:(NSDate *)data_do_treino
      hora_inicial_do_treino:(NSString *)hora_inicial_do_treino
      fk_tipo_de_treino:(NSString *)fk_tipo_de_treino
      fk_id_treino:(NSString *)fk_id_treino
      dia_da_semana:(NSString *)dia_da_semana
      nome:(NSString *)nome_tipo_exercicio
      descricao:(NSString *)descricao_exercicio
      fk_id_cliente:(NSString *)fk_id_cliente
      treino_status:(NSString *)exercicio_status;

- (BOOL)updateStatusTraining:(NSString *)id_treino
treino_status:(NSString *)treino_status
treino_observacao:(NSString *)treino_observacao;

- (NSArray *)getTraining:(NSString *)id_treino;

@end
