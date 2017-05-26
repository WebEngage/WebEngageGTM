//
//  WebEngageUserPropertyTag.m
//  WebEngageExample
//
//  Created by Arpit on 17/05/17.
//  Copyright © 2017 Saumitra R. Bhave. All rights reserved.
//

#import "WEGSetUserAttributeTag.h"
#import <WebEngage/WebEngage.h>
#import "WEGGTMUtils.h"


@implementation WEGSetUserAttributeTag

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
    
    NSDictionary* gtmTypeSuffixToObjCTypeMap = @{
                                             STRING_TYPE: NSStringFromClass([NSString class]),
                                             NUMBER_TYPE: NSStringFromClass([NSNumber class]),
                                             DATE_TYPE: NSStringFromClass([NSDate class]),
                                             ARRAY_TYPE: NSStringFromClass([NSArray class]),
                                             OBJECT_TYPE: NSStringFromClass([NSDictionary class]),
                                             BOOLEAN_TYPE: NSStringFromClass([NSNumber class])
                                            };
    
    id userId = parameters[WEG_USER_ID_KEY];
    
    BOOL login = userId != nil && [userId isKindOfClass:[NSString class]] && ![userId isEqualToString:@""];
    
    if (login) {
        
        [[WebEngage sharedInstance].user login:userId];
    }
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL* stop) {
        if (![key isEqualToString:WEG_USER_ID_KEY]) {
            
            NSString* gtmTypeSuffix = userAttributeGTMTypeSuffixMap[key];
            BOOL isSystemAttr = gtmTypeSuffix != nil;
            
            if (isSystemAttr) {
                //system attribute
                //TODO: test this NSClassfromString separately
                
                NSString* dataTypeClass = gtmTypeSuffixToObjCTypeMap[gtmTypeSuffix];
                
                id realisedValue = [WEGGTMUtils convertValue:obj toType:gtmTypeSuffix];
                
                //The passed values should only be expected types or string(accepted for user properties)
                //while the realised values should only be convertible expected type.
                if ( ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:NSClassFromString(dataTypeClass)])
                    && [realisedValue isKindOfClass:NSClassFromString(dataTypeClass)]) {
                    
                    //system attributes with unmatching data types are ignored. Test this.
                    
                    if ([key isEqualToString:WEG_FIRST_NAME_KEY]) {
                        [[WebEngage sharedInstance].user setFirstName:realisedValue];
                    } else if([key isEqualToString:WEG_LAST_NAME_KEY]) {
                        [[WebEngage sharedInstance].user setLastName:realisedValue];
                    } else if([key isEqualToString:WEG_EMAIL_KEY]) {
                        [[WebEngage sharedInstance].user setEmail:realisedValue];
                    } else if([key isEqualToString:WEG_BIRTH_DATE_KEY]) {
                        [[WebEngage sharedInstance].user setBirthDateString:realisedValue];
                    } else if([key isEqualToString:WEG_PHONE_KEY]) {
                        [[WebEngage sharedInstance].user setPhone:realisedValue];
                    } else if([key isEqualToString:WEG_GENDER_KEY]) {
                        [[WebEngage sharedInstance].user setGender:realisedValue];
                    } else if([key isEqualToString:WEG_COMPANY_KEY]) {
                        [[WebEngage sharedInstance].user setCompany:realisedValue];
                    } else if([key isEqualToString:WEG_EMAIL_OPT_IN_KEY]) {
                        
                        [[WebEngage sharedInstance].user
                         setOptInStatusForChannel:WEGEngagementChannelEmail
                         status:[realisedValue boolValue]];
                        
                    } else if([key isEqualToString:WEG_SMS_OPT_IN_KEY]) {
                        
                        [[WebEngage sharedInstance].user
                         setOptInStatusForChannel:WEGEngagementChannelSMS
                         status:[realisedValue boolValue]];
                        
                    } else if([key isEqualToString:WEG_PUSH_OPT_IN_KEY]) {
                        
                        [[WebEngage sharedInstance].user
                         setOptInStatusForChannel:WEGEngagementChannelPush
                         status:[realisedValue boolValue]];
                        
                    } else if([key isEqualToString:WEG_HASHED_EMAIL_KEY]) {
                        
                        [[WebEngage sharedInstance].user setHashedEmail:realisedValue];
                        
                    } else if([key isEqualToString:WEG_HASHED_PHONE_KEY]) {
                        
                        [[WebEngage sharedInstance].user setHashedPhone:realisedValue];
                        
                    }
                }
            } else {
                //custom attribute
                NSString* suffix = [WEGGTMUtils getGTMDataTypeSuffix:key];
                NSString* realisedKey = key;
                id realisedValue = obj;
                if (suffix) {
                    
                    //TODO: test this
                    realisedKey = [key substringToIndex:key.length - suffix.length];
                    realisedValue = [WEGGTMUtils convertValue:obj toType:suffix];
                    
                }
                
                if (realisedValue) {
                    
                    if ([realisedValue isKindOfClass:[NSString class]]) {
                        
                        [[WebEngage sharedInstance].user setAttribute:realisedKey
                                                      withStringValue:realisedValue];
                        
                    } else if ([realisedValue isKindOfClass:[NSArray class]]) {
                        
                        [[WebEngage sharedInstance].user setAttribute:realisedKey
                                                      withArrayValue:realisedValue];
                        
                    } else if ([realisedValue isKindOfClass:[NSNumber class]]) {
                        
                        [[WebEngage sharedInstance].user setAttribute:realisedKey
                                                            withValue:realisedValue];
                        
                    } else if ([realisedValue isKindOfClass:[NSDate class]]) {
                        
                        [[WebEngage sharedInstance].user setAttribute:realisedKey
                                                        withDateValue:realisedValue];
                        
                    } else if ([realisedValue isKindOfClass:[NSDictionary class]]) {
                        
                        [[WebEngage sharedInstance].user setAttribute:realisedKey
                                                  withDictionaryValue:realisedValue];
                        
                    }
                }

            }
        }
    }];
    
    return nil;
    
}

@end
