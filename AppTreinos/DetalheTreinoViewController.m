//
//  DetalheTreinoViewController.m
//  AppTreinos
//
//  Created by Mac Book Pro on 13/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "DetalheTreinoViewController.h"

@interface DetalheTreinoViewController ()

@end

@implementation DetalheTreinoViewController

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
    self.treino_nome.text            = [self.treino valueForKey:@"nome"];
    self.treino_horario_inicial.text = [self.treino valueForKey:@"descricao"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
