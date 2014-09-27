//
//  JogoDeCombinacaoDeCartas.h
//  Combinismo
//
//  Created by George Villasboas on 9/10/14.
//  Copyright (c) 2014 CocoaHeads Goiania. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baralho.h"

extern NSString *const JogoDeCartasViewControlerNotificaACominacaoNotification;

@interface JogoDeCombinacaoDeCartas : NSObject

// inicializador! (Designated initializer)
- (instancetype)initComContagemDeCartas:(NSUInteger)contagem
                          usandoBaralho:(Baralho *)baralho;

- (void)escolherCartaNoIndex:(NSUInteger)index;
- (Carta *)cartaNoIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger pontuacao;

@end
