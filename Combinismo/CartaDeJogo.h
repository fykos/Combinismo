//
//  CartaDeJogo.h
//  Combinismo
//
//  Created by Bruno on 16/09/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Carta.h"


////// extern NSString *const nomeDoCanal;

@interface CartaDeJogo : Carta



@property (strong,nonatomic) NSString *naipe;
@property (nonatomic) NSUInteger numero;

+ (NSArray *)naipesValidos;
+ (NSUInteger)numeroMaximo;
@end
