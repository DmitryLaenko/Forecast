// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DLForecast.m instead.

#import "_DLForecast.h"

const struct DLForecastAttributes DLForecastAttributes = {
	.dataTime = @"dataTime",
	.desc = @"desc",
	.humidity = @"humidity",
	.icon = @"icon",
	.pressure = @"pressure",
	.temp = @"temp",
};

const struct DLForecastRelationships DLForecastRelationships = {
	.city = @"city",
};

@implementation DLForecastID
@end

@implementation _DLForecast

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Forecast" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Forecast";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Forecast" inManagedObjectContext:moc_];
}

- (DLForecastID*)objectID {
	return (DLForecastID*)[super objectID];
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

@dynamic dataTime;

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

@dynamic city;

@end

