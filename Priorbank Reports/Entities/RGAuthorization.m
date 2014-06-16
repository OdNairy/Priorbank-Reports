//
//  RGAuthorization.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 30.05.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import <RaptureXML/RXMLElement.h>
#import "RGAuthorization.h"
#import "RXMLElement+ExtendedXMLElement.h"
#import "RGCommission.h"

@implementation RGAuthorization
+ (instancetype)entityWithXMLElement:(RXMLElement *)element {
    return [[RGAuthorization alloc] initWithXMLElement:element];
}

- (instancetype)initWithXMLElement:(RXMLElement *)element {
    self = [super init];
    if (self) {
        self.success = [element integerForChild:@"Success"];
        self.clientType = [element integerForChild:@"ClientType"];
        self.clientName = [element textForChild:@"ClientName"];
        self.userName = [element textForChild:@"UserName"];
        self.regName = [element textForChild:@"RegName"];
        self.admin = [element integerForChild:@"IsAdmin"];
        self.unreadMessagesCount = [element integerForChild:@"MsgUnreadCount"];
        self.useMobileCode = [element integerForChild:@"UseMCode"];
        self.edsAllowed = [element integerForChild:@"EDSAllowed"];
        self.erkRegNum = [element textForChild:@"ERKRegNum"];
        self.userSession = [element textForChild:@"UserSession"];

        self.commission = [RGCommission entityWithXMLElement:[element child:@"Commission"]];

        NSString *lastAuthorizationString = [element textForChild:@"LastAuthorization"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
        self.lastAuthorization = [dateFormatter dateFromString:lastAuthorizationString];
    }
    return self;
}

+ (RGAuthorization *)authorizationWithData:(NSData *)data {
    return [RGAuthorization entityWithXMLElement:[RXMLElement elementFromXMLData:data]];
}

@end
