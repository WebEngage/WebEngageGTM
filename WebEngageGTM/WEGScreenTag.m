//
//  WebEngageScreenTag.m
//  WebEngageExample
//
//  Created by Arpit on 18/05/17.
//  Copyright © 2017 Saumitra R. Bhave. All rights reserved.
//

#import "WEGScreenTag.h"
#import <WebEngage/WebEngage.h>
#import "WEGGTMUtils.h"

@implementation WEGScreenTag

-(NSObject *)executeWithParameters:(NSDictionary *)parameters {
    
    NSMutableDictionary* screenData = [[NSMutableDictionary alloc] initWithCapacity:parameters.count];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL* stop) {
        if (![key isEqualToString:WEG_SCREEN_NAME_KEY]) {
            
            NSString* suffix = [WEGGTMUtils getGTMDataTypeSuffix:key];
            NSString* realisedKey = key;
            id realisedValue = obj;
            if (suffix) {
                
                //TODO: test this
                realisedKey = [key substringToIndex:key.length - suffix.length];
                realisedValue = [WEGGTMUtils convertValue:obj toType:suffix];
                
            }
            
            if (realisedValue) {
                [screenData setObject:realisedValue forKey:realisedKey];
            }
            
        }
    }];
    
    NSString* screenName = parameters[WEG_SCREEN_NAME_KEY];
    if(screenName && ![screenName isEqualToString:@""]) {
        
        [[WebEngage sharedInstance].analytics navigatingToScreenWithName:screenName
                                                                 andData:screenData];
    } else {
        
        [[WebEngage sharedInstance].analytics updateCurrentScreenData:screenData];
    }
    
    return nil;
}

@end
