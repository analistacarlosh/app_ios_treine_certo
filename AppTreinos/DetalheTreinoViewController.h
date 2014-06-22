//
//  DetalheTreinoViewController.h
//  AppTreinos
//
//  Created by Mac Book Pro on 13/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalheTreinoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *treino_nome;
@property (weak, nonatomic) IBOutlet UILabel *treino_horario_inicial;
@property (strong) NSDictionary *treino;
@property (strong, nonatomic) IBOutlet UITextField *obs_alunos;
@property (strong, nonatomic) IBOutlet UILabel *status_treino;
@property (strong, nonatomic) IBOutlet UIButton *btn_treino_feito;
@property (strong, nonatomic) IBOutlet UIButton *btn_treino_alterado;
@property (strong, nonatomic) IBOutlet UIButton *btn_treino_nao_feito;

@end
