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
            
        if([cartaAtual.conteudo isEqualToString:self.conteudo]){
            score =1;
        }
        
    }
    return score;
}

@end
