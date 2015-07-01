// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DLCity.m instead.

#import "_DLCity.h"

const struct DLCityAttributes DLCityAttributes = {
	.cid = @"cid",
	.country = @"country",
	.desc = @"desc",
	.humidity = @"humidity",
	.icon = @"icon",
	.location = @"location",
	.name = @"name",
	.pressure = @"pressure",
	.temp = @"temp",
};

@implementation DLCityID
@end

@implementation _DLCity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"City";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"City" inManagedObjectContext:moc_];
}

- (DLCityID*)objectID {
	return (DLCityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"humidityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"humidity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"pressureValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pressure"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tempValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic cid;

@dynamic country;

@dynamic desc;

@dynamic humidity;

- (int16_t)humidityValue {
	NSNumber *result = [self humidity];
	return [result shortValue];
}

- (void)setHumidityValue:(int16_t)value_ {
	[self setHumidity:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveHumidityValue {
	NSNumber *result = [self primitiveHumidity];
	return [result shortValue];
}

- (void)setPrimitiveHumidityValue:(int16_t)value_ {
	[self setPrimitiveHumidity:[NSNumber numberWithShort:value_]];
}

@dynamic icon;

@dynamic location;

@dynamic name;

@dynamic pressure;

- (int16_t)pressureValue {
	NSNumber *result = [self pressure];
	return [result shortValue];
}

- (void)setPressureValue:(int16_t)value_ {
	[self setPressure:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePressureValue {
	NSNumber *result = [self primitivePressure];
	return [result shortValue];
}

- (void)setPrimitivePressureValue:(int16_t)value_ {
	[self setPrimitivePressure:[NSNumber numberWithShort:value_]];
}

@dynamic temp;

- (float)tempValue {
	NSNumber *result = [self temp];
	return [result floatValue];
}

- (void)setTempValue:(float)value_ {
	[self setTemp:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveTempValue {
	NSNumber *result = [self primitiveTemp];
	return [result floatValue];
}

- (void)setPrimitiveTempValue:(float)value_ {
	[self setPrimitiveTemp:[NSNumber numberWithFloat:value_]];
}

@end

