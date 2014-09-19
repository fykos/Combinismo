//
//  Baralho.m
//  Combinismo
//
//  Created by Bruno on 16/09/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import "Baralho.h"

@interface Baralho()
@property (strong, nonatomic) NSMutableArray *cartas;
@end


@implementation Baralho

-(NSMutableArray *)cartas
{
    if(!_cartas) _cartas =[[NSMutableArray alloc] init];
    return _cartas;
}

-(void)adicionarCarta:(Carta *)carta
               emCima:(BOOL)emCima
{
    if (emCima){
        [self.cartas insertObject:carta atIndex:0];
    }else{
        [self.cartas addObject:carta];
    }
}
-(Carta *)tirarCartaAleatoria
{
    Carta *cartaAleatoria;
   // NSLog([NSString *self.cartas.count]);
    if(self.cartas.count){
        unsigned index = arc4random() % self.cartas.count;
        cartaAleatoria = self.cartas[index];
        [self.cartas removeObjectAtIndex:index];
    }
    return cartaAleatoria;
}

@end
