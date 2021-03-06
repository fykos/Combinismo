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
        
        _jogo = [[JogoDeCombinacaoDeCartas alloc] initComContagemDeCartas:self.cartasButton.count usandoBaralho:[self criarBaralho]];
    
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
    
    
    //zera as labels
    self.avisoLabel.text=@"Novo jogo iniciado!";
    self.pontuacaoLabel.text=@"Pontuação: 0";
    
    // faz o looping para desvirar somente as cartas que estão viradas
    for (CartaView *cartaButton in self.cartasButton) {
        
        // desvira somente as que estão viradas
        if(cartaButton.isSelecionada){
            
            
            // desvira a carta
            [UIView transitionWithView:cartaButton
                              duration:1.0
                               options:UIViewAnimationOptionTransitionFlipFromRight
                            animations:nil
                            completion:nil];
            
            
            
            // volta a transparencia para 1
            [UIView transitionWithView:cartaButton
                              duration:0.5
                               options:UIViewAnimationOptionCurveLinear
                            animations:^{
                                [cartaButton setAlpha:1.0];
                            }
                            completion:nil];

        }
        
        

        
        cartaButton.selecionada = NO;
        cartaButton.ativa = NO;
    }
    
    [self recolocaCartas];
    


    
    
    //zera o jogo, ao fazer o primeiro getter é iniciado um novo jogo baralho
    _jogo=nil;
    
    //reinicia o canal nsnotification
    [self iniciaCanal];
    
    
}

- (void)recolocaCartas
{
    // usei esta animação no avisoLabel apenas para dar um tempo de 1 segundo para recolocar as cartas,
    // não consegui usar o nstimer
    [UIView transitionWithView:self.avisoLabel
                      duration:1
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                        [self.avisoLabel setAlpha:1.0];
                    }
                    completion:^(BOOL finished) {
                        
                        //apos finalizar o "timer", faz um novo looping
                        NSUInteger contador = 0;
                        for (CartaView *cartaButton in self.cartasButton) {
                            contador++;
                            
                            //some as cartas
                            [cartaButton setAlpha:0];
                            [UIView transitionWithView:cartaButton
                                              duration:(contador*0.5)
                                               options:UIViewAnimationOptionTransitionCurlUp
                                            animations:nil
                                            completion:^(BOOL finished) {
                                                
                                                //guarda a posição atual
                                                CGFloat posicaoX = cartaButton.frame.origin.x;
                                                CGFloat posicaoY = cartaButton.frame.origin.y;
                                                
                                                //reaparece a carta - PELO MENOS NA MINHA MÁQUINA VIRTUAL FICOU BEM PESADÃO E AINDA NÃO TESTEI NO DEVICE PARA VER SE FICOU TRAVANDO TAMBEM.
                                                cartaButton.center = CGPointMake(0, 0);
                                                [cartaButton setAlpha:1];
                                                [UIView transitionWithView:cartaButton
                                                                  duration:1.0
                                                                   options:UIViewAnimationOptionTransitionCurlDown
                                                                animations:^{
                                                                    cartaButton.center = CGPointMake(posicaoX+35.5, posicaoY+50);
                                                                }
                                                                completion:nil];
                                            }];
                        }
                        
                    }];
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
    
    [self iniciaCanal];
    
}

- (void)iniciaCanal
{
    // cria a estacao de radio do nsnotification, como era mesmo aquele nomão?
    
    NSString * const JogoDeCartasViewControlerNotificaACominacaoNotification = @"br.com.elisnunes.Combinismo.JogoDeCartasViewControlerNotificaACominacaoNotification";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notificacaoRecebida:)
               name:JogoDeCartasViewControlerNotificaACominacaoNotification
             object:self.jogo];
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
