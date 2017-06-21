//
//  PTResponseModel.h
//  PTFramework
//
//  Created by Al on 1/12/17.
//  Copyright © 2017 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTResponseModel : NSObject

@property (assign, nonatomic) int status;
@property (copy, nonatomic) id content;

@end
