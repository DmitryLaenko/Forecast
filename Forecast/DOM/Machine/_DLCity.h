// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DLCity.h instead.

#import <CoreData/CoreData.h>

extern const struct DLCityAttributes {
	__unsafe_unretained NSString *cid;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *humidity;
	__unsafe_unretained NSString *icon;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *pressure;
	__unsafe_unretained NSString *temp;
} DLCityAttributes;

@class DLLocation;

@interface DLCityID : NSManagedObjectID {}
@end

@interface _DLCity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DLCityID* objectID;

@property (nonatomic, strong) NSString* cid;

//- (BOOL)validateCid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* desc;

//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* humidity;

@property (atomic) int16_t humidityValue;
- (int16_t)humidityValue;
- (void)setHumidityValue:(int16_t)value_;

//- (BOOL)validateHumidity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* icon;

//- (BOOL)validateIcon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) DLLocation* location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

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

@end

@interface _DLCity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCid;
- (void)setPrimitiveCid:(NSString*)value;

- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;

- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;

- (NSNumber*)primitiveHumidity;
- (void)setPrimitiveHumidity:(NSNumber*)value;

- (int16_t)primitiveHumidityValue;
- (void)setPrimitiveHumidityValue:(int16_t)value_;

- (NSString*)primitiveIcon;
- (void)setPrimitiveIcon:(NSString*)value;

- (DLLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(DLLocation*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePressure;
- (void)setPrimitivePressure:(NSNumber*)value;

- (int16_t)primitivePressureValue;
- (void)setPrimitivePressureValue:(int16_t)value_;

- (NSNumber*)primitiveTemp;
- (void)setPrimitiveTemp:(NSNumber*)value;

- (float)primitiveTempValue;
- (void)setPrimitiveTempValue:(float)value_;

@end
