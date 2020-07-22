//
//  OpenGLCompileUtil.m
//  OpenGLCoding01
//
//  Created by 曹龙 on 2020/7/22.
//  Copyright © 2020 曹龙. All rights reserved.
//
#import "OpenGLCompileUtil.h"

//定义内部变量
@interface OpenGLCompileUtil()


@end

@implementation OpenGLCompileUtil

- (GLuint)loadShaders: (NSString *)vert fragment:(NSString *)frag {
    GLuint vertShader, fragShader;
    GLint program = glCreateProgram(); //创建程序。
    
    [self compileShader:&vertShader type:GL_VERTEX_SHADER file:vert];
    [self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:frag];
    
    glAttachShader(program, vertShader);
    glAttachShader(program, fragShader);
    
    //清理资源
    glDeleteShader(vertShader);
    glDeleteShader(fragShader);
    
    return program;
}

- (void)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file {
    NSString *content = [NSString stringWithContentsOfFile:file
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    const GLchar* source = (GLchar *)[content UTF8String];
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
}

- (GLint)linkProgram:(GLuint)program; {
    glLinkProgram(program); //链接程序
    GLint linkResult;
    glGetProgramiv(program, GL_LINK_STATUS, &linkResult);
    
    
    return linkResult;
}

@end
