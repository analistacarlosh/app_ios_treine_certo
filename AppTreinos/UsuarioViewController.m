//
//  UsuarioViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 15/06/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "UsuarioViewController.h"
#import "Usuario.h"
#import "Treino.h"
#import "APPTViewController.h"
#import "TreinoViewController.h"

@interface UsuarioViewController ()

@end

@implementation UsuarioViewController

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
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:NO];
    //[self.tabBarController.tabBar setHidden:YES];
}

/*-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}*/

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

- (IBAction)logout_user:(id)sender {
    
    // Verificar se existe training sem sincronismo e informar
    
    Treino *training = [[Treino alloc] init];
    BOOL returnDeleteTraining = [training deleteTraining];
    NSLog(@"returnDeleteTraining ==> %d", returnDeleteTraining);
    
    if(returnDeleteTraining == 0){
        NSLog(@"Error ao delete trainign");
        // Exception, alert
    }
    
    Usuario *user = [[Usuario alloc] init];
    BOOL returnDeleteUser = [user deleteUser];
    NSLog(@"returnDeleteUser ==> %d", returnDeleteUser);

    if(returnDeleteUser == 0){
        NSLog(@"Error ao delete user");
        // Exception, alert
    }
    
    if(returnDeleteUser == 1 && returnDeleteTraining == 1){
        [self performSegueWithIdentifier:@"logout_for_login" sender:self];
    }
}

@end
