#import "DialPlan.h"


@implementation DialPlan

+ (DialPlan*) sharedInstance
{
    static DialPlan *instance = nil;
    
    if (instance == nil) {
        instance = [[DialPlan alloc] init];
    }
    return instance;
}

- (id) init
{
    self = [super init];
    if (self != nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dialplan" ofType:@"plist"];
        
        codes = [[NSDictionary alloc] initWithContentsOfFile:path];
        
    }
    return self;
}

- (NSString*) internationalizeNumber:(NSString*)number forCode:(NSString*)code
{
    number = [number stringByKeepingCharactersFromCharset: [NSCharacterSet characterSetWithCharactersInString:@"+()0123456789"]];

    if ([number length] == 0) {
        return nil;
    }

    NSDictionary *codeDict = [codes objectForKey:code];
    NSString *iprefix = [codeDict objectForKey:@"iprefix"];
    NSString *nprefix = [codeDict objectForKey:@"nprefix"];

    if ([number hasPrefix:@"+"]) {
        // already international
        NSString *country = [self codeFromNumber:number];
        if (country != nil) {

            NSString *numberWithoutCountry = [number substringFromIndex:[country length]];
            NSString *national = [NSString stringWithFormat:@"(%@)", nprefix];
            if ([numberWithoutCountry hasPrefix: national]) {
                number = [NSString stringWithFormat:@"%@%@", country, [numberWithoutCountry substringFromIndex:[national length]]];
            }
            
            return [number stringByKeepingCharactersFromCharset: [NSCharacterSet characterSetWithCharactersInString:@"+0123456789"]];
        }
        // unknown country code
        return nil;
    }


    if ([number hasPrefix:iprefix]) {
        // dialing out of the country
        
        NSString *numberWithCountry = [NSString stringWithFormat:@"+%@", [number substringFromIndex:[iprefix length]]];

        // check international number based on the country code
        if ([self codeFromNumber:numberWithCountry]) {
            return [numberWithCountry stringByKeepingCharactersFromCharset: [NSCharacterSet characterSetWithCharactersInString:@"+0123456789"]];
        }
        
        // unknown country code
        return nil;
    }

    if ([number hasPrefix:nprefix]) {
        // dialing inside the country
        number = [NSString stringWithFormat:@"%@%@", code, [number substringFromIndex:[nprefix length]]];
        return [number stringByKeepingCharactersFromCharset: [NSCharacterSet characterSetWithCharactersInString:@"+0123456789"]];
    }

    number = [NSString stringWithFormat:@"%@%@", code, number];
    return [number stringByKeepingCharactersFromCharset: [NSCharacterSet characterSetWithCharactersInString:@"+0123456789"]];
}

- (NSString*) codeFromNumber:(NSString*)number
{
    for(NSUInteger i = 4; i>1 ;i--) {
        NSString *part = [number substringToIndex:i];
        if ([codes objectForKey:part] != nil) {
            return part;
        }
    }
    return nil;
}


- (void) dealloc
{
    [codes release], codes = nil;
    [super dealloc];
}


@end
