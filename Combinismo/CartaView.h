//
//  CartaView.h
//  Combinismo
//
//  Created by CasaDaArvore on 9/24/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CartaView : UIControl

@property (strong, nonatomic) IBInspectable NSString *numero;
@property (strong, nonatomic) IBInspectable NSString *naipe;
@property (assign, nonatomic) IBInspectable CGFloat raioCantos;
@property (strong, nonatomic) IBInspectable UIColor *corFrente;
@property (strong, nonatomic) IBInspectable UIImage *imagemVerso;

@property (assign, nonatomic, getter=isSelecionada) IBInspectable BOOL selecionada;
@property (assign, nonatomic, getter=isAtiva) IBInspectable BOOL ativa;
@end
