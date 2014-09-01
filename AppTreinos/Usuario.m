//
//  Usuario.m
//  AppTreinos
//
//  Created by Mac Book Pro on 18/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import "Usuario.h"
#import "SBJson.h"
#import "SCSQLite.h"

@implementation Usuario

-(void)showUsers
{
    self.users = [SCSQLite selectRowSQL:@"SELECT * FROM tbl_user"];
    NSLog(@"user ==> %@", self.users);
}

-(BOOL)deleteUser
{
    BOOL returnDeleteUser = [SCSQLite executeSQL:@"DELETE FROM tbl_user"];
    return returnDeleteUser;
}

-(BOOL)insertUsers:(NSString *)email
                  str_senha:(NSString *)senha
                  str_pk_id_usuario:(NSString *)pk_id_usuario
                  str_user_name:(NSString *)user_name
          str_fk_tipo_de_usuario:(NSString *)fk_tipo_de_usuario {
    
    BOOL isSave = [SCSQLite executeSQL:@"INSERT INTO tbl_user (email_login, password_login, token, user_name, fk_tipo_de_usuario) VALUES ('%@', '%@', '%@', '%@', '%@') ", email, senha, pk_id_usuario, email, fk_tipo_de_usuario];
    
    return isSave;
}

-(BOOL)updateDataUser:(NSString *)nome_usuario
  txt_data_nascimento:(NSString *)data_nascimento
  txt_altura_usuario:(NSString *)altura_usuario
  txt_peso_usuario:(NSString *)peso_usuario
  txt_sexo_usuario:(NSString *)sexo_usuario
  txt_telefone_usuario:(NSString *)telefone_usuario
  token:(NSString *)token {
    
    BOOL isSave = [SCSQLite executeSQL:@" UPDATE tbl_user SET user_name = '%@', data_nascimento = '%@', peso_usuario = '%@', altura_usuario = '%@', sexo_usuario = '%@', telefone_usuario = '%@' WHERE token = '%@' ", nome_usuario, data_nascimento, peso_usuario, altura_usuario, sexo_usuario, telefone_usuario, token];
    
    return isSave;
}

- (NSArray *)getUser
{
    self.users = [SCSQLite selectRowSQL:@"SELECT * FROM tbl_user LIMIT 1"];
    NSLog(@"user ==> %@", self.users);

    return self.users;
}

@end
