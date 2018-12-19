//
//  KLGeneralUtilities.h
//  KitLocate
//
//  Created by Hadar Dubin on 10/8/13.
//
//

#import <Foundation/Foundation.h>
#import "KLGeofence.h"
#import "KLLocationValue.h"

@interface KLGeneralUtilities : NSObject


// Local Push creation

/*! Create and show local notification immediatly. The app should not be in foreground to show the nofitication.
 * \param strPushText The message will be shown in the nofitication
 * \param strImage dentifies the image used as the launch image when the user taps (or slides) the action button (or slider). Can be @""
 * \param nBadge the number to show in the badge. 0 - Don't show anything
 * \param strSound The name of the file containing the sound to play when an alert is displayed. Can be @""
 */
+(void) createPushWithText:(NSString*) strPushText ImageName:(NSString *)strImage IconBadge:(int)nBadge SoundName:(NSString *)strSound;
+(void) createPushWithText:(NSString*) strPushText ImageName:(NSString *)strImage IconBadge:(int)nBadge SoundName:(NSString *)strSound UserInfo:(NSDictionary *)dicUserInfo TimeIntervalSinceNowInSeconds:(NSTimeInterval)timeInterval;
+(void) createPushWithText: (NSString*) strPushText ImageName:(NSString *)strImage IconBadge:(int)nBadge SoundName:(NSString *)strSound UserInfo:(NSDictionary *)dicUserInfo TimeIntervalSinceNowInSeconds:(NSTimeInterval)timeInterval withAlertTitle:(NSString *)strAlertTitile AlertButtonTitle:(NSString *)strAlertButtonTitle AlertCancelButtonTitle:(NSString *)strAlertCancelButton AlertDelegate:(id)delegate;

// Push Managment Approval

/*! Use Kitlocate smart notifications BI logic. Required dedicated support on KitLocate's web server.
 */
+(NSArray *)requestPushManagementApprovalWithGeofences:(NSArray *)arrGeofences; 

/*! get previous push data in case Kitlocate smart notifications BI logic is used. Required dedicated support on KitLocate's web server.
 */
+(NSArray *)getLastPushManagementApprovalWithGeofences;

// Location helpers

/*! Calcalute distance in meters between a geofence and a location value.
 */
+(double)getDistanceBetweenGeofence:(KLGeofence*)geofence andLocation:(KLLocationValue*)location;

// Background permissions

/*! Keep your application active when running on the background.
 * Use this function when invoking async thread from one of Kitlocate's callbacks (For example: performing async server communication from geofencesIn callback will require this function).
 * Call this function before invoking the async thread.
 * You don't have to call this function if you don't create async thread inside Kitlocate's callbacks.
 * Try to avoid very long actions on the background. 
 * Call unregisterKitLocateBackgroundPermission when your thread's action is finished to free system resources.
 * The permission will stop when calling unregisterKitLocateBackgroundPermission. 
 * Note: register background permission without unregister may cause the app to stop running.
 */
+(void)registerKitLocateBackgroundPermission;
/*! Stop keeping your application active (which started by registerKitLocateBackgroundPermission). 
 * Call this function when you finish your background thread to free system resources.
*/
+(void)unregisterKitLocateBackgroundPermission;

// APP STATE

/*! Tells you the app's state
 * \return true if app in background or suspended mode. false if active.
*/
+ (bool)isOnBackground;


@end
