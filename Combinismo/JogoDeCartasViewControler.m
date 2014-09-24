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

- (void)atualizarUI
{
    
    for (CartaView *cartaButton in self.cartasButton) {
        NSUInteger cartaIndex = [self.cartasButton indexOfObject:cartaButton];
        Carta *carta = [self.jogo cartaNoIndex:cartaIndex];
        
        cartaButton.naipe = carta.naipe;
        cartaButton.numero = [NSString stringWithFormat:@"%lu", (unsigned long)carta.numero];
        
        cartaButton.selecionada = carta.isEscolhida;
        cartaButton.ativa = carta.isCombinada;
        
        [cartaButton setAlpha:carta.isCombinada?0.5:1];
        
        
        /*
        [cartaButton setTitle:[self tituloParaACarta:carta] forState:UIControlStateNormal];
        [cartaButton setBackgroundImage:[self imagemParaACarta:carta] forState:UIControlStateNormal];
                
        cartaButton.enabled = !carta.isCombinada;*/
        
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
