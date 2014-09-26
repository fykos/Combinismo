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
#import "CartaDeJogo.h"
#import "CartaView.h"


@interface JogoDeCartasViewControler ()

// propertys dos itens - view
@property (strong, nonatomic) IBOutletCollection(CartaView) NSArray *cartasButton;
@property (weak, nonatomic) IBOutlet UILabel *pontuacaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *avisoLabel;

// propertys do jogo de combinacao de cartas - model
@property (strong, nonatomic) JogoDeCombinacaoDeCartas *jogo;

@end

@implementation JogoDeCartasViewControler


// lembrete, chamar o jogo que está lá em cima no propery, ao mesmo tempo modifico o getter fazendo uma lease stantiation
-(JogoDeCombinacaoDeCartas *)jogo{
    
    if(!_jogo){
        
        _jogo = [[JogoDeCombinacaoDeCartas alloc] initComContagemDeCartas:12 usandoBaralho:[self criarBaralho]];
    
    }
    return _jogo;
}


- (BaralhoDeJogo *)criarBaralho
{
    return [[BaralhoDeJogo alloc] init];
}

- (IBAction)clicaCarta:(CartaView *)carta {
    
    NSUInteger index = [self.cartasButton indexOfObject:carta];
    [self.jogo escolherCartaNoIndex:index];
    [self atualizarUI];
    
}
- (IBAction)clicaNovo:(UIButton *)novoJogo {
    
    for (CartaView *cartaButton in self.cartasButton) {
        
        [UIView transitionWithView:cartaButton
                          duration:0.5
                           options:UIViewAnimationOptionCurveLinear
                        animations:^{
                            [cartaButton setAlpha:1];
                        }
                        completion:nil];
        
        if(cartaButton.isSelecionada){
        [UIView transitionWithView:cartaButton
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:nil
                        completion:nil];
        }
        
        cartaButton.selecionada = NO;
        cartaButton.ativa = NO;
    }
    
    _jogo=nil;
    
    self.avisoLabel.text=@"Novo jogo iniciado!";
    
}

- (void)atualizarUI
{
    
    for (CartaView *cartaButton in self.cartasButton) {
        NSUInteger cartaIndex = [self.cartasButton indexOfObject:cartaButton];
        Carta *carta = [self.jogo cartaNoIndex:cartaIndex];
        
        cartaButton.naipe = carta.naipe;
        cartaButton.numero = [NSString stringWithFormat:@"%lu", (unsigned long)carta.numero];
        
        
        // se a carta no index é escolhida e não combinada
        // então a carta é animada abrindo
        if(carta.isEscolhida && !carta.isCombinada){
            [UIView transitionWithView:cartaButton
                              duration:1.0
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:nil
                            completion:nil];
        }
        
        // se a carta atual do looping é selecionada e a carta no index não é combinada
        // então a carta é animada fechando
        if(cartaButton.isSelecionada && !carta.isCombinada){
            [UIView transitionWithView:cartaButton
                              duration:1.0
                               options:UIViewAnimationOptionTransitionFlipFromRight
                            animations:nil
                            completion:nil];
        }
        
        // a carta no index é escolhida e combinada ...
        if(carta.isEscolhida && carta.isCombinada){
            
            // ... se a carta atual no looping não é selecionada
            // anima a carta abrindo
            if(!cartaButton.isSelecionada){
                [UIView transitionWithView:cartaButton
                              duration:1.0
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:nil
                            completion:^(BOOL finished) {
                                
                            }];
                
            }
            
            // ... anima o alpha 0.5
            [UIView transitionWithView:cartaButton
                              duration:0.5
                               options:UIViewAnimationOptionCurveLinear
                            animations:^{
                                [cartaButton setAlpha:0.5];
                            }
                            completion:nil];
        }
        
        cartaButton.selecionada = carta.isEscolhida;
        cartaButton.ativa = carta.isCombinada;
        
        
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



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // cria a estacao de radio do nsnotification
    NSString *const nomeDoCanal = @"canalNotificationElis";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notificacaoRecebida:)
               name:nomeDoCanal
             object:self.jogo
     ];
    
}


// metodo que é chamado sempre que é postado uma nova notificacao
- (void)notificacaoRecebida:(NSNotification *)notificacao
{
    
    //NSString *canal = notificacao.name;
    //id estacao = notificacao.object;
    NSDictionary *infos = notificacao.userInfo;
    
    CartaDeJogo *cartaA = infos[@"cartaA"];
    CartaDeJogo *cartaB = infos[@"cartaB"];
    
    NSString *texto;
    
    if([cartaA.naipe isEqualToString:cartaB.naipe]) {
        texto=@"combinaram o naipe";
    }else if (cartaA.numero == cartaB.numero) {
        texto=@"combinaram o número";
    }else{
        texto=@"não combinaram";
    }
    
    self.avisoLabel.text = [NSString stringWithFormat:@"%@ e %@ %@",cartaB.conteudo,cartaA.conteudo,texto];
    
}


@end
