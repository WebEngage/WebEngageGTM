//
//  WebEngageCustomTag.m
//  WebEngageExample
//
//  Created by Arpit on 12/05/17.
//  Copyright © 2017 Saumitra R. Bhave. All rights reserved.
//

#import "WEGEventTag.h"
#import <WebEngage/WebEngage.h>
#import "WEGGTMUtils.h"


@implementation WEGEventTag

-(NSObject *)executeWithParameters:(NSDictionary *)parameters {
    
    
    NSString* eventName = parameters[WEG_EVENT_NAME_KEY];
    if(eventName && ![eventName isEqualToString:@""]) {
        NSMutableDictionary* eventData = [[NSMutableDictionary alloc] initWithCapacity:parameters.count-1];
        [parameters enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL* stop) {
            if (![key isEqualToString:WEG_EVENT_NAME_KEY]) {
                
                NSString* suffix = [WEGGTMUtils getGTMDataTypeSuffix:key];
                NSString* realisedKey = key;
                id realisedValue = obj;
                if (suffix) {
                    
                    //TODO: test this
                    realisedKey = [key substringToIndex:key.length - suffix.length];
                    realisedValue = [WEGGTMUtils convertValue:obj toType:suffix];
                    
                }
                
                if ( realisedValue && !([realisedValue isKindOfClass:[NSString class]] && [realisedValue isEqualToString:@"undefined"]) ) {
                    [eventData setObject:realisedValue forKey:realisedKey];
                }
                
            }
        }];
        
        [[WebEngage sharedInstance].analytics trackEventWithName:eventName andValue:eventData];
    } else {
        //Log event name is not present
    }
    
    return nil;
}
@end
