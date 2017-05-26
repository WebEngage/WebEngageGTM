//
//  WEGGTMUtils.m
//  WebEngageExample
//
//  Created by Arpit on 18/05/17.
//  Copyright © 2017 Saumitra R. Bhave. All rights reserved.
//

#import "WEGGTMUtils.h"

@implementation WEGGTMUtils

+(NSString*) getGTMDataTypeSuffix:(NSString*) string {
    
    if ([string hasSuffix:STRING_TYPE]) {
        return STRING_TYPE;
    } else if ([string hasSuffix:NUMBER_TYPE]) {
        return NUMBER_TYPE;
    }  else if ([string hasSuffix:BOOLEAN_TYPE]) {
        return BOOLEAN_TYPE;
    } else if ([string hasSuffix:DATE_TYPE]) {
        return DATE_TYPE;
    } else if ([string hasSuffix:ARRAY_TYPE]) {
        return ARRAY_TYPE;
    } else if ([string hasSuffix:OBJECT_TYPE]) {
        return OBJECT_TYPE;
    }
    
    return nil;
}

+(id) convertValue:(id) value toType:(NSString*) type {
    
    id result = nil;
    
    
    if (!([value isKindOfClass:[NSString class]] && [value isEqualToString:UNDEFINED_LITERAL])) {
        
        if ([type isEqualToString:STRING_TYPE]) {
            
            if ([value isKindOfClass:[NSDate class]]) {
                
                //TODO: test this
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"];
                [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"gb"]];
                result = [dateFormat stringFromDate:value];

            } else if([value isKindOfClass:[NSString class]]) {
                
                result = value;
                
            } else if([value isKindOfClass:[NSNumber class]]) {
                
                if ([self isBoolType:value]) {
                    
                    result = [value boolValue]?TRUE_LITERAL:FALSE_LITERAL;
                    
                } else {
                    
                    result = [value description];
                }
                
            } else if([value isKindOfClass:[NSArray class]]
                      || [value isKindOfClass:[NSDictionary class]]) {
                
                NSError* err;
                NSData* jsonData = [NSJSONSerialization dataWithJSONObject:value options:0 error:&err];
                if (err) {
                    //Log error
                } else {
                    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    result = jsonString;
                }
            } else if ([value isKindOfClass:[NSNull class]]) {
                result = @"null";
            }
            
        } else if([type isEqualToString:NUMBER_TYPE]) {
            
            if ([value isKindOfClass:[NSDate class]]) {
                
                result =  @((int)([(NSDate*)value timeIntervalSince1970] * 1000));
                
            } else if([value isKindOfClass:[NSNumber class]]) {
                
                result = value;
                
            } else if([value isKindOfClass:[NSString class]]) {
                
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                result = [f numberFromString:value];
                
            }
        } else if([type isEqualToString:BOOLEAN_TYPE]) {
            
            if ([value isKindOfClass:[NSString class]]) {
                
                result =  [value isEqualToString:TRUE_LITERAL]?@YES:@NO;
                
            } else if([value isKindOfClass:[NSNumber class]]) {
                
                result = [NSNumber numberWithBool:[value boolValue]];
                
            }
        } else if ([type isEqualToString:DATE_TYPE]) {
            
            if ([value isKindOfClass:[NSDate class]]) {
                
                result =  value;
                
            } else if([value isKindOfClass:[NSString class]]) {
                
                //TODO: test this
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"];
                [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"gb"]];
                result = [dateFormat dateFromString:value];
                
            } else if([value isKindOfClass:[NSNumber class]]) {
                
                //TODO: Test this
                NSTimeInterval interval = [value doubleValue]/1000;
                result = [NSDate dateWithTimeIntervalSince1970:interval];
                
            }
        } else if ([type isEqualToString:ARRAY_TYPE]) {
            
            if ([value isKindOfClass:[NSString class]]) {
                
                NSError* err;
                id parsedValue = [NSJSONSerialization JSONObjectWithData:[value
                                                                          dataUsingEncoding:NSUTF8StringEncoding]
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&err];
                if (err) {
                    //Log(@"Could not parse");
                } else if ([parsedValue isKindOfClass:[NSArray class]]) {
                    
                    result = parsedValue;
                    
                }
            } else if([value isKindOfClass:[NSArray class]]) {
                
                result = value;
            }
            
        } else if ([type isEqualToString:OBJECT_TYPE]) {
            
            if ([value isKindOfClass:[NSString class]]) {
                
                NSError* err;
                id parsedValue = [NSJSONSerialization JSONObjectWithData:[value
                                                                          dataUsingEncoding:NSUTF8StringEncoding]
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&err];
                if (err) {
                    //Log(@"Could not parse");
                } else if ([parsedValue isKindOfClass:[NSDictionary class]]) {
                    
                    result = parsedValue;
                    
                }
            } else if([value isKindOfClass:[NSDictionary class]]) {
                
                result = value;
            }
            
        }
    }

    return result;
}

+(BOOL) isBoolType:(NSNumber*) number {
    
    NSError* err;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"key":number}
                                                       options:0
                                                         error:&err];
    
    NSString* jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    return [jsonString containsString:TRUE_LITERAL]
            || [jsonString containsString:FALSE_LITERAL];
    
}


@end
