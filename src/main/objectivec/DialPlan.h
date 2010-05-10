#import <Foundation/Foundation.h>

@interface DialPlan : NSObject {

    NSDictionary *codes;
}

+ (DialPlan*) sharedInstance;

- (NSString*) internationalizeNumber:(NSString*)number forCode:(NSString*)code;
- (NSString*) codeFromNumber:(NSString*)number;

@end
