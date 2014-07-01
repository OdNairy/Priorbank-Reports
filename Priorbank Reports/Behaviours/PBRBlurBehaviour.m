//
//  PBRBlurBehaviour.m
//  Priorbank Reports
//
//  Created by Roman Hardukevich on 30/06/14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "PBRBlurBehaviour.h"

@interface PBRBlurBehaviour ()
@property (nonatomic, strong) UIImage* originalImage;
@end

@implementation PBRBlurBehaviour

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.originalImage = [UIImage imageNamed:imageName];
}

-(void)setOriginalImage:(UIImage *)originalImage{
    _originalImage = originalImage;
    [self updateBlur];
}

-(void)setTargetImageView:(UIImageView *)targetImageView{
    _targetImageView = targetImageView;
    [self updateBlur];
}

-(void)setBlurRadius:(CGFloat)blurRadius{
    _blurRadius = blurRadius;
    [self updateBlur];
}

-(void)updateBlur{
    if (_blurRadius && _originalImage && _targetImageView) {
        UIImage* bluredImage = [self blur:_originalImage blurRadius:_blurRadius];
        self.targetImageView.image = bluredImage;
    }
}



- (UIImage*) blur:(UIImage*)theImage blurRadius:(CGFloat)blurRadius
{
    // ***********If you need re-orienting (e.g. trying to blur a photo taken from the device camera front facing camera in portrait mode)
    // theImage = [self reOrientIfNeeded:theImage];
    
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blurRadius) forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
    
    // *************** if you need scaling
    // return [[self class] scaleIfNeeded:cgImage];
}


@end
