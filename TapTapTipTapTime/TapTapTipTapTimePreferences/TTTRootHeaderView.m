#import "TTTRootHeaderView.h"

@implementation TTTRootHeaderView

- (instancetype)initWithSpecifier:(PSSpecifier*)specifier {

	self = [super init];

	UIImage *headerImage = [UIImage imageNamed:@"header" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
	_aspectRatio = headerImage.size.width / headerImage.size.height;
	_headerImageView = [[UIImageView alloc] initWithImage:headerImage];
	[self addSubview:_headerImageView];

	return self;

}

- (void)setFrame:(CGRect)frame {

	[super setFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];

	CGFloat xOffset = (frame.size.width - _currentWidth) / 2;

	[_headerImageView setFrame:CGRectMake(xOffset, 20, _currentWidth, frame.size.height + 35)];

}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {

	_currentWidth = width;
	CGFloat height = (width / _aspectRatio);
	return height - 35;

}
@end