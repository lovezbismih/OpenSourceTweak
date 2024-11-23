#line 1 "Tweak.xm"























#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UITextInput.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <objc/runtime.h>
#import <version.h>


#pragma mark - Headers


@class UIKeyboardTaskExecutionContext;

@interface UIKeyboardTaskQueue : NSObject
@property(retain, nonatomic) UIKeyboardTaskExecutionContext *executionContext;

-(BOOL)isMainThreadExecutingTask;
-(void)performTask:(id)arg1;
-(void)waitUntilAllTasksAreFinished;
-(void)addDeferredTask:(id)arg1;
-(void)addTask:(id)arg1;
-(void)promoteDeferredTaskIfIdle;
-(void)performDeferredTaskIfIdle;
-(void)performTaskOnMainThread:(id)arg1 waitUntilDone:(void)arg2;
-(void)finishExecution;
-(void)continueExecutionOnMainThread;
-(void)unlock;
-(BOOL)tryLockWhenReadyForMainThread;
-(void)lockWhenReadyForMainThread;
-(void)lock;
@end

@interface UIKeyboardTaskExecutionContext : NSObject
@property(readonly, nonatomic) UIKeyboardTaskQueue *executionQueue;

-(void)transferExecutionToMainThreadWithTask:(id)arg1;
-(void)returnExecutionToParent;
-(id)childWithContinuation:(id)arg1;
-(id)initWithParentContext:(id)arg1 continuation:(id)arg2;
-(id)initWithExecutionQueue:(id)arg1;
@end







@protocol UITextInputPrivate <UITextInput, UITextInputTokenizer> 
-(BOOL)shouldEnableAutoShift;
-(NSRange)selectionRange;
-(CGRect)rectForNSRange:(NSRange)nsrange;
-(NSRange)_markedTextNSRange;





-(void)moveBackward:(unsigned)backward;
-(void)moveForward:(unsigned)forward;
-(unsigned short)characterBeforeCaretSelection;
-(id)wordContainingCaretSelection;
-(id)wordRangeContainingCaretSelection;
-(id)markedText;
-(void)setMarkedText:(id)text;
-(BOOL)hasContent;
-(void)selectAll;
-(id)textColorForCaretSelection;
-(id)fontForCaretSelection;
-(BOOL)hasSelection;
@end




@interface UIKBShape : NSObject
@end

@interface UIKBKey : UIKBShape
@property(copy) NSString * name;
@property(copy) NSString * representedString;
@property(copy) NSString * displayString;
@property(copy) NSString * displayType;
@property(copy) NSString * interactionType;
@property(copy) NSString * variantType;

@property(copy) NSString * overrideDisplayString;
@property(copy) NSString * clientVariantRepresentedString;
@property(copy) NSString * clientVariantActionName;
@property BOOL visible;
@property BOOL hidden;
@property BOOL disabled;
@property BOOL isGhost;
@property int splitMode;
@end



@interface UIKBTree : NSObject <NSCopying>
+(id)keyboard;
+(id)key;
+(id)shapesForControlKeyShapes:(id)arg1 options:(int)arg2;
+(id)mergeStringForKeyName:(id)arg1;
+(BOOL)shouldSkipCacheString:(id)arg1;
+(id)stringForType:(int)arg1;
+(id)treeOfType:(int)arg1;
+(id)uniqueName;

@property(retain, nonatomic) NSString *layoutTag;
@property(retain, nonatomic) NSMutableDictionary *cache;
@property(retain, nonatomic) NSMutableArray *subtrees;
@property(retain, nonatomic) NSMutableDictionary *properties;
@property(retain, nonatomic) NSString *name;
@property(nonatomic) int type;

-(int)flickDirection;

- (BOOL)isLeafType;
- (BOOL)usesKeyCharging;
- (BOOL)usesAdaptiveKeys;
- (BOOL)modifiesKeyplane;
- (BOOL)avoidsLanguageIndicator;
- (BOOL)isAlphabeticPlane;
- (BOOL)noLanguageIndicator;
- (BOOL)isLetters;
- (BOOL)subtreesAreOrdered;

@end


@interface UIKeyboardLayout : UIView
-(UIKBKey*)keyHitTest:(CGPoint)point;
-(long long)idiom;
@end

@interface UIKeyboardLayoutStar : UIKeyboardLayout

-(id)keyHitTest:(CGPoint)arg1;
-(id)keyHitTestWithoutCharging:(CGPoint)arg1;
-(id)keyHitTestClosestToPoint:(CGPoint)arg1;
-(id)keyHitTestContainingPoint:(CGPoint)arg1;

-(BOOL)SS_shouldSelect;
-(BOOL)SS_disableSwipes;
-(BOOL)SS_isKanaKey;
-(BOOL)isShiftKeyBeingHeld;
-(void)deleteAction;
@end


@interface UIKeyboardImpl : UIView
+(UIKeyboardImpl*)sharedInstance;
+(UIKeyboardImpl*)activeInstance;
@property (readonly, assign, nonatomic) UIResponder <UITextInputPrivate> *privateInputDelegate;
@property (readonly, assign, nonatomic) UIResponder <UITextInput> *inputDelegate;
-(BOOL)isLongPress;
-(id)_layout;
-(BOOL)callLayoutIsShiftKeyBeingHeld;
-(void)handleDelete;
-(void)handleDeleteAsRepeat:(BOOL)repeat;
-(void)handleDeleteWithNonZeroInputCount;
-(void)stopAutoDelete;
-(BOOL)handwritingPlane;

