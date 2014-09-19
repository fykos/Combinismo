//
//  ViewController.m
//  Combinismo
//
//  Created by Bruno on 16/09/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import "JogoDeCartasViewControler.h"
#import "BaralhoDeJogo.h"

@interface JogoDeCartasViewControler ()


@property (weak, nonatomic) IBOutletC UIButton *carta;
@property (weak, nonatomic) IBOutlet UILabel *tentativasLabel;
@property (nonatomic) NSInteger tentativas;
@end

@implementation JogoDeCartasViewControler

- (void)carta:(UIButton *)cartaBotao {
    
    if(!cartaBotao.selected){
        self.tentativas++;
    
        _tentativasLabel.text = [NSString stringWithFormat:@"Tentativas: %d",self.tentativas];
    
        BaralhoDeJogo *baralhoDeJogo;
        baralhoDeJogo = [[BaralhoDeJogo alloc] init]; // problema, estou inicializando o baralho toda vez que clica na carta, assim as cartas nunca acabam, fail
    
        Carta *cartaAleatoria = baralhoDeJogo.tirarCartaAleatoria;
        
        [cartaBotao setTitle:cartaAleatoria.conteudo forState:UIControlStateSelected];
    }
    cartaBotao.selected = !cartaBotao.selected;
    
}


@end
