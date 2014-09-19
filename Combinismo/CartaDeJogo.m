//
//  CartaDeJogo.m
//  Combinismo
//
//  Created by Bruno on 16/09/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import "CartaDeJogo.h"

@implementation CartaDeJogo
-(NSString *)conteudo
{
    NSArray *numerosStrings = [CartaDeJogo numerosString];
    return [numerosStrings[self.numero] stringByAppendingString:self.naipe];
}
@synthesize naipe = _naipe;
+(NSArray *)naipesValidos
{
    return @[@"♥",@"♦",@"♣",@"♠"];
}
-(void)setNaipe:(NSString *)naipe
{
    if([[CartaDeJogo naipesValidos] containsObject:naipe]){
        _naipe = naipe;
    }
}
-(NSString *)naipe
{
    return _naipe ? _naipe : @"?";
}

+(NSArray *)numerosString
{
    return @[ @"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+(NSUInteger)numeroMaximo
{
    return [CartaDeJogo numerosString].count - 1;
}

-(void)setNumero:(NSUInteger)numero
{
    if(numero <= [CartaDeJogo numeroMaximo]){
        _numero = numero;
    }
}
@end