-(void)updateForChangedSelection;


-(void)_KHKeyboardGestureDidPan:(UIPanGestureRecognizer*)gesture;
-(void)SS_revealSelection:(UIView*)inputView;
@property (nonatomic,strong) UIPanGestureRecognizer *SS_pan;

@property (nonatomic,retain) id feedbackBehavior;
@property (nonatomic,retain) id feedbackGenerator;
-(void)playKeyClickSound:(BOOL)arg1 ;
-(void)playDeleteKeyFeedback:(BOOL)arg1 ;
@end


@interface UIFieldEditor : NSObject
+(UIFieldEditor*)sharedFieldEditor;
-(void)revealSelection;
@end








@interface UIView(Private_text) <UITextInput>

-(void)_scrollRectToVisible:(CGRect)visible animated:(BOOL)animated;
-(void)scrollSelectionToVisible:(BOOL)visible;


-(CGRect)caretRect;
-(void)_scrollRectToVisible:(CGRect)visible animated:(BOOL)animated;

-(NSRange)selectedRange;
-(NSRange)selectionRange;
-(void)setSelectedRange:(NSRange)range;
-(void)setSelectionRange:(NSRange)range;
-(void)scrollSelectionToVisible:(BOOL)arg1;
-(CGRect)rectForSelection:(NSRange)range;
-(CGRect)textRectForBounds:(CGRect)rect;
@end



@interface WKContentView : UIView
-(void)moveByOffset:(NSInteger)offset;
-(id)_moveLeft:(BOOL)arg1 withHistory:(id)arg2 ;
-(id)_moveRight:(BOOL)arg1 withHistory:(id)arg2 ;
@end

@interface UIResponder()
-(id)interactionAssistant;
@end

@interface UITextInteractionAssistant : NSObject
-(id)selectionView;
@end

@interface UITextSelectionView
- (void)showCalloutBarAfterDelay:(double)arg1;
@end


@interface UIDevice()
-(void)_playSystemSound:(unsigned)arg1 ;
@end

@interface _UIKeyboardFeedbackGenerator : UIFeedbackGenerator
-(void)_playFeedbackForActionType:(long long)arg1 withCustomization:(id)arg2 ;
@end

@interface _UIFeedbackKeyboardBehavior : UIFeedbackGenerator
-(void)_playFeedbackForActionType:(long long)arg1 withCustomization:(id)arg2 ;
@end

#pragma mark - Helper functions

UITextPosition *KH_MovePositionDirection(id <UITextInput, UITextInputTokenizer> tokenizer, UITextPosition *startPosition, UITextDirection direction){
	if (tokenizer && startPosition) {
		return [tokenizer positionFromPosition:startPosition inDirection:direction offset:1];
	}
	return nil;
}

