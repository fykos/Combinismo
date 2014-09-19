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

-(NSString *)conteudo
{
    return @"conteudo";
}
-(int)combinar:(NSArray *)outrasCartas
{
    int score = 0;
    for(Carta *carta in outrasCartas){
        if([carta.conteudo isEqualToString:self.conteudo]){
            score =1;
        }
    }
    return score;
}

@end
