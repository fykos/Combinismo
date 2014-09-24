//
//  CartaView.m
//  Combinismo
//
//  Created by CasaDaArvore on 9/24/14.
//  Copyright (c) 2014 Elis Nunes. All rights reserved.
//

#import "CartaView.h"

@interface CartaView()


@end

@implementation CartaView

// tive que fazer o syntesize porque sobscrevi o getter e o setter do corFrente
@synthesize corFrente = _corFrente;

-(UIColor *)corFrente
{
    if(!_corFrente) _corFrente = [UIColor whiteColor];
    return _corFrente;
}

-(void)setNumero:(NSString *)numero
{
    _numero = numero;
    [self setNeedsDisplay];
}
-(void)setNaipe:(NSString *)naipe
{
    _naipe = naipe;
    [self setNeedsDisplay];
}
-(void)setCorFrente:(UIColor *)corFrente
{
    _corFrente=corFrente;
    [self setNeedsDisplay];
}
-(void)setImagemVerso:(UIImage *)imagemVerso
{
    _imagemVerso=imagemVerso;
    [self setNeedsDisplay];
}
-(void)setRaioCantos:(CGFloat)raioCantos
{
    _raioCantos = raioCantos;
    [self setNeedsDisplay];
}
-(void)setSelecionada:(BOOL)selecionada
{
    _selecionada = selecionada;
    [self setNeedsDisplay];
}
-(void) setAtiva:(BOOL)ativa
{
    _ativa = ativa;
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGRect frameGlobal = self.bounds;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    if (self.isSelecionada) {
        //// Carta Drawing Frente (branca e com naipe e números)
        UIBezierPath* cartaPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frameGlobal), CGRectGetMinY(frameGlobal), CGRectGetWidth(frameGlobal), CGRectGetHeight(frameGlobal)) cornerRadius: self.raioCantos];
        [self.corFrente setFill];
        [cartaPath fill];
        
        //// retanguloInterno Drawing
        UIBezierPath* retanguloInternoPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frameGlobal) + floor(CGRectGetWidth(frameGlobal) * 0.06195 + 0.1) + 0.4, CGRectGetMinY(frameGlobal) + floor(CGRectGetHeight(frameGlobal) * 0.04291 + 0.32) + 0.18, floor(CGRectGetWidth(frameGlobal) * 0.94418 + 0.46) - floor(CGRectGetWidth(frameGlobal) * 0.06195 + 0.1) - 0.36, floor(CGRectGetHeight(frameGlobal) * 0.95824 - 0.21) - floor(CGRectGetHeight(frameGlobal) * 0.04291 + 0.32) + 0.53) cornerRadius: self.raioCantos];
        [UIColor.lightGrayColor setStroke];
        retanguloInternoPath.lineWidth = 1;
        [retanguloInternoPath stroke];
        
        
        //// Naipe Superior Drawing
        CGRect naipeSuperiorRect = CGRectMake(CGRectGetMinX(frameGlobal) + 6, CGRectGetMinY(frameGlobal) + 6, 14, 15);
        {
            NSString* textContent = self.numero;
            NSMutableParagraphStyle* naipeSuperiorStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
            naipeSuperiorStyle.alignment = NSTextAlignmentCenter;
            
            NSDictionary* naipeSuperiorFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 12], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: naipeSuperiorStyle};
            
            [textContent drawInRect: CGRectOffset(naipeSuperiorRect, 0, (CGRectGetHeight(naipeSuperiorRect) - [textContent boundingRectWithSize: naipeSuperiorRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: naipeSuperiorFontAttributes context: nil].size.height) / 2) withAttributes: naipeSuperiorFontAttributes];
        }
        
        
        //// Naipe Inferior Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, CGRectGetMaxX(frameGlobal) - 13, CGRectGetMaxY(frameGlobal) - 13.5);
        CGContextRotateCTM(context, 180 * M_PI / 180);
        
        CGRect naipeInferiorRect = CGRectMake(-7, -7.5, 14, 15);
        {
            NSString* textContent = self.numero;
            NSMutableParagraphStyle* naipeInferiorStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
            naipeInferiorStyle.alignment = NSTextAlignmentCenter;
            
            NSDictionary* naipeInferiorFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 12], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: naipeInferiorStyle};
            
            [textContent drawInRect: CGRectOffset(naipeInferiorRect, 0, (CGRectGetHeight(naipeInferiorRect) - [textContent boundingRectWithSize: naipeInferiorRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: naipeInferiorFontAttributes context: nil].size.height) / 2) withAttributes: naipeInferiorFontAttributes];
        }
        
        CGContextRestoreGState(context);
        
        
        //// Texto Drawing
        CGRect textoRect = CGRectMake(CGRectGetMinX(frameGlobal) + 6, CGRectGetMinY(frameGlobal) + 35, CGRectGetWidth(frameGlobal) - 12, 29);
        {
            NSString* textContent = self.naipe;
            NSMutableParagraphStyle* textoStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
            textoStyle.alignment = NSTextAlignmentCenter;
            
            NSDictionary* textoFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica-Bold" size: 22], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: textoStyle};
            
            [textContent drawInRect: CGRectOffset(textoRect, 0, (CGRectGetHeight(textoRect) - [textContent boundingRectWithSize: textoRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: textoFontAttributes context: nil].size.height) / 2) withAttributes: textoFontAttributes];
        }
    }else{
        //// Carta Drawing Verso (com a imagem)
        UIImage* verso = self.imagemVerso;
        UIBezierPath* cartaPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frameGlobal), CGRectGetMinY(frameGlobal), CGRectGetWidth(frameGlobal), CGRectGetHeight(frameGlobal)) cornerRadius: self.raioCantos];
        CGContextSaveGState(context);
        CGContextSetPatternPhase(context, CGSizeMake(0, 0));
        [[UIColor colorWithPatternImage: verso] setFill];
        [cartaPath fill];
        CGContextRestoreGState(context);
    }
    
    
    
    
    
}


@end
