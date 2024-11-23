#import <UIKit/UIKit.h>

@interface MTMaterialLayer : CALayer
@property (nonatomic, copy, readwrite) NSString *recipeName;
@property (atomic, assign, readonly) CGRect visibleRect;
@end

@interface CALayer ()
@property (atomic, assign, readwrite) id unsafeUnretainedDelegate;
@end

CGFloat calculatedRadius(CGRect visibleRect, CGFloat radius) {
    CGFloat width = visibleRect.size.width;
    CGFloat height = visibleRect.size.height;

	if (CGSizeEqualToSize(visibleRect.size, [UIScreen mainScreen].bounds.size) || width <= 60 || height <= 60) {
        return radius;
    }

    if (width == height && height <= 76) {
        return floor(width / 2);
    }

    return 25;
}

%hook MTMaterialLayer
- (CGFloat)cornerRadius {
    NSArray <NSString *> *titles = @[@"modules", @"moduleFill.highlight.generatedRecipe"];

    if (![titles containsObject:self.recipeName]) {
        return %orig;
    }

    CGFloat radius = %orig;

    return calculatedRadius(self.visibleRect, radius);
}
%end

%hook CALayer
- (CGFloat)cornerRadius {
    if (![self.superlayer.unsafeUnretainedDelegate isKindOfClass:NSClassFromString(@"CCUIButtonModuleView")]) {
        return %orig;
    }

    CGFloat radius = %orig;

    return calculatedRadius(self.visibleRect, radius);
}
%end