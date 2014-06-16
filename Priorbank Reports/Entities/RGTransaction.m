//
//  RGTransaction.m
//  Priorbank Reports
//
//  Created by Roman Gardukevich on 01.06.14.
//  Copyright (c) 2014 Roman Gardukevich. All rights reserved.
//

#import "RGTransaction.h"

@implementation RGTransaction
+(instancetype)transactionWithXMLElement:(RXMLElement*)element{
    RGTransaction* transaction = [[RGTransaction alloc] initWithXMLElement:element];
    return transaction;
}

+(id)entityWithXMLElement:(RXMLElement *)element{
    RGTransaction* transaction = [[RGTransaction alloc]initWithXMLElement:element];
    return transaction;
}

-(instancetype)initWithXMLElement:(RXMLElement*)element{
    self = [super init];
    if (self) {
        NSString* postingDateString = [[element child:@"POSTING_DATE"] text];
        self.postingDate = [RGTransaction dateFromTransactionDateString:postingDateString];
        
        NSString* transactionDateString = [[element child:@"TRANS_DATE"] text];
        NSString* transactionTimeString = [[element child:@"TRANS_TIME"] text];
        
        self.transactionDate = [RGTransaction dateTimeFromTransactionDateString:transactionDateString
                                                                     timeString:transactionTimeString];
        self.normal =       [[[element child:@"IS_NORM"] text] isEqualToString:@"Y"];
        self.serviceClass = [[element child:@"SERVICE_CLASS"] text];
        self.currency =     [[element child:@"TRANS_CURR"] text];
        self.amount =       [[element child:@"AMOUNT"] textAsDouble];
        self.feeAmount =    [[element child:@"FEE_AMOUNT"] textAsDouble];
        self.accountAmount = [[element child:@"ACCOUNT_AMOUNT"] textAsDouble];
        self.descriptionValue =  [[element child:@"TRANS_DETAILS"] text];
    }
    return self;
}

+(NSDateFormatter*)sharedDateFormatter{
    static NSDateFormatter* dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    return dateFormatter;
}

+(NSDate*)dateFromTransactionDateString:(NSString*)dateString{
    NSDateFormatter* dateFormatter = [RGTransaction sharedDateFormatter];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];

    return [dateFormatter dateFromString:dateString];
}

+(NSDate*)dateTimeFromTransactionDateString:(NSString*)dateString timeString:(NSString*)timeString{
    NSDateFormatter* dateFormatter = [RGTransaction sharedDateFormatter];
    [dateFormatter setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
    
    NSString* dateTimeString = [NSString stringWithFormat:@"%@ %@",timeString,dateString];
    return [dateFormatter dateFromString:dateTimeString];
}

@end
