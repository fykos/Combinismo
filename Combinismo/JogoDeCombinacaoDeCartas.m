//
//  JogoDeCombinacaoDeCartas.m
//  Combinismo
//
//  Created by George Villasboas on 9/10/14.
//  Copyright (c) 2014 CocoaHeads Goiania. All rights reserved.
//

#import "JogoDeCombinacaoDeCartas.h"

@interface JogoDeCombinacaoDeCartas ()
@property (nonatomic, readwrite) NSInteger pontuacao;
@property (strong, nonatomic) NSMutableArray *cartas; // de Cartas
@end

@implementation JogoDeCombinacaoDeCartas

- (NSMutableArray *)cartas
{
    if (!_cartas) _cartas = [[NSMutableArray alloc] init];
    return _cartas;
}

- (instancetype)init
{
    NSLog(@"Esta classe deve ser inicializada usando initComContagemDeCartas:usandoBaralho:");
    return nil;
}

- (instancetype)initComContagemDeCartas:(NSUInteger)contagem usandoBaralho:(Baralho *)baralho
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < contagem; i++) {
            Carta *carta = [baralho tirarCartaAleatoria];
            
            if (carta) {
                [self.cartas addObject:carta];
            }
            else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int BONUS_POR_COMBINACAO = 4;
static const int PENALIDADE_POR_NAO_COMBINAR = 2;
static const int CUSTO_PARA_ESCOLHER = 1;

- (void)escolherCartaNoIndex:(NSUInteger)index
{
    Carta *carta = [self cartaNoIndex:index];
    
    // so faz sentido se a carta ainda puder ser combinada...
    if (!carta.isCombinada) {
        
        // se a carta já estiver escolhida, volta ela para nao escolhida.
        if (carta.isEscolhida) {
            carta.escolhida = NO;
        }
        else{
            
            // ok. Nao combinada e não escolhida.
            
            // tenta combinar com outra carta
            // percorre todo o baralho procurando por cartas ESCOLHIDAS e NÃO COMBINADAS!
            for (Carta *outraCarta in self.cartas) {
                
                
                if (outraCarta.isEscolhida && !outraCarta.isCombinada) {
                    // encontramos a carta!
                    
                    // vamos combiná-la com outra carta.
                    int pontuacaoDaCombinacao = [carta combinar:@[outraCarta]]; // retorna o quão boa a combinacao é
                    
                    if (pontuacaoDaCombinacao) {
                        
                        // existe combinacao... Bonifica pontos.
                        
                        self.pontuacao += pontuacaoDaCombinacao * BONUS_POR_COMBINACAO;
                        
                        // marca cartas como combinadas.
                        carta.combinada = YES;
                        outraCarta.combinada = YES;
                    }
                    else{
                        
                        // Nao existe combinacao. Penaliza jogador.
                        self.pontuacao -= PENALIDADE_POR_NAO_COMBINAR;
                        
                        // volta ela para não escolhida.
                        outraCarta.escolhida = NO;
                    }
                }
            }
            
            // debita a pontuacao por escolher
            self.pontuacao -= CUSTO_PARA_ESCOLHER;
            
            // marca carta como escolhida.
            carta.escolhida = YES;
            
        }
    }
}

- (Carta *)cartaNoIndex:(NSUInteger)index
{
    return index < self.cartas.count ? self.cartas[index] : nil;
}

@end
