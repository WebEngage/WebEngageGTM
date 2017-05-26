//
//  WEGDeleteUserTag.m
//  WebEngageExample
//
//  Created by Arpit on 18/05/17.
//  Copyright © 2017 Saumitra R. Bhave. All rights reserved.
//

#import "WEGDeleteUserAttributeTag.h"
#import <WebEngage/WebEngage.h>
#import "WEGGTMUtils.h"

@implementation WEGDeleteUserAttributeTag

-(NSObject *)executeWithParameters:(NSDictionary *)parameters {
    
    
    NSDictionary* userAttributeGTMTypeSuffixMap = @{
                                                    WEG_USER_ID_KEY: STRING_TYPE,
                                                    WEG_FIRST_NAME_KEY: STRING_TYPE,
                                                    WEG_LAST_NAME_KEY: STRING_TYPE,
                                                    WEG_EMAIL_KEY: STRING_TYPE,
                                                    WEG_BIRTH_DATE_KEY: STRING_TYPE,
                                                    WEG_PHONE_KEY: STRING_TYPE,
                                                    WEG_GENDER_KEY: STRING_TYPE,
                                                    WEG_COMPANY_KEY: STRING_TYPE,
                                                    WEG_EMAIL_OPT_IN_KEY: BOOLEAN_TYPE,
                                                    WEG_SMS_OPT_IN_KEY: BOOLEAN_TYPE,
                                                    WEG_PUSH_OPT_IN_KEY: BOOLEAN_TYPE,
                                                    WEG_HASHED_EMAIL_KEY: STRING_TYPE,
                                                    WEG_HASHED_PHONE_KEY: STRING_TYPE
                                                    };
    
    
    NSMutableArray* toDeleteAttributes = [[NSMutableArray alloc] initWithCapacity:parameters.count];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL* stop) {
        if (![key isEqualToString:WEG_USER_ID_KEY]) {
            
            //custom attributes are only deleted
            if (!userAttributeGTMTypeSuffixMap[key]
                && !([obj isKindOfClass:[NSString class]] && [obj isEqualToString:UNDEFINED_LITERAL]) ) {
                
                NSString* suffix = [WEGGTMUtils getGTMDataTypeSuffix:key];
                NSString* realisedKey = key;
                if (suffix) {
                    
                    realisedKey = [key substringToIndex:key.length - suffix.length];
                }
                
                [toDeleteAttributes addObject:realisedKey];
                
            }
        }
    }];
    
    [[WebEngage sharedInstance].user deleteAttributes:toDeleteAttributes];
    
    return nil;
    
}


@end
