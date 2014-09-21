//
//  Carta.m
//  Combinismo
//
//  Created by Bruno on 16/09/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import "Carta.h"

@interface Carta()

@end

@implementation Carta


-(int)combinar:(NSArray *)outrasCartas
{
    int score = 0;
    for(Carta *cartaAtual in outrasCartas){
            
        /*if([carta.conteudo isEqualToString:self.conteudo]){
            score =1;
        }*/
        
        
        // náo consegui extrair o numero e o naipe do conteudo para
        if([cartaAtual.conteudo isEqualToString:self.conteudo]){
            score = 1;
        }else if([cartaAtual.conteudo isEqualToString:self.conteudo]){
            score = 4;
        }
        
        //retorna sempre 1 porque náo esta verificando acima
        score=1;
        
        
    }
    return score;
}

@end
