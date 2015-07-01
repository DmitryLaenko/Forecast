// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DLForecast.h instead.

#import <CoreData/CoreData.h>

extern const struct DLForecastAttributes {
	__unsafe_unretained NSString *dataTime;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *humidity;
	__unsafe_unretained NSString *icon;
	__unsafe_unretained NSString *pressure;
	__unsafe_unretained NSString *temp;
} DLForecastAttributes;

extern const struct DLForecastRelationships {
	__unsafe_unretained NSString *city;
} DLForecastRelationships;

@class DLCity;

@interface DLForecastID : NSManagedObjectID {}
@end

@interface _DLForecast : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DLForecastID* objectID;

@property (nonatomic, strong) NSDate* dataTime;

//- (BOOL)validateDataTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* desc;

//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* humidity;

@property (atomic) int16_t humidityValue;
- (int16_t)humidityValue;
- (void)setHumidityValue:(int16_t)value_;

//- (BOOL)validateHumidity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* icon;

//- (BOOL)validateIcon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* pressure;

@property (atomic) int16_t pressureValue;
- (int16_t)pressureValue;
- (void)setPressureValue:(int16_t)value_;

//- (BOOL)validatePressure:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* temp;

@property (atomic) float tempValue;
- (float)tempValue;
- (void)setTempValue:(float)value_;

//- (BOOL)validateTemp:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) DLCity *city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;

@end

@interface _DLForecast (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDataTime;
- (void)setPrimitiveDataTime:(NSDate*)value;

- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;

- (NSNumber*)primitiveHumidity;
- (void)setPrimitiveHumidity:(NSNumber*)value;

- (int16_t)primitiveHumidityValue;
- (void)setPrimitiveHumidityValue:(int16_t)value_;

- (NSString*)primitiveIcon;
- (void)setPrimitiveIcon:(NSString*)value;

- (NSNumber*)primitivePressure;
- (void)setPrimitivePressure:(NSNumber*)value;

- (int16_t)primitivePressureValue;
- (void)setPrimitivePressureValue:(int16_t)value_;

- (NSNumber*)primitiveTemp;
- (void)setPrimitiveTemp:(NSNumber*)value;

- (float)primitiveTempValue;
- (void)setPrimitiveTempValue:(float)value_;

- (DLCity*)primitiveCity;
- (void)setPrimitiveCity:(DLCity*)value;

@end
