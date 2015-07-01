//
//  DLMacroses.h
//  Forecast
//
//  Created by Dmitry Laenko on 30/06/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#ifndef Forecast_DLMacroses_h
#define Forecast_DLMacroses_h

#define kDocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

#ifdef DEBUG
#define FNLog(sel, frmt, ...) NSLog(@"[%@]: %@", NSStringFromSelector(sel), [NSString stringWithFormat:frmt, ##__VA_ARGS__]);
#else
#define FNLog(sel, frmt, ...) /* */
#endif

#define FSLog(...)                FNLog(_cmd, __VA_ARGS__)

#define IS_NOT_NULL(o)\
(o && (![o isEqual:[NSNull null]]) && (![o isEqual:@"<null>"]) )

#define IS_NULL(o)\
(o==nil || ([o isEqual:[NSNull null]]) && ([o isEqual:@"<null>"]) )

#define RESULT_FAILED_BLOCK(r, c, e, b)\
if (e) {FSLog(@"Error: %@", [(e) localizedDescription]); if (b) { b((r),(c),(e));} }\
if (c) {FSLog(@"Canсelled"); if (b){ b((r),(c),(e)); } }

#define RESULT_SUCCESS_BLOCK(r, b)\
if (b) { b((r),(NO),(nil)); }

#define RESULT_CANCELLED_BLOCK(b)\
if (b) { b((nil),(YES),(nil)); }


#define STRING(o)\
[o isKindOfClass:[NSNumber class]]?[o stringValue]:\
[o isKindOfClass:[NSString class]]?o:@""

#define INTEGER(o)\
(([o isKindOfClass:[NSNumber class]] || [o isKindOfClass:[NSString class]])?([o integerValue]):0)

#define FLOAT(o)\
(([o isKindOfClass:[NSNumber class]] || [o isKindOfClass:[NSString class]])?([o floatValue]):0.0f)

#endif
