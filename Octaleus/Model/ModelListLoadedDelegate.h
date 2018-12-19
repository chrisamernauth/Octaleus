

#import <Foundation/Foundation.h>

@protocol ModelListLoadedDelegate <NSObject>

-(void)ModelListLoadedSuccessfullyRequstTag:(NSString *)tag;
-(void)ModelListLoadFailWithError:(NSString *)error;

@end
