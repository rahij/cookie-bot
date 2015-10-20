/*globals svgEditor*/

svgEditor.setConfig({
extensions: [
	// 'ext-eyedropper.js',
	// 'ext-shapes.js',
	// 'ext-polygon.js',
	// 'ext-star.js'
],
//emptyStorageOnDecline: true
	allowedOrigins: [window.location.origin], // May be 'null' (as a string) when used as a file:// URL
  showRulers: false,
  no_save_warning: true,
  noDefaultExtensions: true,
  show_outside_canvas: false,
  extPath: 'js/extensions/',
  langPath: 'js/locale/',
});