UITextPosition *KH_tokenizerMovePositionWithGranularitInDirection(id <UITextInput, UITextInputTokenizer> tokenizer, UITextPosition *startPosition, UITextGranularity granularity, UITextDirection direction){

	if (tokenizer && startPosition) {
		return [tokenizer positionFromPosition:startPosition toBoundary:granularity inDirection:direction];
	}

	return nil;
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__asm__(".linker_option \"-framework\", \"CydiaSubstrate\"");

@class UIKeyboardImpl; @class UIKeyboardLayoutStar; @class WKContentView; @class _UIKeyboardTextSelectionInteraction; 
static UIKeyboardImpl* (*_logos_orig$_ungrouped$UIKeyboardImpl$initWithFrame$)(_LOGOS_SELF_TYPE_INIT UIKeyboardImpl*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static UIKeyboardImpl* _logos_method$_ungrouped$UIKeyboardImpl$initWithFrame$(_LOGOS_SELF_TYPE_INIT UIKeyboardImpl*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static UIKeyboardImpl* (*_logos_orig$_ungrouped$UIKeyboardImpl$initWithFrame$forCustomInputView$)(_LOGOS_SELF_TYPE_INIT UIKeyboardImpl*, SEL, CGRect, BOOL) _LOGOS_RETURN_RETAINED; static UIKeyboardImpl* _logos_method$_ungrouped$UIKeyboardImpl$initWithFrame$forCustomInputView$(_LOGOS_SELF_TYPE_INIT UIKeyboardImpl*, SEL, CGRect, BOOL) _LOGOS_RETURN_RETAINED; static void _logos_method$_ungrouped$UIKeyboardImpl$SS_KeyboardGestureDidPan$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST, SEL, UIPanGestureRecognizer*); static void _logos_method$_ungrouped$UIKeyboardImpl$SS_revealSelection$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST, SEL, UIView*); static BOOL (*_logos_orig$_ungrouped$UIKeyboardImpl$isLongPress)(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$UIKeyboardImpl$isLongPress(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$UIKeyboardImpl$handleDelete)(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$UIKeyboardImpl$handleDelete(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$UIKeyboardImpl$handleDeleteAsRepeat$executionContext$)(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST, SEL, BOOL, UIKeyboardTaskExecutionContext*); static void _logos_method$_ungrouped$UIKeyboardImpl$handleDeleteAsRepeat$executionContext$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST, SEL, BOOL, UIKeyboardTaskExecutionContext*); static void (*_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesBegan$withEvent$)(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL, NSSet *, UIEvent *); static void _logos_method$_ungrouped$UIKeyboardLayoutStar$touchesBegan$withEvent$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL, NSSet *, UIEvent *); static void (*_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesMoved$withEvent$)(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL, NSSet *, UIEvent *); static void _logos_method$_ungrouped$UIKeyboardLayoutStar$touchesMoved$withEvent$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL, NSSet *, UIEvent *); static void (*_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesCancelled$withEvent$)(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$UIKeyboardLayoutStar$touchesCancelled$withEvent$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesEnded$withEvent$)(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL, NSSet *, UIEvent *); static void _logos_method$_ungrouped$UIKeyboardLayoutStar$touchesEnded$withEvent$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL, NSSet *, UIEvent *); static BOOL _logos_method$_ungrouped$UIKeyboardLayoutStar$SS_shouldSelect(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$UIKeyboardLayoutStar$SS_disableSwipes(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$UIKeyboardLayoutStar$SS_isKanaKey(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$_UIKeyboardTextSelectionInteraction$gestureRecognizerShouldBegin$)(_LOGOS_SELF_TYPE_NORMAL _UIKeyboardTextSelectionInteraction* _LOGOS_SELF_CONST, SEL, UIGestureRecognizer *); static BOOL _logos_method$_ungrouped$_UIKeyboardTextSelectionInteraction$gestureRecognizerShouldBegin$(_LOGOS_SELF_TYPE_NORMAL _UIKeyboardTextSelectionInteraction* _LOGOS_SELF_CONST, SEL, UIGestureRecognizer *); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$WKContentView(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WKContentView"); } return _klass; }
#line 283 "Tweak.xm"
BOOL KH_positionsSame(id <UITextInput, UITextInputTokenizer> tokenizer, UITextPosition *position1, UITextPosition *position2){
	if([tokenizer isKindOfClass:[_logos_static_class_lookup$WKContentView() class]]) return position1==position2;
	return ([tokenizer comparePosition:position1 toPosition:position2] == NSOrderedSame);
}






Class AKFlickGestureRecognizer(){
	static Class AKFlickGestureRecognizer_Class = nil;
	static BOOL checked = NO;
	
	if (!checked) {
		AKFlickGestureRecognizer_Class = objc_getClass("AKFlickGestureRecognizer");
	}
	
	return AKFlickGestureRecognizer_Class;
}


#pragma mark - GestureRecognizer
@interface SSPanGestureRecognizer : UIPanGestureRecognizer
@end

#pragma mark - GestureRecognizer implementation
@implementation SSPanGestureRecognizer
-(BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer{
	
	if ([preventingGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
		([preventingGestureRecognizer isKindOfClass:AKFlickGestureRecognizer()] == NO))
	{
		return YES;
	}
	
	return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
	return NO;
}
@end







#pragma mark - Hooks


__attribute__((used)) static UIPanGestureRecognizer * _logos_property$_ungrouped$UIKeyboardImpl$SS_pan(UIKeyboardImpl * __unused self, SEL __unused _cmd) { return (UIPanGestureRecognizer *)objc_getAssociatedObject(self, (void *)_logos_property$_ungrouped$UIKeyboardImpl$SS_pan); }; __attribute__((used)) static void _logos_property$_ungrouped$UIKeyboardImpl$setSS_pan(UIKeyboardImpl * __unused self, SEL __unused _cmd, UIPanGestureRecognizer * rawValue) { objc_setAssociatedObject(self, (void *)_logos_property$_ungrouped$UIKeyboardImpl$SS_pan, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static UIKeyboardImpl* _logos_method$_ungrouped$UIKeyboardImpl$initWithFrame$(_LOGOS_SELF_TYPE_INIT UIKeyboardImpl* __unused self, SEL __unused _cmd, CGRect rect) _LOGOS_RETURN_RETAINED{
	id orig = _logos_orig$_ungrouped$UIKeyboardImpl$initWithFrame$(self, _cmd, rect);

	if (orig){
		SSPanGestureRecognizer *pan = [[SSPanGestureRecognizer alloc] initWithTarget:self action:@selector(SS_KeyboardGestureDidPan:)];
		pan.cancelsTouchesInView = NO;
		[self addGestureRecognizer:pan];
		[self setSS_pan:pan];
	}

	return orig;
}
static UIKeyboardImpl* _logos_method$_ungrouped$UIKeyboardImpl$initWithFrame$forCustomInputView$(_LOGOS_SELF_TYPE_INIT UIKeyboardImpl* __unused self, SEL __unused _cmd, CGRect arg1, BOOL arg2) _LOGOS_RETURN_RETAINED {
	id orig = _logos_orig$_ungrouped$UIKeyboardImpl$initWithFrame$forCustomInputView$(self, _cmd, arg1, arg2);

	if (orig){
		SSPanGestureRecognizer *pan = [[SSPanGestureRecognizer alloc] initWithTarget:self action:@selector(SS_KeyboardGestureDidPan:)];
		pan.cancelsTouchesInView = NO;
		[self addGestureRecognizer:pan];
		[self setSS_pan:pan];
	}

	return orig;
}


static void _logos_method$_ungrouped$UIKeyboardImpl$SS_KeyboardGestureDidPan$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIPanGestureRecognizer* gesture){
	
	static UITextRange *startingtextRange = nil;
	static CGPoint previousPosition;
	
	
	static CGFloat xOffset = 0;
	static CGPoint realPreviousPosition;

	
	static BOOL shiftHeldDown = NO;
	static BOOL hasStarted = NO;
	static BOOL longPress = NO;
	static BOOL handWriting = NO;
	static BOOL haveCheckedHand = NO;
	static BOOL isFirstShiftDown = NO; 
	static BOOL isMoreKey = NO;
	static BOOL isKanaKey = NO;
	static int touchesWhenShiting = 0;
	static BOOL cancelled = NO;

	int touchesCount = [gesture numberOfTouches];

	UIKeyboardImpl *keyboardImpl = self;

	if ([keyboardImpl respondsToSelector:@selector(isLongPress)]) {
		BOOL nLongTouch = [keyboardImpl isLongPress];
		if (nLongTouch) {
			longPress = nLongTouch;
		}
	}
	
	
	id currentLayout = nil;
	if ([keyboardImpl respondsToSelector:@selector(_layout)]) {
		currentLayout = [keyboardImpl _layout];
	}
	
	
	if ([currentLayout respondsToSelector:@selector(SS_disableSwipes)] && !isMoreKey) {
		isMoreKey = [currentLayout SS_disableSwipes];
	}
	
	
	if ([currentLayout respondsToSelector:@selector(handwritingPlane)] && !haveCheckedHand) {
		handWriting = [currentLayout handwritingPlane];
	}
	else if ([currentLayout respondsToSelector:@selector(subviews)] && !handWriting && !haveCheckedHand) {
		NSArray *subviews = [((UIView*)currentLayout) subviews];
		for (UIView *subview in subviews) {

			if ([subview respondsToSelector:@selector(subviews)]) {
				NSArray *arrayToCheck = [subview subviews];

				for (id view in arrayToCheck) {
					NSString *classString = [NSStringFromClass([view class]) lowercaseString];
					NSString *substring = [@"Handwriting" lowercaseString];

					if ([classString rangeOfString:substring].location != NSNotFound) {
						handWriting = YES;
						break;
					}
				}
			}
		}
		haveCheckedHand = YES;
	}
	haveCheckedHand = YES;
	
	
	
	
	if ([currentLayout respondsToSelector:@selector(SS_shouldSelect)] && !shiftHeldDown) {
		shiftHeldDown = [currentLayout SS_shouldSelect];
		isFirstShiftDown = YES;
		touchesWhenShiting = touchesCount;
	}

	if ([currentLayout respondsToSelector:@selector(SS_isKanaKey)]) {
		isKanaKey = [currentLayout SS_isKanaKey];
	}
	
	
	
	id <UITextInputPrivate> privateInputDelegate = nil;
	if ([keyboardImpl respondsToSelector:@selector(privateInputDelegate)]) {
		privateInputDelegate = (id)keyboardImpl.privateInputDelegate;
	}
	if (!privateInputDelegate && [keyboardImpl respondsToSelector:@selector(inputDelegate)]) {
		privateInputDelegate = (id)keyboardImpl.inputDelegate;
	}

	
	if (privateInputDelegate != nil && [NSStringFromClass([privateInputDelegate class]) isEqualToString:@"VBEmoticonsContentTextView"]) {
		privateInputDelegate = nil;
		cancelled = YES; 
	}
	
	
	
	
	
	
	
	if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
		
		if (hasStarted)
		{
			if ([privateInputDelegate respondsToSelector:@selector(selectedTextRange)]) {
				UITextRange *range = [privateInputDelegate selectedTextRange];
				if (range && !range.empty) {
					UITextInteractionAssistant *assistant = [(UIResponder*)privateInputDelegate interactionAssistant];
					if(assistant){
						[[assistant selectionView] showCalloutBarAfterDelay:0];
					}
					else{
						CGRect screenBounds = [UIScreen mainScreen].bounds;
						CGRect rect = CGRectMake(screenBounds.size.width * 0.5, screenBounds.size.height * 0.5, 1, 1);

						if ([privateInputDelegate respondsToSelector:@selector(firstRectForRange:)]) {
							rect = [privateInputDelegate firstRectForRange:range];
						}

						UIView *view = nil;
						if ([privateInputDelegate isKindOfClass:[UIView class]]) {
							view = (UIView*)privateInputDelegate;
						}
						else if ([privateInputDelegate respondsToSelector:@selector(inputDelegate)]) {
							id v = [keyboardImpl inputDelegate];
							if (v != privateInputDelegate) {
								if ([v isKindOfClass:[UIView class]]) {
									view = (UIView*)v;
								}
							}
						}
						
						UIMenuController *menu = [UIMenuController sharedMenuController];
						[menu setTargetRect:rect inView:view];
						[menu setMenuVisible:YES animated:YES];
					}
				}
			}
			
			
			if ([keyboardImpl respondsToSelector:@selector(updateForChangedSelection)]) {
				[keyboardImpl updateForChangedSelection];
			}
		}
		

		shiftHeldDown = NO;
		isMoreKey = NO;
		longPress = NO;
		hasStarted = NO;
		handWriting = NO;
		haveCheckedHand = NO;
		cancelled = NO;

		touchesCount = 0;
		touchesWhenShiting = 0;
		gesture.cancelsTouchesInView = NO;
	}
	else if (longPress || handWriting || !privateInputDelegate || isMoreKey || isKanaKey || cancelled) {
		return;
	}
	else if (gesture.state == UIGestureRecognizerStateBegan) {
		xOffset = 0;
		
		previousPosition = [gesture locationInView:self];
		realPreviousPosition = previousPosition;

		if ([privateInputDelegate respondsToSelector:@selector(selectedTextRange)]) {
			startingtextRange = [privateInputDelegate selectedTextRange];
		}
	}
	else if (gesture.state == UIGestureRecognizerStateChanged) {
		UITextRange *currentRange = startingtextRange;
		if ([privateInputDelegate respondsToSelector:@selector(selectedTextRange)]) {
			currentRange = nil;
			currentRange = [privateInputDelegate selectedTextRange];
		}

		CGPoint position = [gesture locationInView:self];
		CGPoint delta = CGPointMake(position.x - previousPosition.x, position.y - previousPosition.y);
		
		
		CGFloat deadZone = 18;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			deadZone = 30;
		}
		
		
		if (hasStarted == NO && ABS(delta.y) > deadZone) {
			if (ABS(delta.y) > ABS(delta.x)) {
				cancelled = YES;
			}
		}
		if ((hasStarted == NO && delta.x < deadZone && delta.x > (-deadZone)) || cancelled) {
			return;
		}
		
		
		gesture.cancelsTouchesInView = YES;
		hasStarted = YES;

		
		CGFloat positiveX = ABS(delta.x);
		

		
		UITextDirection textDirection;
		if (delta.x < 0) {
			textDirection = UITextStorageDirectionBackward;
		}
		else {
			textDirection = UITextStorageDirectionForward;
		}


		
		CGFloat xMinimum = 10;
		

		CGFloat neededTouches = 2;
		if (shiftHeldDown && (touchesWhenShiting >= 2)) {
			neededTouches = 3;
		}

		UITextGranularity granularity = UITextGranularityCharacter;
		
		if (touchesCount >= neededTouches) {
			
			granularity = UITextGranularityWord;
			xMinimum = 20;
		}

		
		BOOL extendRange = shiftHeldDown;

		static UITextPosition *pivotPoint = nil;

		
		UITextPosition *positionStart = currentRange.start;
		UITextPosition *positionEnd = currentRange.end;

		
		UITextPosition *_position = nil;

		
		if (isFirstShiftDown) {
			if (delta.x > 0 || delta.y < -20) {
				pivotPoint = positionStart;
			}
			else {
				pivotPoint = positionEnd;
			}
		}
		if (extendRange && pivotPoint) {
			
			BOOL startIsPivot = KH_positionsSame(privateInputDelegate, pivotPoint, positionStart);
			if (startIsPivot) {
				_position = positionEnd;
			}
			else {
				_position = positionStart;
			}
		}
		else {
			_position = (delta.x > 0) ? positionEnd : positionStart;

			if (!pivotPoint) {
				pivotPoint = _position;
			}
		}


		
		if ([privateInputDelegate baseWritingDirectionForPosition:_position inDirection:UITextStorageDirectionForward] == UITextWritingDirectionRightToLeft) {
			if (textDirection == UITextStorageDirectionForward){
				textDirection = UITextStorageDirectionBackward;
			}
			else {
				textDirection = UITextStorageDirectionForward;
			}
		}

		
		
		id <UITextInputTokenizer, UITextInput> tokenizer = nil;
		if ([privateInputDelegate respondsToSelector:@selector(positionFromPosition:toBoundary:inDirection:)]) {
			tokenizer = privateInputDelegate;
		}
		else if ([privateInputDelegate respondsToSelector:@selector(tokenizer)]) {
			tokenizer = (id <UITextInput, UITextInputTokenizer>)privateInputDelegate.tokenizer;
		}
		
		if (tokenizer) {
			
			if (positiveX >= 1) {
				UITextPosition *_position_old = _position;
				
				if (granularity == UITextGranularityCharacter &&
					[tokenizer respondsToSelector:@selector(positionFromPosition:inDirection:offset:)] &&
					NO) {
					_position = KH_MovePositionDirection(tokenizer, _position, textDirection);
				}
				else {
					_position = KH_tokenizerMovePositionWithGranularitInDirection(tokenizer, _position, granularity, textDirection);
				}
				
				
				
				if (!_position){ _position = _position_old; }

				
				if (granularity == UITextGranularityWord && (KH_positionsSame(privateInputDelegate, currentRange.start, _position) &&
										!KH_positionsSame(privateInputDelegate, privateInputDelegate.beginningOfDocument, _position))) {
				
					_position = KH_tokenizerMovePositionWithGranularitInDirection(tokenizer, _position, UITextGranularityCharacter, textDirection);
					xMinimum = 4;
				}

				
				if (!_position || positiveX < xMinimum){
					_position = _position_old;
				}
			}
			
			
			
			


			
			
			
			
			
			
			
			
			
			
		}

		if (!extendRange && _position) {
			pivotPoint = _position;
		}

		
		UITextRange *textRange = startingtextRange = nil;
		if ([privateInputDelegate respondsToSelector:@selector(textRangeFromPosition:toPosition:)]) {
			if([privateInputDelegate comparePosition:_position toPosition:pivotPoint] == NSOrderedAscending){
				textRange = [privateInputDelegate textRangeFromPosition:_position toPosition:pivotPoint];
			}
			else{
				textRange = [privateInputDelegate textRangeFromPosition:pivotPoint toPosition:_position];
			}
		}

		CGPoint oldPrevious = previousPosition;
		
		if (positiveX > xMinimum) { 
			
			
			previousPosition = position;
		}

		isFirstShiftDown = NO;
		
		
		
		
		
		
		BOOL webView = [NSStringFromClass([privateInputDelegate class]) isEqualToString:@"WKContentView"];
		if (webView) {
			xOffset += (position.x - realPreviousPosition.x);
			
			if (ABS(xOffset) >= xMinimum) {
				BOOL positive = (xOffset > 0);
				int offset = (ABS(xOffset) / xMinimum);
				BOOL isSelecting = pivotPoint!=_position;

				for (int i = 0; i < offset; i++) {
					if(positive){
						[(WKContentView*)privateInputDelegate _moveRight:isSelecting withHistory:nil];
					}
					else{
						[(WKContentView*)privateInputDelegate _moveLeft:isSelecting withHistory:nil];
					}
				}
				
				xOffset += (positive ? -(offset * xMinimum) : (offset * xMinimum));
			}
			[self SS_revealSelection:(UIView*)privateInputDelegate];
		}
		
		
		
		
		
		if (textRange && (oldPrevious.x != previousPosition.x || oldPrevious.y != previousPosition.y)) {
			[privateInputDelegate setSelectedTextRange:textRange];
			[self SS_revealSelection:(UIView*)privateInputDelegate];
		}
		
		realPreviousPosition = position;
	}
}


static void _logos_method$_ungrouped$UIKeyboardImpl$SS_revealSelection$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIView* inputView){
	UIFieldEditor *fieldEditor = [objc_getClass("UIFieldEditor") sharedFieldEditor];
	if (fieldEditor && [fieldEditor respondsToSelector:@selector(revealSelection)]) {
		[fieldEditor revealSelection];
	}
	
	if ([inputView respondsToSelector:@selector(_scrollRectToVisible:animated:)]) {
		if ([inputView respondsToSelector:@selector(caretRect)]) {
			CGRect caretRect = [inputView caretRect];
			[inputView _scrollRectToVisible:caretRect animated:NO];
		}
	}
	else if ([inputView respondsToSelector:@selector(scrollSelectionToVisible:)]) {
		[inputView scrollSelectionToVisible:YES];
	}
}



















static BOOL shiftByOtherKey = NO;
static BOOL isLongPressed = NO;
static BOOL isDeleteKey = NO;
static BOOL isMoreKey = NO;
static BOOL isKanaKey = NO;
static BOOL g_deleteOnlyOnce;
static int g_availableDeleteTimes;
static NSSet<NSString*> *kanaKeys;



static void _logos_method$_ungrouped$UIKeyboardLayoutStar$touchesBegan$withEvent$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSSet * touches, UIEvent * event) {
	UITouch *touch = [touches anyObject];
	
	UIKBKey *keyObject = [self keyHitTest:[touch locationInView:touch.view]];
	NSString *key = [[keyObject representedString] lowercaseString];

	
	
	
	if ([key isEqualToString:@"delete"]) {
		isDeleteKey = YES;
	}
	else {
		isDeleteKey = NO;
	}
	
	
	
	if ([key isEqualToString:@"more"]) {
		isMoreKey = YES;
	}
	else {
		isMoreKey = NO;
	}

	if ([kanaKeys containsObject:key]) {
		isKanaKey = YES;
	}
	else {
		isKanaKey = NO;
	}

	g_deleteOnlyOnce=NO;
	
	
	_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesBegan$withEvent$(self, _cmd, touches, event);
}


static void _logos_method$_ungrouped$UIKeyboardLayoutStar$touchesMoved$withEvent$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSSet * touches, UIEvent * event) {
	UITouch *touch = [touches anyObject];
	
	UIKBKey *keyObject = [self keyHitTest:[touch locationInView:touch.view]];
	NSString *key = [[keyObject representedString] lowercaseString];
	
	
	
	if ([key isEqualToString:@"delete"] ||
		[key isEqualToString:@"ء"]) {
		shiftByOtherKey = YES;
	}
	
	
	if ([key isEqualToString:@"more"]) {
		isMoreKey = YES;
	}
	else {
		isMoreKey = NO;
	}
	
	
	_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesMoved$withEvent$(self, _cmd, touches, event);
}

static void _logos_method$_ungrouped$UIKeyboardLayoutStar$touchesCancelled$withEvent$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
	_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesCancelled$withEvent$(self, _cmd, arg1, arg2);
	
	shiftByOtherKey = NO;
	isLongPressed = NO;
	isMoreKey = NO;
}


