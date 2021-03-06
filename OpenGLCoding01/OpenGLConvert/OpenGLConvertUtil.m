//
//  OpenGLConvertUtil.m
//  OpenGLCoding01
//
//  Created by 曹龙 on 2020/7/22.
//  Copyright © 2020 曹龙. All rights reserved.
//

#import "OpenGLConvertUtil.h"
#import <UIKit/UIKit.h>

@implementation OpenGLConvertUtil

- (void)setupTexture:(NSString *)fileName {
    //1.将原有的图片绘制到Context中。
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage; //获取位图
    if (!spriteImage) {
        NSLog(@"fail to load Image");
        exit(1);
    }
    
    size_t imageWidth = CGImageGetWidth(spriteImage);
    size_t imageHeight = CGImageGetHeight(spriteImage);
    
    GLubyte *spriteData = (GLubyte *) calloc(imageWidth * imageHeight * 4, sizeof(GLubyte)); //在栈上申请一块数据
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, imageWidth, imageHeight, 8, 4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, imageWidth, imageHeight), spriteImage); //将图片解码绘制。
    CGContextRelease(spriteContext);
    
    //2.将纹理绑定到默认的纹理ID上。（单张图片才可以）
    glBindTexture(GL_TEXTURE_2D, 0);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR); //纹理缩小，即图片比区域大
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR); //纹理放大，即图片比屏幕小
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE); //s -> x轴
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE); //t -> y轴
    
    float frameWidth = imageWidth, frameHeight = imageHeight;
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, frameWidth, frameHeight, 0,
                 GL_RGBA, GL_UNSIGNED_BYTE, spriteData);  //传递纹理数据给gpu
    glBindTexture(GL_TEXTURE_2D, 0); //回设到默认
    free(spriteData);
}

@end
