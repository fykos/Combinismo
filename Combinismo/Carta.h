//
//  Carta.h
//  Combinismo
//
//  Created by Bruno on 16/09/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Carta : NSObject

@property (strong, nonatomic) NSString *conteudo;
@property (nonatomic, getter=isEscolhida) BOOL escolhida;
@property (nonatomic, getter=isCombinada) BOOL combinada;
-(int)combinar:(NSArray *)outrasCartas;

@end