static void _logos_method$_ungrouped$UIKeyboardLayoutStar$touchesEnded$withEvent$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSSet * touches, UIEvent * event) {
	_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesEnded$withEvent$(self, _cmd, touches, event);
	
	isDeleteKey = NO;
	
	UITouch *touch = [touches anyObject];
	NSString *key = [[[self keyHitTest:[touch locationInView:touch.view]] representedString] lowercaseString];
	
	
	
	if ([key isEqualToString:@"delete"] && !isLongPressed && !isKanaKey) {
		g_deleteOnlyOnce = YES;
		g_availableDeleteTimes = 1;
		UIKeyboardImpl *kb = [UIKeyboardImpl activeInstance];
		if ([kb respondsToSelector:@selector(handleDelete)]) {
			[kb handleDelete];
		}
		else if ([kb respondsToSelector:@selector(handleDeleteAsRepeat:)]) {
			[kb handleDeleteAsRepeat:NO];
		}
		else if ([kb respondsToSelector:@selector(handleDeleteWithNonZeroInputCount)]) {
			[kb handleDeleteWithNonZeroInputCount];
		}
	}
	
	
	shiftByOtherKey = NO;
	isLongPressed = NO;
	isMoreKey = NO;
}













static BOOL _logos_method$_ungrouped$UIKeyboardLayoutStar$SS_shouldSelect(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	return ([self isShiftKeyBeingHeld] || shiftByOtherKey);
}


