#import <UIKit/UIKit.h>

#undef ABS
#undef MIN
#undef MAX

#include "mupdf/fitz.h"

#import "MuOutlineController.h"
#import "MuDocRef.h"
#import "MuDialogCreator.h"
#import "MuUpdater.h"

#define GAP 20

enum
{
	BARMODE_MAIN,
	BARMODE_SEARCH,
	BARMODE_MORE,
	BARMODE_ANNOTATION,
	BARMODE_HIGHLIGHT,
	BARMODE_UNDERLINE,
	BARMODE_STRIKE,
	BARMODE_INK,
	BARMODE_DELETE
};

@interface MuDocumentController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate, MuDialogCreator, MuUpdater>

@property (nonatomic, strong) UIScrollView *canvas;
@property (nonatomic, assign) fz_document *doc;
@property (assign) int current; // currently visible page
@property (assign) int width; // current screen size
@property (assign) int height;


- (instancetype) initWithFilename: (NSString*)nsfilename path:(NSString *)path document:(MuDocRef *)aDoc;
- (void) createPageView: (int)number;
- (void) gotoPage: (int)number animated: (BOOL)animated;
- (void) onShowOutline: (id)sender;
- (void) onShowSearch: (id)sender;
- (void) onCancel: (id)sender;
- (void) resetSearch;
- (void) showSearchResults: (int)count forPage: (int)number;
- (void) onSlide: (id)sender;
- (void) onTap: (UITapGestureRecognizer*)sender;
- (void) showNavigationBar;
- (void) hideNavigationBar;

// Added for e-dicola
- (void) onDoubleTap: (UITapGestureRecognizer*)sender;
@end
