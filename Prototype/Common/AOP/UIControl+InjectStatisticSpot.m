//
//  UIControl+InjectStatisticSpot.m
//  Prototype
//
//  Created by GeekRRK on 16/4/22.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UIControl+InjectStatisticSpot.h"
#import "PTHookUtil.h"

@implementation UIControl (InjectStatisticSpot)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [PTHookUtil swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self performUserStatisticAction:action to: target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];
}

- (void)performUserStatisticAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSString *actionString = NSStringFromSelector(action);
    NSString *targetName = NSStringFromClass([target class]);
    NSDictionary *configDict = [PTHookUtil dictionaryFromUserStatisticsConfigPlist];
    NSString *eventID = configDict[targetName][@"ControlEventIDs"][actionString];
    
    if (eventID) {
        DDLogInfo(@"\n***Hook success.\n[1]action:%@\n[2]target:%@\n[3]event:%@", NSStringFromSelector(action), target, eventID);
    }
}

@end
