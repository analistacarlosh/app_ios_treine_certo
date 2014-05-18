//
//  APPTViewController.h
//  AppTreinos
//
//  Created by Mac Book Pro on 11/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPTViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtSenha;
- (IBAction)btnEntrar:(id)sender;
- (IBAction)backgroundTab:(id)sender;
- (IBAction)cadTreino:(id)sender;
- (IBAction)viewUsers:(id)sender;
- (IBAction)viewTraining:(id)sender;
- (IBAction)deleteUsers:(id)sender;
- (IBAction)deleteTraining:(id)sender;

@end
