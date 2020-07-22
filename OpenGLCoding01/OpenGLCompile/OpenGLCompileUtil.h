//
//  OpenGLCompileUtil.h
//  OpenGLCoding01
//
//  Created by 曹龙 on 2020/7/22.
//  Copyright © 2020 曹龙. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

#ifndef OpenGLCompileUtil_h
#define OpenGLCompileUtil_h


@interface OpenGLCompileUtil : NSObject
/*
 * glcompileShader(编译)、glAttachShader(关联)、glLinkProgram(链接)
 *  @param vertex 顶点着色器
 *  @param fragment 片段着色器
 *
 *  @return program
 ******/
- (GLuint)loadShaders: (NSString *)vert fragment:(NSString *)frag;

/**
 * 编译shader
 *  @param shader (inout) 返回生成的shader
 *  @param type 着色器的类型
 *  @param file 着色器文件地址
 *s
 *******************/
- (void)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;

/**
 *  链接程序
 *  @param 需要链接的程序
 *
 *  @return 
 **************/
- (GLint)linkProgram:(GLuint)program;

@end

#endif /* OpenGLCompileUtil_h */
