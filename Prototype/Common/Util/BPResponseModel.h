//
//  BPResponseModel.h
//  BPFramework
//
//  Created by Al on 1/12/17.
//  Copyright © 2017 GeekRRK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPResponseModel : NSObject

@property (assign, nonatomic) int status;
@property (copy, nonatomic) id content;

@end
