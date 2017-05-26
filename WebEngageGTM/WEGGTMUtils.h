//
//  WEGGTMUtils.h
//  WebEngageExample
//
//  Created by Arpit on 18/05/17.
//  Copyright © 2017 Saumitra R. Bhave. All rights reserved.
//

#import <Foundation/Foundation.h>

//Event Name Key
#define WEG_EVENT_NAME_KEY @"event_name"
//Screen Name Key
#define WEG_SCREEN_NAME_KEY @"screen_name"

//User Id Key
#define WEG_USER_ID_KEY @"we_user_id"

//User Attributes
#define WEG_FIRST_NAME_KEY @"we_first_name"
#define WEG_LAST_NAME_KEY @"we_last_name"
#define WEG_EMAIL_KEY @"we_email"
#define WEG_BIRTH_DATE_KEY @"we_birth_date"
#define WEG_PHONE_KEY @"we_phone"
#define WEG_GENDER_KEY @"we_gender"
#define WEG_COMPANY_KEY @"we_company"
#define WEG_EMAIL_OPT_IN_KEY @"we_email_opt_in"
#define WEG_SMS_OPT_IN_KEY  @"we_sms_opt_in"
#define WEG_PUSH_OPT_IN_KEY @"we_push_opt_in"
#define WEG_HASHED_EMAIL_KEY @"we_hashed_email"
#define WEG_HASHED_PHONE_KEY @"we_hashed_phone"

//GTM Type Suffixes
#define STRING_TYPE @"_$string"
#define NUMBER_TYPE @"_$number"
#define BOOLEAN_TYPE @"_$boolean"
#define DATE_TYPE @"_$date"
#define ARRAY_TYPE @"_$array"
#define OBJECT_TYPE @"_$object"

//Literals
#define UNDEFINED_LITERAL @"undefined"
#define TRUE_LITERAL @"true"
#define FALSE_LITERAL @"false"

@interface WEGGTMUtils : NSObject

+(NSString*) getGTMDataTypeSuffix:(NSString*) string;

+(id) convertValue:(id) value toType:(NSString*) type;


@end
