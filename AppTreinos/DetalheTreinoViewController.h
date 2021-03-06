//
//  DetalheTreinoViewController.h
//  AppTreinos
//
//  Created by Mac Book Pro on 13/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UIFormattedTextField.h"

@class MBProgressHUD;

@interface DetalheTreinoViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate> {
    IBOutlet UIScrollView *scroller;
    UIAlertView *alert;
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UILabel *treino_nome;
@property (weak, nonatomic) IBOutlet UILabel *treino_horario_inicial;
@property (strong) NSDictionary *treino;
@property (strong, nonatomic) IBOutlet UITextField *obs_alunos;
@property (strong, nonatomic) IBOutlet UILabel *status_treino;
- (IBAction)btn_training_done:(id)sender;
- (IBAction)btn_training_change:(id)sender;
- (IBAction)btn_training_not:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *id_treino;
- (IBAction)backgroundTab_detalhe_treino:(id)sender;
@property (strong, nonatomic) IBOutlet UIFormattedTextField *km_treino;
@property (strong, nonatomic) IBOutlet UIFormattedTextField *tempo_treino;

- (IBAction)startSpinning:(UIButton *)sender;
- (IBAction)stopSpinning:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;

@end
