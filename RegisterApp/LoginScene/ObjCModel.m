//
//  ObjCModel.m
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

#import <Foundation/Foundation.h>
#import "ObjCModel.h"
#import "RegisterApp-Swift.h"

@implementation ObjCModel

@synthesize message = _message;

- (instancetype)initWithMessage:(NSString *)message {
    if (self = [super init]) {
        self.message = message;
    }
    return self;
}

- (void)printMessage {
    SwiftModel *model = [[SwiftModel alloc] initWithName:self.message];
    fprintf(stdout, "\n Message %s", [self.message UTF8String]);
    [model printName];
}

- (NSString*) message {
    return _message;
}

- (void)setMessage:(NSString *)message {
    _message = message;
}

@end