static BOOL _logos_method$_ungrouped$UIKeyboardLayoutStar$SS_disableSwipes(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	return isMoreKey;
}


static BOOL _logos_method$_ungrouped$UIKeyboardLayoutStar$SS_isKanaKey(_LOGOS_SELF_TYPE_NORMAL UIKeyboardLayoutStar* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	return isKanaKey;
}










static BOOL _logos_method$_ungrouped$UIKeyboardImpl$isLongPress(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	isLongPressed = _logos_orig$_ungrouped$UIKeyboardImpl$isLongPress(self, _cmd);
	return isLongPressed;
}


static void _logos_method$_ungrouped$UIKeyboardImpl$handleDelete(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	if (!isLongPressed && isDeleteKey) {
		
	}
	else {
		_logos_orig$_ungrouped$UIKeyboardImpl$handleDelete(self, _cmd);
	}
}

static void _logos_method$_ungrouped$UIKeyboardImpl$handleDeleteAsRepeat$executionContext$(_LOGOS_SELF_TYPE_NORMAL UIKeyboardImpl* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL repeat, UIKeyboardTaskExecutionContext* executionContext){
	
	isLongPressed = repeat;
	if ((!isLongPressed && isDeleteKey)
		|| (g_deleteOnlyOnce && g_availableDeleteTimes<=0)) {
		if([[self _layout] respondsToSelector:@selector(idiom)])
		{
			if([(UIKeyboardLayout *)[self _layout] idiom] == 2){
				[[UIDevice currentDevice] _playSystemSound:1123LL];
			}
			else{
				if(IS_IOS_OR_NEWER(iOS_16_0)) {}
				else if(IS_IOS_OR_NEWER(iOS_14_0)) [self playDeleteKeyFeedback:repeat];
				else if(IS_IOS_OR_NEWER(iOS_13_0)) [self playKeyClickSound:repeat];
				else if(IS_IOS_OR_NEWER(iOS_11_0)) [[self feedbackGenerator] _playFeedbackForActionType:3 withCustomization:nil];
				else if(IS_IOS_OR_NEWER(iOS_10_0)){
					[[self feedbackBehavior] _playFeedbackForActionType:3 withCustomization:nil];
				}
			}
		}
		[[executionContext executionQueue] finishExecution];
		return;
	}
	
	if(g_deleteOnlyOnce) g_availableDeleteTimes--;

	_logos_orig$_ungrouped$UIKeyboardImpl$handleDeleteAsRepeat$executionContext$(self, _cmd, repeat, executionContext);
}





