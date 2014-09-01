//
//  UsuarioViewController.h
//  AppTreinos
//
//  Created by Mac Book Pro on 15/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsuarioViewController : UIViewController
- (IBAction)logout_user:(id)sender;
- (IBAction)btnSalveDataUser:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txt_nome_usuario;
@property (weak, nonatomic) IBOutlet UITextField *txt_data_nascimento;
@property (weak, nonatomic) IBOutlet UITextField *txt_peso_usuario;
@property (weak, nonatomic) IBOutlet UITextField *txt_altura_usuario;
@property (weak, nonatomic) IBOutlet UITextField *txt_sexo_usuario;
@property (weak, nonatomic) IBOutlet UITextField *txt_telefone_usuario;
@property (weak, nonatomic) IBOutlet UITextField *txt_email_usuario;
- (IBAction)backgroundTab:(id)sender;

@end
