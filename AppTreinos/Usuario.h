//
//  Usuario.h
//  AppTreinos
//
//  Created by Mac Book Pro on 18/05/14.
//  Copyright (c) 2014 chfmr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "SCSQLite.h"

@interface Usuario : NSObject

@property (nonatomic, retain) NSArray *users;
- (void)showUsers;
- (void)deleteUser;
- (BOOL)insertUsers:(NSString *)email
     str_senha:(NSString *)senha
     str_pk_id_usuario:(NSString *)pk_id_usuario
     str_user_name:(NSString *)user_name
     str_fk_tipo_de_usuario:(NSString *)fk_tipo_de_usuario;
- (NSArray *)getUser;
@end
