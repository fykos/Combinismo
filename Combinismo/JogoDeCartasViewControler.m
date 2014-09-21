//
//  ViewController.m
//  Combinismo
//
//  Created by Bruno on 16/09/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import "JogoDeCartasViewControler.h"
#import "BaralhoDeJogo.h"
#import "JogoDeCombinacaoDeCartas.h"

@interface JogoDeCartasViewControler ()

// propertys dos itens - view
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cartasButton;
@property (weak, nonatomic) IBOutlet UILabel *pontuacaoLabel;

// propertys do jogo de combinacao de cartas - model
@property (strong, nonatomic) JogoDeCombinacaoDeCartas *jogo;

@end

@implementation JogoDeCartasViewControler


// chamar o jogo que está lá em cima no propery, ao mesmo tempo modifico o getter fazendo uma lease stantiation
-(JogoDeCombinacaoDeCartas *)jogo{
    
    if(!_jogo){
        
        _jogo = [[[JogoDeCombinacaoDeCartas alloc] init] initComContagemDeCartas:12 usandoBaralho:[self criarBaralho]];
    
    }
    return _jogo;
}

- (BaralhoDeJogo *)criarBaralho
{
    return [[BaralhoDeJogo alloc] init];
}

- (IBAction)clicaCarta:(UIButton *)carta {
    
    NSUInteger index = [self.cartasButton indexOfObject:carta];
    [self.jogo escolherCartaNoIndex:index];
    [self atualizarUI];
    
}

- (void)atualizarUI
{
    for (UIButton *cartaButton in self.cartasButton) {
        NSUInteger cartaIndex = [self.cartasButton indexOfObject:cartaButton];
        Carta *carta = [self.jogo cartaNoIndex:cartaIndex];
        
        [cartaButton setTitle:[self tituloParaACarta:carta] forState:UIControlStateNormal];
        [cartaButton setBackgroundImage:[self imagemParaACarta:carta] forState:UIControlStateNormal];
        
        if(carta.isCombinada){
            NSLog(@"combinada");
            cartaButton.enabled=NO;
            
        }else{
            NSLog(@"nao combinada");
            cartaButton.enabled=YES;
        }
        
    }
    
    self.pontuacaoLabel.text = [NSString stringWithFormat:@"Pontuação: %ld", (long)self.jogo.pontuacao];
}

- (NSString *)tituloParaACarta:(Carta *)carta
{
    return carta.isEscolhida ? carta.conteudo : @"";
}

- (UIImage *)imagemParaACarta:(Carta *)carta
{
    return [UIImage imageNamed: carta.isEscolhida ? @"cartaFrente" : @"cartaVerso"];
}



@end
