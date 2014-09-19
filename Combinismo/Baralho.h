//
//  Baralho.h
//  Combinismo
//
//  Created by Bruno on 16/09/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Carta.h"

@interface Baralho : NSObject

-(void)adicionarCarta:(Carta *)carta
               emCima:(BOOL)emCima;

-(Carta *)tirarCartaAleatoria;

@end
