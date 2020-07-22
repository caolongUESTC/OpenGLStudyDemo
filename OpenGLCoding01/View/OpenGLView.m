//
//  OpenGLView.m
//  OpenGLCoding01
//
//  Created by 曹龙 on 2020/7/22.
//  Copyright © 2020 曹龙. All rights reserved.
//

#import "OpenGLView.h"
#import <OpenGLES/ES2/gl.h>
#import <UIKit/UIKit.h>

@interface OpenGLView ()
@property (nonatomic, strong) EAGLContext* viewContext; //openGL的上下文。
@property (nonatomic, strong) CAEAGLLayer* myEagLayer; //展示用的layer。
@property (nonatomic, assign) GLuint       myProgramId;  //gpu使用的程序

@property (nonatomic, assign) GLuint colorRenderBufferId; //颜色空间
@property (nonatomic, assign) GLuint colorFrameBufferId; //帧空间
@end

@implementation OpenGLView

+ (Class)layerClass {
    return [CAEAGLLayer class];
}
//应该只用设置一次吧。
- (EAGLContext *)viewContext {
    if (!_viewContext) {
        _viewContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    return _viewContext;
}

- (GLuint)colorRenderBufferId{
    if (!_colorRenderBufferId) {
        glGenBuffers(1, &_colorRenderBufferId);
        glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBufferId);
        [self.viewContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.myEagLayer];
    }
    return _colorRenderBufferId;
}

- (GLuint)colorFrameBufferId {
    if (!_colorFrameBufferId) {
        glGenRenderbuffers(1, &_colorFrameBufferId);
        glBindFramebuffer(GL_FRAMEBUFFER, _colorFrameBufferId);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                                  GL_RENDERBUFFER, self.colorRenderBufferId);
    }
    return _colorFrameBufferId;
}

//所有内容
- (void)adjustLayer {
    self.myEagLayer = (CAEAGLLayer *)self.layer;
    [self setContentScaleFactor:[[UIScreen mainScreen] scale]]; //调整缩放因子
    
    self.myEagLayer.opaque = YES; //设置为不透明
    NSDictionary *dict = @{kEAGLDrawablePropertyRetainedBacking: [NSNumber numberWithBool:NO],
                           kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8}; //使用rgba8展示 不保留
    self.myEagLayer.drawableProperties = dict;
}
//删除buffer
- (void)destoryRenderAndFrameBuffer {
    glDeleteFramebuffers(1, &_colorFrameBufferId);
    self.colorFrameBufferId = 0;
    glDeleteRenderbuffers(1, &_colorRenderBufferId);
    self.colorRenderBufferId = 0;
}

//渲染。
- (void)render {
    
}

//1.清除屏幕内容。
- (void)clearScreen {
    glClearColor(0, 1.0, 0, 1.0); //
    glClear(GL_COLOR_BUFFER_BIT);
    
    CGFloat scale= [[UIScreen mainScreen] scale];
    glViewport(self.frame.origin.x * scale, self.frame.origin.y * scale,
               self.frame.size.width * scale, self.frame.size.height * scale);
}

//2.

@end