@interface _UIKeyboardTextSelectionInteraction
- (id)owner;
@end

static BOOL _logos_method$_ungrouped$_UIKeyboardTextSelectionInteraction$gestureRecognizerShouldBegin$(_LOGOS_SELF_TYPE_NORMAL _UIKeyboardTextSelectionInteraction* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIGestureRecognizer * gestureRecognizer){
    id delegate = [[self owner] delegate];
    if([delegate respondsToSelector:@selector(SS_pan)] && [[delegate SS_pan] state] == UIGestureRecognizerStateChanged) return NO;
    return _logos_orig$_ungrouped$_UIKeyboardTextSelectionInteraction$gestureRecognizerShouldBegin$(self, _cmd, gestureRecognizer);
}
 

static __attribute__((constructor)) void _logosLocalCtor_a441c5ec(int __unused argc, char __unused **argv, char __unused **envp){
	kanaKeys = [NSSet setWithArray:@[@"あ",@"か",@"さ",@"た",@"な",@"は",@"ま",@"や",@"ら",@"わ",@"、"]];
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIKeyboardImpl = objc_getClass("UIKeyboardImpl"); { objc_property_attribute_t _attributes[16]; unsigned int attrc = 0; _attributes[attrc++] = (objc_property_attribute_t) { "T", "@\"UIPanGestureRecognizer\"" }; _attributes[attrc++] = (objc_property_attribute_t) { "&", "" }; _attributes[attrc++] = (objc_property_attribute_t) { "N", "" }; class_addProperty(_logos_class$_ungrouped$UIKeyboardImpl, "SS_pan", _attributes, attrc); size_t _nBytes = 1024; char _typeEncoding[_nBytes]; snprintf(_typeEncoding, _nBytes, "%s@:", @encode(UIPanGestureRecognizer *)); class_addMethod(_logos_class$_ungrouped$UIKeyboardImpl, @selector(SS_pan), (IMP)&_logos_property$_ungrouped$UIKeyboardImpl$SS_pan, _typeEncoding); snprintf(_typeEncoding, _nBytes, "v@:%s", @encode(UIPanGestureRecognizer *)); class_addMethod(_logos_class$_ungrouped$UIKeyboardImpl, @selector(setSS_pan:), (IMP)&_logos_property$_ungrouped$UIKeyboardImpl$setSS_pan, _typeEncoding); } { MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardImpl, @selector(initWithFrame:), (IMP)&_logos_method$_ungrouped$UIKeyboardImpl$initWithFrame$, (IMP*)&_logos_orig$_ungrouped$UIKeyboardImpl$initWithFrame$);}{ MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardImpl, @selector(initWithFrame:forCustomInputView:), (IMP)&_logos_method$_ungrouped$UIKeyboardImpl$initWithFrame$forCustomInputView$, (IMP*)&_logos_orig$_ungrouped$UIKeyboardImpl$initWithFrame$forCustomInputView$);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIPanGestureRecognizer*), strlen(@encode(UIPanGestureRecognizer*))); i += strlen(@encode(UIPanGestureRecognizer*)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIKeyboardImpl, @selector(SS_KeyboardGestureDidPan:), (IMP)&_logos_method$_ungrouped$UIKeyboardImpl$SS_KeyboardGestureDidPan$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIView*), strlen(@encode(UIView*))); i += strlen(@encode(UIView*)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIKeyboardImpl, @selector(SS_revealSelection:), (IMP)&_logos_method$_ungrouped$UIKeyboardImpl$SS_revealSelection$, _typeEncoding); }{ MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardImpl, @selector(isLongPress), (IMP)&_logos_method$_ungrouped$UIKeyboardImpl$isLongPress, (IMP*)&_logos_orig$_ungrouped$UIKeyboardImpl$isLongPress);}{ MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardImpl, @selector(handleDelete), (IMP)&_logos_method$_ungrouped$UIKeyboardImpl$handleDelete, (IMP*)&_logos_orig$_ungrouped$UIKeyboardImpl$handleDelete);}{ MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardImpl, @selector(handleDeleteAsRepeat:executionContext:), (IMP)&_logos_method$_ungrouped$UIKeyboardImpl$handleDeleteAsRepeat$executionContext$, (IMP*)&_logos_orig$_ungrouped$UIKeyboardImpl$handleDeleteAsRepeat$executionContext$);}Class _logos_class$_ungrouped$UIKeyboardLayoutStar = objc_getClass("UIKeyboardLayoutStar"); { MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardLayoutStar, @selector(touchesBegan:withEvent:), (IMP)&_logos_method$_ungrouped$UIKeyboardLayoutStar$touchesBegan$withEvent$, (IMP*)&_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesBegan$withEvent$);}{ MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardLayoutStar, @selector(touchesMoved:withEvent:), (IMP)&_logos_method$_ungrouped$UIKeyboardLayoutStar$touchesMoved$withEvent$, (IMP*)&_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesMoved$withEvent$);}{ MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardLayoutStar, @selector(touchesCancelled:withEvent:), (IMP)&_logos_method$_ungrouped$UIKeyboardLayoutStar$touchesCancelled$withEvent$, (IMP*)&_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesCancelled$withEvent$);}{ MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardLayoutStar, @selector(touchesEnded:withEvent:), (IMP)&_logos_method$_ungrouped$UIKeyboardLayoutStar$touchesEnded$withEvent$, (IMP*)&_logos_orig$_ungrouped$UIKeyboardLayoutStar$touchesEnded$withEvent$);}{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIKeyboardLayoutStar, @selector(SS_shouldSelect), (IMP)&_logos_method$_ungrouped$UIKeyboardLayoutStar$SS_shouldSelect, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIKeyboardLayoutStar, @selector(SS_disableSwipes), (IMP)&_logos_method$_ungrouped$UIKeyboardLayoutStar$SS_disableSwipes, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIKeyboardLayoutStar, @selector(SS_isKanaKey), (IMP)&_logos_method$_ungrouped$UIKeyboardLayoutStar$SS_isKanaKey, _typeEncoding); }Class _logos_class$_ungrouped$_UIKeyboardTextSelectionInteraction = objc_getClass("_UIKeyboardTextSelectionInteraction"); { MSHookMessageEx(_logos_class$_ungrouped$_UIKeyboardTextSelectionInteraction, @selector(gestureRecognizerShouldBegin:), (IMP)&_logos_method$_ungrouped$_UIKeyboardTextSelectionInteraction$gestureRecognizerShouldBegin$, (IMP*)&_logos_orig$_ungrouped$_UIKeyboardTextSelectionInteraction$gestureRecognizerShouldBegin$);}} }
#line 1023 "Tweak.xm"
