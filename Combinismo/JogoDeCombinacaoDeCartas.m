//
//  JogoDeCombinacaoDeCartas.m
//  Combinismo
//
//  Created by George Villasboas on 9/10/14.
//  Copyright (c) 2014 CocoaHeads Goiania. All rights reserved.
//

#import "JogoDeCombinacaoDeCartas.h"
#import "CartaDeJogo.h"



@interface JogoDeCombinacaoDeCartas ()

@property (nonatomic, readwrite) NSInteger pontuacao;
@property (strong, nonatomic) NSMutableArray *cartas; // de Cartas
@property (strong, nonatomic) NSNotificationCenter *notificacaoRecebida;

@end

@implementation JogoDeCombinacaoDeCartas


//lease instansiation para quando chamar a nsmutablearray cartas fazer o alloc init
- (NSMutableArray *)cartas
{
    if (!_cartas) _cartas = [[NSMutableArray alloc] init];
    return _cartas;
}

// deu um return nil no init para poder fazer um init personalizado
- (instancetype)init
{
    NSLog(@"Esta classe deve ser inicializada usando initComContagemDeCartas:usandoBaralho:");
    return nil;
}

// cria o init personalizado... initComContagemDeCartas "doispontos" usandoBaralho "doispontos"
- (instancetype)initComContagemDeCartas:(NSUInteger)contagem usandoBaralho:(Baralho *)baralho
{
    self = [super init];
    
    if (self) {
        
        //faz o looping para preencher o cartas que foi feito o lease instantiation com a quantidade (contagem) de cartas do (baralho)
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

//cria constantes
static const int BONUS_POR_COMBINACAO = 4;
static const int PENALIDADE_POR_NAO_COMBINAR = 2;
static const int CUSTO_PARA_ESCOLHER = 1;


// metodo que vai escolher uma carta (que foi feito o lease instatiation) usando o index
- (void)escolherCartaNoIndex:(NSUInteger)index
{
    
    // cria uma variavel carta a partir do metodo cartaNoIndex que devolve uma carta do nsmutablearray cartas que foi feito o lease instantiation
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
                    
                    
                    NSString *pontos = [NSString stringWithFormat:@"%i",pontuacaoDaCombinacao];
                    
                    // posta uma nova notificacao
                    NSString * const JogoDeCartasViewControlerNotificaACominacaoNotification = @"br.com.elisnunes.Combinismo.JogoDeCartasViewControlerNotificaACominacaoNotification";
                    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
                    [nc postNotificationName:JogoDeCartasViewControlerNotificaACominacaoNotification
                                      object:self
                                    userInfo: @{
                                                @"cartaA":carta,
                                                @"cartaB":outraCarta,
                                                @"pontuacao":pontos
                                                }
                     ];

                    
                }
            }
            
            
            // debita a pontuacao por escolher
            self.pontuacao -= CUSTO_PARA_ESCOLHER;
            
            // marca carta como escolhida.
            carta.escolhida = YES;
            
        }
    }
}

- (CartaDeJogo *)cartaNoIndex:(NSUInteger)index
{
    return index < self.cartas.count ? self.cartas[index] : nil;
}




@end
